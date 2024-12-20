@isTest
public class AddPrimaryContactTest {
    
    @testSetup
    static void setup() {
        List<Account> accountOne = new List<Account>();
        List<Account> accountTwo = new List<Account>();
        for(Integer i=0 ; i<50;i++)
        {
           accountOne.add(new Account(Name = 'TestAccountOne' + i, BillingState = 'NY'));
           
        }
        insert accountOne; 
        for(Integer i=0 ; i<50;i++)
        {
            accountTwo.add(new Account(Name = 'TestAccountTwo' + i, BillingState = 'CA'));
           
        }
        insert accountTwo;   
    }

    @isTest
    static void testQueueablePositiveTest(){
    
        Contact newCon = new Contact(FirstName = 'Test', LastName = 'Contact');
        AddPrimaryContact addContact = new AddPrimaryContact(newCon, 'CA');
       
        Test.startTest();
         System.enqueueJob(addContact);
        Test.stopTest();
     
        
        List<Contact> contactWithCAState = [SELECT Id, AccountId FROM Contact WHERE Account.BillingState = 'CA'];
        Assert.areEqual(50, contactWithCAState.size(), '50 records inserted');
        
        List<Contact> contactWithNYState = [SELECT Id, AccountId FROM Contact WHERE Account.BillingState = 'NY'];
        Assert.areEqual(0, contactWithNYState.size(), '0 records inserted');
      
    } 
    
     @isTest
    static void testQueueableNegativeTest(){
        try{
            Contact newCon = new Contact(FirstName = 'Test', LastName = 'Contact');
            AddPrimaryContact addContact = new AddPrimaryContact(newCon, 'CA');
           
            Test.startTest();
             System.enqueueJob(addContact);
            Test.stopTest();
         
            
            List<Contact> contactWithCAState = [SELECT Id, AccountId FROM Contact WHERE Account.BillingState = 'CA'];
            Assert.areEqual(44,contactWithCAState.size(), '44records inserted');
            
            List<Contact> contactWithNYState = [SELECT Id, AccountId FROM Contact WHERE Account.BillingState = 'NY'];
            Assert.areEqual(12, contactWithNYState.size(), '12records inserted');
        }
        catch(Exception ex){
            String error = ex.getMessage();
            System.debug(error);
        }
    }

}