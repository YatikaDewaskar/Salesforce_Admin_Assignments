@isTest
public class AttendeeTriggerHandlerTest {
	
    @testSetup
    static void createTestData(){
        List<Contact> contactList = new List<Contact>();
        Contact contact1 = new Contact(LastName= 'Foundation One');
        contactList.add(contact1);
		Contact contact2 = new Contact(LastName= 'Foundation two'); 
        contactList.add(contact2);
        insert contactList;
            
        Training_Session__c trainingSession1 = new Training_Session__c(Name = 'Java');
		Training_Session__c trainingSession2 = new Training_Session__c(Name = 'CPP');  
        insert new List<Training_Session__c>{trainingSession1, trainingSession2};

                 
    }
     @isTest
    static void testAddAttendeePositiveTest(){
       
            List<Contact> contact1 = [SELECT Id, Total_Enrolled_Training_Sessions__c FROM Contact];
            // System.debug(contact1[0]);
            //System.debug(contact1[1]);
            List<Training_Session__c> trainingSession1 = [SELECT Id, Name FROM Training_Session__c ];
           // System.debug(contact1[0]);
           // System.debug(contact1[1]);
              
              List<Attendee__c>attendeeList = new List<Attendee__c>();
             Attendee__c att1 = new Attendee__c(Contact__c = contact1[0].Id, Email__c = 'atttendee1@gmail.com', Training_Session__c=  trainingSession1[0].Id );
            attendeeList.add(att1);
             Attendee__c att2 = new Attendee__c(Contact__c = contact1[0].Id, Email__c = 'atttendee2@gmail.com', Training_Session__c = trainingSession1[0].Id);
            attendeeList.add(att2);
             Attendee__c att3 = new Attendee__c(Contact__c = contact1[1].Id, Email__c = 'atttendee3@gmail.com', Training_Session__c = trainingSession1[1].Id);
             attendeeList.add(att3);
             Attendee__c att4 = new Attendee__c(Contact__c = contact1[1].Id, Email__c = 'atttendee4@gmail.com', Training_Session__c = trainingSession1[1].Id);
            attendeeList.add(att4);
                             
            test.startTest();
            insert attendeeList;
            contact1 = [SELECT Id, Total_Enrolled_Training_Sessions__c FROM Contact];
            Assert.areEqual(2 ,contact1[0].Total_Enrolled_Training_Sessions__c);
            Assert.areEqual(2,contact1[1].Total_Enrolled_Training_Sessions__c);

            test.stopTest();
           
    }
     @isTest
    static void testAddAttendeeNegativeTest(){
        try{
            List<Contact> contact1 = [SELECT Id, Total_Enrolled_Training_Sessions__c FROM Contact];
            List<Training_Session__c> trainingSession1 = [SELECT Id, Name FROM Training_Session__c ];
            List<Attendee__c>attendeeList = new List<Attendee__c>();
             Attendee__c att1 = new Attendee__c(Contact__c = contact1[0].Id, Email__c = 'atttendee1@gmail.com', Training_Session__c=  trainingSession1[0].Id );
            attendeeList.add(att1);
             Attendee__c att2 = new Attendee__c(Contact__c = contact1[0].Id, Email__c = 'atttendee2@gmail.com', Training_Session__c = trainingSession1[0].Id);
            attendeeList.add(att2);
                             
            test.startTest();
            insert attendeeList;
            contact1 = [SELECT Id, Total_Enrolled_Training_Sessions__c FROM Contact];
            Assert.areEqual(3 ,contact1[0].Total_Enrolled_Training_Sessions__c);
            test.stopTest();
        }
        catch(Exception e){
            String error = e.getMessage();
            System.debug(error);
        }
           
    }

    @isTest
    static void testUpdateAttendeePositiveTest() {
     
           List<Contact> contact1 = [SELECT Id, Total_Enrolled_Training_Sessions__c FROM Contact];
           List<Attendee__c> attendee = [SELECT Email__c , Training_Session__c FROM Attendee__c];
           attendee[0].Training_Session__c = 'CPP';
           attendee[2].Contact__c = contact1[1].Id;
           update attendee;
             
            contact1 = [SELECT Id, Total_Enrolled_Training_Sessions__c FROM Contact];
            Assert.areEqual(1, contact1[0].Total_Enrolled_Training_Sessions__c, 'Foundation One have 1 training sessions');
            Assert.areEqual(3, contact1[1].Total_Enrolled_Training_Sessions__c, 'Foundation two  have 3 training sessions');
      
            
     }
  
     
    @isTest
    static void testUpdateAttendeeNegativeTest() {
      
        try{
            List<Contact> contact1 = [SELECT Id, Total_Enrolled_Training_Sessions__c FROM Contact];
           List<Attendee__c> attendee = [SELECT Email__c, Training_Session__c FROM Attendee__c];
           attendee[0].Training_Session__c = 'Java';
           attendee[2].Contact__c = contact1[1].Id;
           update attendee;
             
            contact1 = [SELECT Id, Total_Enrolled_Training_Sessions__c FROM Contact];
           Assert.areEqual(3, contact1[0].Total_Enrolled_Training_Sessions__c, 'Foundation One have 1 training sessions');
           Assert.areEqual(2, contact1[1].Total_Enrolled_Training_Sessions__c, 'Foundation two  have 3 training sessions');
      
            
        }
        catch(Exception ex){
             String error = ex.getMessage();
            System.debug(error);
        }
        
        }
    
  @isTest
    static void testDeleteAttendeePositiveTest(){
      
             List<Contact> contact1 = [SELECT Id, Total_Enrolled_Training_Sessions__c FROM Contact];
              List<Attendee__c> attendeeToDelete = new List<Attendee__c>([SELECT Id, Email__c FROM Attendee__c WHERE Email__c = 'atttendee4@gmail.com']);
                 
               test.startTest();
              delete attendeeToDelete;
              contact1 = [SELECT Id,LastName, Total_Enrolled_Training_Sessions__c FROM Contact WHERE LastName = 'Foundation Two' ];
  			  Assert.areEqual(1,contact1[1].Total_Enrolled_Training_Sessions__c, 'Foundation Two have 1 attendee');
              test.stopTest();

     }
       
 
    
 @isTest
    static void testDeleteAttendeeNegativeTest(){
        try{
            List<Contact> contact1 = [SELECT Id, Total_Enrolled_Training_Sessions__c FROM Contact];
            List<Attendee__c> attendeeToDelete = new List<Attendee__c>();
            Attendee__c att1=[SELECT Id, Email__c FROM Attendee__c WHERE Email__c = 'atttendee2@gmail.com'];
            attendeeToDelete.add(att1);
            test.startTest();
            delete attendeeToDelete;
            contact1 = [SELECT Id,LastName, Total_Enrolled_Training_Sessions__c FROM Contact WHERE LastName = 'Foundation Two' ];
           
           Assert.areEqual(1,contact1[0].Total_Enrolled_Training_Sessions__c, 'Foundation Two have 1 attendee');
             test.stopTest();
        }
        catch(Exception ex){
            String error = ex.getMessage();
            System.debug(error);
        }
    }



}