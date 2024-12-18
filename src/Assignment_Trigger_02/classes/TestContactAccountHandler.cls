@isTest
public class TestContactAccountHandler {
    
    @TestSetup
    static void setupData(){
        List<Account> accountList = new List<Account>();
        Account accountOne = new Account(Name = 'Tcs', Domain__c = '@tcs.com');
        Account accountTwo = new Account(Name = 'Web', Domain__c = '@web.com'); 
       
        accountList.add(accountOne);
        accountList.add(accountTwo);
        insert accountList;    
    }    


    @isTest
    static void testDataForPositiveTest(){

          List<Account> accList = [SELECT Id, Domain__c FROM Account WHERE Domain__c = '@tcs.com'];
          System.debug(accList[0]);
          List<Contact> contactList = new List<Contact>();
           
          Contact conOne = new Contact(LastName = 'Reev', Email = 'reev@tcs.com', AccountId = accList[0].Id);
          contactList.add(conOne);
           
          Test.startTest();
          insert contactList;   
          contactList = [SELECT Id, Email FROM Contact];
          Assert.areEqual('reev@tcs.com',contactList[0].Email,'Contact can be Created');
          Test.stopTest();
      }
    
    
    @isTest
    static void testDataForNegativeTest(){
        try{
          List<Account> accList = [SELECT Id, Domain__c FROM Account WHERE Domain__c = '@web.com'];
          System.debug(accList[0]);
          List<Contact> contactList = new List<Contact>();
           
          Contact con = new Contact(LastName = 'Abhi', Email = 'abhi@abc.com', AccountId = accList[0].Id );
          contactList.add(con);
          
          Test.startTest();
          insert contactList;   
          contactList = [SELECT Id, Email FROM Contact];
          Assert.areEqual('abhi@web.com',contactList[0].Email,'Contact can not be Created');
          Test.stopTest();
        }
        catch(Exception ex){
            String error = ex.getMessage();
            System.debug(error);
        }
    }
    
    
     @isTest
    static void testUpdateForPositiveTest(){
    
      List<Account> accOne = new List<Account>([SELECT Id, Domain__c FROM Account WHERE Domain__c = '@tcs.com']);
      List<Contact> contactList = new List<Contact>();
     
    Contact conOne = [SELECT Id, Email FROM Contact WHERE LastName = 'Reev'];
      conOne.Email = 'Rv@tcs.com';
    	 contactList.add(conOne);    
       Test.startTest();
        update contactList;  
        contactList = [SELECT Id, Email FROM Contact];
		Assert.areEqual('Rv@tcs.com',contactList[0].Email,'Contact can be Created');
       Test.stopTest(); 
    } 
    
    
     @isTest
    static void testUpdateForNegativeTest(){
        try{
          Account accOne = [SELECT Id, Domain__c FROM Account WHERE Domain__c = '@tcs.com'];
          List<Contact> contactList = new List<Contact>();
          Contact conThree = [SELECT Id, Email FROM Contact WHERE LastName = 'Abhi'];
              conThree.Email = 'abhi@we.com';
          contactList.add(conThree);   
           Test.startTest();
            update contactList;  
            contactList = [SELECT Id, Email FROM Contact];
            Assert.areEqual('abhi@web.com',contactList[2].Email,'Contact  not can be Created'); 
    
           Test.stopTest();
         }
        catch(Exception ex){
            String error = ex.getMessage();
            System.debug(error);
        }   
      
    }  
       
 }
