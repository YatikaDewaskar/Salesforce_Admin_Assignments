/**
 * Description : Created this class for implementing DML Operations and SOQL Queries
 *
 * Created By : Yatika Dewaskar
 * 
 * Created Date : 11/27/2024
 * 
 * Revision Logs : V1 Created
 * 
 **/
public without sharing class TrainingSessionManager {
    /*
    * Description : Method to create new record and insert into database 
    * Created By : Yatika Dewaskar
    * Created Date : 11/27/2024
    * Return type : void 
    * Revision Logs : V1 Created 
    */
    public void createTrainingSessionRecords(){
        try{
            List<Training_Session__c> trainingSessionList = new List<Training_Session__c>();
            for(Integer i = 0 ; i<5 ; i++){
                Training_Session__c tsc = new Training_Session__c(Name = 'Training Session'+i , Location__c = 'Jaipur');
                trainingSessionList.add(tsc);
            }
            insert trainingSessionList;
        }
        catch(DmlException e){
            System.debug('Exception has Occured '+e.getMessage());
        }
    }
    /*
    * Description : Method to Update Training_Session__c records.

    * Created By : Yatika Dewaskar
    * Created Date : 11/27/2024
    * Return type : void 
    * Revision Logs : V1 Created 
    */
    public void updateTrainingSessionRecord(){
        try{
            List<Training_Session__c> trainingSessionList = [SELECT Name FROM Training_Session__c WHERE Location__c = 'Jaipur'];
            Date d = System.Today() + 30;
            for(Integer i=0; i<10; i++){
                Training_Session__c tsc = new Training_Session__c(Name = 'TrainingSession' + ++i + 'Updated', Session_Date__c = d);
                trainingSessionList.add(tsc);
            }
            update trainingSessionList;
        }
        catch(DmlException e){
            System.debug('Exception has Occured '+e.getMessage());
        }
    }
    /*
    * Description : Method to  delete Training_Session__c records. 
    * Created By : Yatika Dewaskar
    * Created Date : 11/27/2024
    * Return type : void 
    * Revision Logs : V1 Created 
    */
    public void deleteTrainingSessionRecord(){
        try{
            List<Training_Session__c> trainingSessionList = [SELECT Name, Session_Date__c, 	Location__c FROM Training_Session__c WHERE Id = 'a05NS000007T97XYAS'];
            delete trainingSessionList;
        }
        catch(DmlException e){
            System.debug('Exception has Occured '+e.getMessage());
        }
    }
    /*
    * Description : Method to  read Training_Session__c records. 
    * Created By : Yatika Dewaskar
    * Created Date : 11/27/2024
    * Return type : void 
    * Revision Logs : V1 Created 
    */
    public void readTrainingSessionRecord(){
        try{
            List<Training_Session__c> trainingSessionList = [SELECT Name, Session_Date__c, 	Location__c, Average_Rating__c, Total_Attendee_Count__c FROM Training_Session__c ];
            for( Integer i=0; i<10; i++){
                System.debug(trainingSessionList[i]);
            }
        }
        catch(DmlException e){
            System.debug('Exception has Occured '+e.getMessage());
        }
    }
    /*
    * Description : Method to add attendees to a training session, ensuring that each attendee is only added once using a Set<Id>.
    * Created By : Yatika Dewaskar
    * Created Date : 11/27/2024
    * Return type : void 
    * Revision Logs : V1 Created 
    */
    public void addAttendeesToTrainingSession(){
        List<Attendee__c> attendeeList = [SELECT ID, Name, Email__c, Phone__c FROM Attendee__c ];
        // Record ID of Existing Attendee
		Set<Id> attendeeId = (new Map<Id,SObject>(attendeeList)).keySet();
        //System.debug(attendeeId);
        For(Attendee__c attendee : attendeeList){
            Attendee__c att = new Attendee__c(Name = 'Attendee', Training_Session__c = 'a05NS000003cDM0YAM',  Email__c = 'Attendee@gmail.com' );
            if(! attendeeId.contains(att.Id)){
					attendeeList.add(att);                
            }
            else{
                System.debug('Attendee Already Exist');
            }
                
        }
        insert attendeeList;
     }
     /*
    * Description : Method to add attendees to a training session, ensuring that each attendee is only added once using a Set<Id>.
    * Created By : Yatika Dewaskar
    * Created Date : 11/27/2024
    * Return type : void 
    * Revision Logs : V1 Created 
    */
    public enum CategorizeTrainingSessions{
        Webinar, Workshop, Seminar
    }
    /*
    * Description : Method to impletement enum
    * Created By : Yatika Dewaskar
    * Created Date : 11/28/2024
    * Return type : void 
    * Revision Logs : V1 Created 
    */
    public static void addAttendeeToSpecificTypeByEnum(){
        List<Training_Session__c> trainingSessionList = new List<Training_Session__c>();
        categorizeTrainingSessions recordtype = categorizeTrainingSessions.Webinar;
        Training_Session__c tsc = new Training_Session__c(Name = 'Training Session 01 Webinar' , Location__c = 'Jaipur');
        trainingSessionList.add(tsc);
        recordtype = categorizeTrainingSessions.Workshop;
        Training_Session__c tsc1 = new Training_Session__c(Name = 'Training Session 01 Workshop' , Location__c = 'Indore');
        trainingSessionList.add(tsc1);
        insert trainingSessionList;
    }
    /*
    * Description : Method to impletement safely navigates through the relationships of a Training_Session__c record to fetch related Attendee__c records.
    * Created By : Yatika Dewaskar
    * Created Date : 11/27/2024
    * Return type : void 
    * Revision Logs : V1 Created 
    */
     public List<Attendee__c> trainingSessionRecordsRelatedAttendee(){
         return [SELECT Name,(SELECT Name, Email__c, Phone__c FROM Attendees__r) FROM Training_Session__c WHERE Name = 'Java' LIMIT 1 ]?.Attendees__r;
           
    }
    	
    /*
    * Description : SOQL queries to fetch all Training_Session__c records and their related Attendee__c records.
    * Created By : Yatika Dewaskar
    * Created Date : 11/28/2024
    * Return type : void 
    * Revision Logs : V1 Created 
    */
    public void allTrainingSessionRecordsRelatedToAttendeeRecords(){

       List<Training_Session__c> allTrainingSessionRecordsRelatedToAttendeeRecords = [SELECT ID, Name, Location__c, 
          									                                         (SELECT Name, Email__c, Phone__c FROM Attendees__r) 
                                                  									  FROM Training_Session__c];
        System.debug(allTrainingSessionRecordsRelatedToAttendeeRecords);
        
    }
    /*
    * Description : Method to use different custom labels for session types and  generate messages
    * Created By : Yatika Dewaskar
    * Created Date : 11/28/2024
    * Return type : void 
    * Revision Logs : V1 Created 
    */
    public void customLabelForSessionType(){
        String labelVal1 = Label.WebinarType;
        System.debug('LabelForWebinar : ' + labelVal1);
        String labelVal2 = Label.Workshop;
        System.debug('LabelForWorkshop : ' + labelVal2);
    }
    
    /*
   * Description : Query to fetch training sessions based on specific criteria such as date, type, and attendee count.
   * Created By : Yatika Dewaskar
   * Created Date : 11/29/2024
   * Return type : void 
   * Revision Logs : V1 Created 
   */
   public void fetchingRecordBasedOnSpecificCriteria(){
       List<Training_Session__c> trainingList1 = [SELECT Name, Id 
                                                  FROM Training_Session__c 
                                                  WHERE Session_Date__c < TODAY ];
       System.debug(trainingList1);
       
       List<Training_Session__c> trainingList2 = [SELECT Name, Id 
                                                  FROM Training_Session__c 
                                                  WHERE RecordTypeId = '012NS000002AZmXYAW'];
       System.debug(trainingList2);
       
       List<Training_Session__c> trainingList3 = [SELECT Name, Id
                                                  FROM Training_Session__c 
                                                  WHERE Total_Attendee_Count__c >= 2 ];
       System.debug(trainingList3);     
   }
    /*
   * Description : Implementing bulk insert, update, and delete operations on records using Database Classes
   * Created By : Yatika Dewaskar
   * Created Date : 11/29/2024
   * Return type : void 
   * Revision Logs : V1 Created 
   */
   public void bulkRecordHandling(){
        //Database.insert()
        Attendee__c AttendeeObj1 = new Attendee__c(Name = 'Manan',Email__c = 'Mana@gmail.com', Training_Session__c = 'a05NS000003cDM0YAM');
        Attendee__c AttendeeObj2 = new Attendee__c();
        Database.SaveResult[] result = Database.insert(new List<Attendee__c>{AttendeeObj1, AttendeeObj2}, false);
        for(Database.SaveResult res : result){
            if(res.isSuccess()){
                System.debug('Sucessfully inserted the attendee with ID :'+res.getId());
            }
            else{
                for(Database.Error err : res.getErrors()){
                    System.debug('Error has occurred.');
                }
            }
        } 
        
        // Database.update()
        Attendee__c AttendeeObj3 = [SELECT Id, Name FROM Attendee__c WHERE Id = 'a06NS00000OKrmPYAT'];
        AttendeeObj3.Phone__c = '9830938383';
        Database.update(AttendeeObj3);
        
        // Database.delete()
        Attendee__c[] deletedAttendee = [SELECT Id , Name FROM Attendee__c WHERE Id = 'a06NS00000OIqdRYAT' OR Id = 'a06NS00000OLLmnYAH'];
        Database.delete(deletedAttendee);

   }
}