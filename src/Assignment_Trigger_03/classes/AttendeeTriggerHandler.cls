/**
 * Purpose : Implement the count of Training Session attended by Attendee on Contact
 * 
 * Created By : Yatika Dewaskar
 * 
 * Created Date : 12/08/2024
 * 
 * Revision Logs : V1 Created
 * 
**/

public class AttendeeTriggerHandler {
    /**
     * Purpose : Method to implement the count of Training Session attended by Attendee when new attendee is add or the details are updated or the attendee is deleted
     * 
     * Params : List<Attendee__c> , List<Attendee__c>
     * 
     * Return : Void
     * 
     * Created By : Yatika Dewaskar
     * 
     * Created Date : 12/08/2024
     * 
     * Revision Logs : V1 Created
     * 
    **/
    public static void updateTrainingSessionCountonContact(List<Attendee__c> newAttendee, List<Attendee__c> oldAttendee){
        
        // Map to store id of contact and count of training session
        Map<Id, Integer> contactTrainingCount = new Map<Id, Integer>();
        Set<Id> trainingSessionids = new Set<Id>();
        
        // when new attendeee is added 
        if( newAttendee != Null){
            for(Attendee__c attendee : newAttendee ){
                
                if(attendee.Contact__c != Null && attendee.Training_Session__c != Null){
                    
                    if(!contactTrainingCount.containsKey(attendee.Contact__c)){
                  		  contactTrainingCount.put(attendee.Contact__c,0 );
                          
                    }  
                    
                    contactTrainingCount.put(attendee.Contact__c,contactTrainingCount.get(attendee.Contact__c)+1);
                }
            }
        }
        // when old attendee id updated and count is decrease 
         if( oldAttendee != Null){
             
            for(Attendee__c attendee : oldAttendee ){
                
                if(attendee.Contact__c!= Null && attendee.Training_Session__c != Null){
                    
                     if(!contactTrainingCount.containsKey(attendee.Contact__c)){
                  		  contactTrainingCount.put(attendee.Contact__c,0);
                    }  
                    
                    contactTrainingCount.put(attendee.Contact__c,contactTrainingCount.get(attendee.Contact__c)-1);
                }
            }
        }
        
        //updating the count on record
        
        List<Contact> contactToUpdate = [SELECT Id, Total_Enrolled_Training_Sessions__c FROM Contact WHERE Id In :contactTrainingCount.keySet()];
        
        for(Contact contact : contactToUpdate ){
            
            Integer count = contactTrainingCount.get(contact.Id);
            
              contact.Total_Enrolled_Training_Sessions__c = (contact.Total_Enrolled_Training_Sessions__c != Null ? contact.Total_Enrolled_Training_Sessions__c : 0) +count;
            
            }     
        
        if(!contactToUpdate.isEmpty()){
            update contactToUpdate;
        }
    }
   
}