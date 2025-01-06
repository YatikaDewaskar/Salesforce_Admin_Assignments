/**
 * Purpose : Manage all events on Contact
 * 
 * Created By : Yatika Dewaskar
 * 
 * Created Date : 12/30/2024
 * 
 * Revision Logs : V1 Created
 * 
**/
Trigger ContactTrigger on Contact (before insert, before update, before delete, after insert, after update, after delete, after undelete ) {
      
/*    if(Trigger.isBefore){
        
        if(Trigger.isInsert || Trigger.isUpdate ){
            ContactTriggerHandler.updateTheContactAddresswithAccount(Trigger.New);
            
        }
        
    }  */
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            ContactTriggerHandler.sendMailNotification(Trigger.New);
        }
        if(Trigger.isUpdate){
            ContactTriggerHandler.despUpdateofAccount(Trigger.New, Trigger.OldMap);
        }
    }
    
    if(Trigger.isBefore)
    {
        if(Trigger.isInsert)
        {
            ContactTriggerHandler.fetchObjectNameWithDetailsofPicklistValues(Trigger.New, Null);   
        }
        
        if(Trigger.isUpdate)
        {
            ContactTriggerHandler.fetchObjectNameWithDetailsofPicklistValues(Trigger.New, Trigger.OldMap);
        }
        
    }

}