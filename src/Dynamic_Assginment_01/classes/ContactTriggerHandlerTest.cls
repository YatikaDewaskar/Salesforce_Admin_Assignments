@isTest
public class ContactTriggerHandlerTest {
    
    private static Account createAccount() {
        Account account = new Account(Name = 'Mock Account');
        insert account; 
        return account;
    }
    private static Contact createContact(String recordId) {
        Contact con = new Contact(
            FirstName = 'Demo',
            LastName = 'TestUser',
            Email = 'demouser@example.com',
            Record_ID__c = recordId
        );
        insert con;
        return con;
    }

    @isTest
    public static void testInsertValidContact() {
            Account acc = createAccount();
            Contact newContact = createContact(acc.Id);

            Test.startTest();
            insert newContact;  
            Test.stopTest();

            Contact insertedContact = [SELECT Id, Object_Name__c, Picklist_Field__c FROM Contact WHERE Id = :newContact.Id];

            System.assertNotEquals(insertedContact.Object_Name__c, null, 'Object Name');
            System.assertNotEquals(insertedContact.Picklist_Field__c, null, 'Picklist fields');
    }

    @isTest
    public static void testInsertInvalidContact() {
        try {
            // Create and insert a Contact with an invalid Record_ID__c (non-existent ID)
            Contact newContact = new Contact(
                FirstName = 'Invalid',
                LastName = 'User',
                Email = 'user@example.com',
                Record_ID__c = 'invalid_id' 
            );

            Test.startTest();
            insert newContact; 
            Test.stopTest();
            System.assert(false, 'Expected exception for invalid Record_ID');
            
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('Invalid RecordID'), 'Exception message not as expected: ' + e.getMessage());
        } 
    }

    @isTest
    public static void testUpdateValidContact() {

            Account acc = createAccount();
            Contact existingContact = createContact(acc.Id);
            Account newAcc = createAccount();
            existingContact.Record_ID__c = newAcc.Id;

            Test.startTest();
            update existingContact;  
            Test.stopTest();
            Contact updatedCon = [SELECT Id, Object_Name__c, Picklist_Field__c FROM Contact WHERE Id = :existingContact.Id];

            System.assertNotEquals(updatedCon.Object_Name__c, null, 'Object Name');
            System.assertNotEquals(updatedCon.Picklist_Field__c, null, 'Picklist fields ');

    }

    @isTest
    public static void testUpdateInvalidContact() {
        try {
           
            Contact existingContact = new Contact(
                FirstName = 'Invalid',
                LastName = 'User',
                Email = 'invaliduser@example.com',
                Record_ID__c = 'invalid_id'
            );
            insert existingContact;
            existingContact.Record_ID__c = 'invalid_id';

            Test.startTest();
            update existingContact;  
            Test.stopTest();
            System.assert(false, 'Expected exception for invalid Record_ID');
            
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('Invalid RecordID'), 'Exception message not as expected: ' + e.getMessage());
        } 
    }
}