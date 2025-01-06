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
