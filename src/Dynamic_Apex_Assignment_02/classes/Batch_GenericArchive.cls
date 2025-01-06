/**
 * Purpose : Batch implementation to archive the data of the given object and send email to User with attached CSV Data file in the email then delete the records from Salesforce.
 * 
 * Created By : Yatika Dewaskar
 * 
 * Created Date : 12/31/2024
 * 
 * Revision Logs : V1 Created
 * 
**/
global class Batch_GenericArchive implements Database.Batchable<sObject>, Database.Stateful
{   
    private string objectName;
    private string csv = '';
    private List<Sobject> objectRecords = new List<Sobject>();
    private List<String> fieldName = new List<String>();
    //to allow test methods to access private or protected members of another class outside the test class.
    @TestVisible static Integer emailsInvocations;
    
    public Batch_GenericArchive(String objectName)
    {
        this.objectName = objectName;
    }
    
     /**
     * Purpose : Method to query the records from metadata 
     * Param : Database.BatchableContext
     * Return type: void
     * Created By : Yatika Dewaskar
     * Created Date : 12/31/2024
     * Revision Logs : V1 Created
     * 
     **/
    global Database.QueryLocator start(Database.BatchableContext bc)
    {   
        List<Archive_Config__mdt> queryOnMetadata = [SELECT Developer_Name__c, Label__c, Duration__c, Filter__c FROM Archive_Config__mdt];
       
        String objectNameApi = null;
        String filter = null;
        Decimal  duration = null;
        for(Archive_Config__mdt objName : queryOnMetadata)
        {
            if(objectName == objName.Developer_Name__c || objectName == objName.Label__c)
            {
               objectNameApi = objName.Developer_Name__c;
               filter =  objName.Filter__c;
               duration = objName.Duration__c;
            }    
        }  

        Date recordDates = Date.today().addMonths(-(Integer)duration);
        System.debug(recordDates);
        String sobjectQuery = 'SELECT Id, Name FROM ' + objectNameApi + ' WHERE ' + filter + ' AND CreatedDate <= :recordDates';
    	
        return Database.getQueryLocator(sobjectQuery);
    }
    
     /**
     * Purpose : Method to get the records from the dynamic query and perform operation on it
     * Param : Database.BatchableContext, List<Sobject>
     * Return type: void
     * Created By : Yatika Dewaskar
     * Created Date : 12/31/2024
     * Revision Logs : V1 Created
     * 
     **/
    global void execute(Database.BatchableContext bc, List<Sobject>scope)
    {    
        System.debug(scope);            
        // CSV create krna h of the fetch records
      	// email bhejna ha  with CSV of deleted records 
      	// feteched record ko delete krna ha 
        Set<Id> recordIds = new Set<Id>();
        for(Sobject obj : scope)
        {
            Schema.SobjectType objName = obj.getSObjectType();
          
      		Schema.DescribeSObjectResult objDes = objName.getDescribe();
            Map<String, Schema.SobjectField> fieldMap = objDes.fields.getMap(); 

            fieldName = new List<String>(fieldMap.keySet());   
            String queryOnRecords = 'SELECT ' + String.join(fieldName,',') + ' FROM ' + objName.getDescribe().getName() + ' WHERE Id IN :scope';
 
        objectRecords  = Database.Query(queryOnRecords);   
        }
    }

	 /**
     * Purpose : Method to perform post processing task
     * Param : Database.BatchableContext
     * Return type: void
     * Created By : Yatika Dewaskar
     * Created Date : 12/31/2024
     * Revision Logs : V1 Created
     * 
     **/
    global void finish(Database.BatchableContext bc)
    {
      System.debug(objectRecords);
      String csv = generateCSV(objectRecords);
        System.debug(csv);
        if(String.isNotBlank(csv))
        {
            sendEmailToUserOwner(csv);
            deleteRecords(objectRecords);
        }
        else
        {
            System.debug('No records found to delete');
        }
    }
    
     /**
     * Purpose : Create Csv file of the records fetched from dynamic query
     * Param : List<Sobject>
     * Return type: string
     * Created By : Yatika Dewaskar
     * Created Date : 12/31/2024
     * Revision Logs : V1 Created
     * 
     **/
    private string generateCSV(List<Sobject> objectRecords)
    {
        if(!objectRecords.isEmpty())
        {
        //header fields
        csv += String.join(fieldName, ',') + '\n';   
        //record to add
        for(Sobject record : objectRecords)
        {
            string row = '';
            for(string field : fieldName)
            {
                Object value = record.get(field);
                //replacing commas to avoid error in csv
                row += (value != null ? value.toString().replace(',',' ') :' ') + ',';
            }
            row = row.substring(0, row.length() - 1);
            csv += row + '\n'; 
        }

        }
        return csv;
    }
    
      /**
     * Purpose : Send email to the user informing about the delete of records with attchement of Csv file of the records
     * Param : String
     * Return type: string
     * Created By : Yatika Dewaskar
     * Created Date : 01/01/2025
     * Revision Logs : V1 Created
     * 
     **/ 
   private void sendEmailToUserOwner(String csv) 
   {
        try
        {
            Messaging.EmailFileAttachment csvAttachment = new Messaging.EmailFileAttachment();
            //blob binary data stored 
            Blob csvBlob = Blob.valueOf(csv);
            String csvFileName = objectName + '_Data.csv';
            csvAttachment.setFileName(csvFileName);
            csvAttachment.setBody(csvBlob);
            
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            String [] toAddresses = new String[]{UserInfo.getUserEmail()};
            String subject = 'CSV File of data to be delete of ' + objectName;
            String context = 'Hello <br/><br/>' + 'Record to be deleted are in the CSV File.<br/> '+ 'CSV File is Attached below ';
            email.setSubject(subject);
            email.setToAddresses(toAddresses);
            email.setPlainTextBody(context);
            email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttachment});
            
            Messaging.SendEmailResult[] res = Messaging.SendEmail(new Messaging.SingleEmailMessage[]{email});
            if(res[0].success)
            {
                System.debug('successfully');         
            }
            else
            {
                System.debug('Email not sended');
            }
            
        }
        catch(Exception ex)
        {
            System.debug('Email not sended' + ex.getMessage());
        } 
        Integer emailsInvocations = Limits.getEmailInvocations();
   }
    
     /**
     * Purpose : Delete the records fetched from the dynamic query
     * Param : List<Sobject>
     * Return type: void
     * Created By : Yatika Dewaskar
     * Created Date : 01/01/2025
     * Revision Logs : V1 Created
     * 
     **/ 
    private void deleteRecords(List<SObject> objectRecords) {
        try {
            if (!objectRecords.isEmpty()) 
            {
                delete objectRecords;  
                System.debug('Records deleted successfully.');
            } 
            else 
            {
                System.debug('No records to delete.');
            }
        } 
        catch (Exception ex) 
        {
            System.debug('Error during delete operation: ' + ex.getMessage());
        }
    }

}