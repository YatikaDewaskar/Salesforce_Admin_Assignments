/**
 * Purpose : Manage all the Events for Contact
 * 
 * Created By : Yatika Dewaskar
 * 
 * Created Date : 12/05/2024
 * 
 * Revision Logs : V1 Created
 * 
 * 
 **/

 trigger ContactAccountTrigger on Contact (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
   
    if(Trigger.isBefore){
        
        if(Trigger.isInsert){
                 ContactAccountHandler.allowRecordsWithOnlySpecificDomain(Trigger.New);            
        }
        
        if(Trigger.isUpdate){
                 ContactAccountHandler.updateRecordsWithEmailandSpecificDomain(Trigger.NEW, Trigger.OLDMAP);
        }   
        
    }
}