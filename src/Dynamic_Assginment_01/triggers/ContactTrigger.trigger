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
