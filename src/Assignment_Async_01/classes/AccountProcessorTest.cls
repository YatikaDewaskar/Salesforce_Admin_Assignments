@isTest
public class AccountProcessorTest {
		
    @isTest
    public static void countContactTest(){
        List<Account> accList = new List<Account>();
        for(Integer i=0; i<=100 ; i++){
            accList.add(new Account (Name = 'Test'+i));
        }
        Test.startTest();
        insert accList;
        
        List<Contact> conList = new List<Contact>();
        List<Id> accIds = new List<Id>();
        for(Account acc : accList){
            Contact con = new Contact();
            con.FirstName = 'Test';
            con.LastName = acc.Name;
            con.AccountId = acc.Id;
            conList.add(con);
            accIds.add(acc.Id);
        }
        insert conList;
        
        AccountProcessor.countContacts(accIds);
        

        Test.stopTest();
        List<Account> acc = [Select Id,Number_Of_Contacts__c From Account];
        Assert.areEqual(1, acc[0].Number_Of_Contacts__c);
        
         }
}