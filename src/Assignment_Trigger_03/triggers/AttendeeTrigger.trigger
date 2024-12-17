/**
 * Purpose : Manage all events on Attendee
 * 
 * Created By : Yatika Dewaskar
 * 
 * Created Date : 12/08/2024
 * 
 * Revision Logs : V1 Created
 * 
**/

Trigger AttendeeTrigger on Attendee__c (before insert, before Update, before Delete, after Insert, after Update, after Delete){
		
    if(Trigger.isAfter){
        
        if(Trigger.isInsert){
            
            AttendeeTriggerHandler.updateTrainingSessionCountonContact(Trigger.New,Trigger.Old);
          
        }
        
        if(Trigger.isUpdate){
            
       AttendeeTriggerHandler.updateTrainingSessionCountonContact(Trigger.New,Trigger.Old);
        }
        
        if(Trigger.isDelete){
        
            AttendeeTriggerHandler.updateTrainingSessionCountonContact(Trigger.New,Trigger.Old);
        }
        
    }
    
}