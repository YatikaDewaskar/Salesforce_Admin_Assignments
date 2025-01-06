/**
 * Purpose : Implement the dynamic apex 
 * 
 * Created By : Yatika Dewaskar
 * 
 * Created Date : 12/30/2024
 * 
 * Revision Logs : V1 Created
 * 
**/
public class ContactTriggerHandler{
    
    public static void updateTheContactAddresswithAccount(List<Contact> newContact){
        if( !newContact.isEmpty()){
            Set<Id> AccountIdofAssociatedContact = new Set<Id>();
            Map<Id, Account> mapOfAccount = new Map<Id, Account>([SELECT Id, BillingStreet, BillingState, BillingCity, Phone
                                                                  FROM Account WHERE Id IN : AccountIdofAssociatedContact]);
            
            for(Contact con : newContact){
                if(con.AccountId != Null){
                    AccountIdofAssociatedContact.add(con.AccountId);
                }
            }
            for(Contact con : newContact){
                if( !AccountIdofAssociatedContact.isEmpty() && mapOfAccount.containsKey(con.AccountId)){
                    if(con.AccountId !=Null){
                        Account acc = mapOfAccount.get(con.AccountId);
                        con.MailingStreet = acc.BillingStreet;
                        con.MailingState = acc.BillingState;
                        con.MailingCity = acc.BillingCity;
                       
                    }
                }
            }
        
            }
        }
    public static void sendMailNotification(List<Contact> conList){
        List<Messaging.Email> emailList = new List<Messaging.Email>();
        // emailList to store the emails
        for(Contact con : conList){
            if(con.Email != Null){
                Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
                //instance of single email msg
                String[] toAddress = new String[]{con.Email};
                    
                emailMsg.setToAddresses(toAddress);
                // in this toAddress we can pass many addresss
                String emailSubject = 'Welcome' + con.FirstName;
                emailMsg.setSubject(emailSubject);
                
                String displayName = 'Welcome Notification';
                emailMsg.setSenderDisplayName(displayName);
                
                String content = 'Hello ' + con.FirstName + '<br/><br/>' + 'Welcome to  salesforce' + '<br/><br/>' + 'Thank you';
                emailMsg.setHTMLBody(content);
                
                emailList.add(emailMsg);
                System.debug(emailList);
                
            }
        }
        Messaging.sendEmail(emailList);
     
        System.debug('message send ');

    }
    
    
	//----------------------------------------------------
    public static void despUpdateofAccount(List<Contact> newContact, Map<Id,Contact> oldMap){
         if(newContact.isEmpty())
             return;
        Set<Id>accId = new Set<Id>();
       for(Contact con : newContact){
            if(con.Description != oldMap.get(con.Id).Description){
				accId.add(con.AccountId);
            }
        } 
        Map<Id,Account> accDetails = new Map<Id, Account> ([SELECT Id, Description From Account Where Id IN:accId ]);
        List<Account> acctoUpdate= new List<Account>();
        if(!accDetails.isEmpty()){
            for(Contact con : newContact){
                Account acc = accDetails.get(con.AccountId);
                acc.Description = con.Description;
                acctoUpdate.add(acc);
                    
            }
        }
        update accToUpdate;
    }  
    
   
    
 //--------------------------------------------------------------------------------------
  /**
     * Purpose : Method to insert object name of entered recordId and fetch all the picklist values of the object
     * 
     * Created By : Yatika Dewaskar
     * 
     * Created Date : 12/30/2024
     * 
     * Revision Logs : V1 Created
     * 
    **/    
public static void fetchObjectNameWithDetailsofPicklistValues(List<Contact> newContact, Map<Id, Contact> oldMap) 
{
    if (newContact.isEmpty()) 
        return;

    for (Contact con : newContact) {
        try {
            String recordId = con.Record_ID__c;

            if (String.isNotBlank(recordId)) 
            {
                if (recordId instanceof Id) 
                {
                    
                    Schema.sObjectType sObjType = Id.valueOf(recordId).getSObjectType();
                    System.debug(sObjType);

                    if (sObjType != null) 
                    {
                        Schema.DescribeSObjectResult objDescribe = sObjType.getDescribe();
                        System.debug(objDescribe);
                        
                        if (objDescribe != null)
                        {
                            con.Object_Name__c = objDescribe.getName();
                        }

                        // Get all fields 
                        Map<String, Schema.SObjectField> fieldMap = objDescribe.fields.getMap();
                        System.debug(fieldMap);
                        List<String> picklistDataList = new List<String>(); 

                        for (String fieldName : fieldMap.keySet()) 
                        {
                            Schema.SObjectField field = fieldMap.get(fieldName);
                            System.debug(field);
                            Schema.DescribeFieldResult fieldDes = field.getDescribe();
                            System.debug(fieldDes);
                           
                            if (fieldDes.getType() == Schema.DisplayType.Picklist) 
                            {
                                picklistDataList.add(fieldName);
                            }
                        }

                        if (!picklistDataList.isEmpty()) 
                        {
                            con.Picklist_Field__c = String.join(picklistDataList, '\n');
                        }
                        else
                        {
                            con.Picklist_Field__c = null;
                        }
                    }
                } else 
                {
                    con.addError('Invalid RecordID');
                }
            }
        } catch (Exception ex) 
        {
            con.addError('Invalid RecordID: ' + ex.getMessage());
        }
    }
}


}