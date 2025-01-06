@isTest(SeeAllData=true)
public class Test_Batch_GenericArchive {
	
    @isTest
    static void testGenericArchiveData(){
         List<Archive_Config__mdt> queryOnMetadata = [SELECT Developer_Name__c, Label__c, Duration__c, Filter__c FROM Archive_Config__mdt WHERE Developer_Name__c = 'Account' LIMIT 1];
         Batch_GenericArchive archiveData = new Batch_GenericArchive(queryOnMetadata[0].Developer_Name__c);
        
         Test.startTest();
         Database.executeBatch(archiveData);
         Test.stopTest();
        
         Assert.isTrue(Batch_GenericArchive.emailsInvocations > 0, 'Sent atleast one email');
         Assert.areEqual(1, Batch_GenericArchive.emailsInvocations, 'One email sended');
         List<Account> accRecords = [SELECT Id FROM Account WHERE Name = 'Demo Test'];
         Assert.areEqual(0, accRecords.size(), 'Deleted Records after batch execute');
    }
}