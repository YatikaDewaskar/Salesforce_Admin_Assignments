@isTest
public class LeadProcessorTest {

    @testSetup
    static void setupLeadData(){
        List<Lead> leads = new List<Lead>();
        for(Integer i=0; i<200; i++){
            leads.add(new Lead(
                      FirstName = 'Test' + i,
                      LastName =  'Demo',
                	  Company = 'Test',
                	  LeadSource = 'Web'
                     ));
        }
        insert leads;  
    }
    
    @isTest
    static void testUpdateLeadPostiveTest(){
        try{
        Test.startTest();
        LeadProcessor batch = new LeadProcessor();
        Database.executeBatch(batch);
        Test.stopTest();
        
        List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead];
        for(Lead leads : updatedLeads){
            Assert.areEqual('Dreamforce', lead.LeadSource);
        }
        }
        catch(exception e){
            string error = e.getMessage();
            System.debug(error);
        }
    }
    
     @isTest
    static void testUpdateLeadNegativeTest(){
        try{
        Test.startTest();
        LeadProcessor batch = new LeadProcessor();
        Database.executeBatch(batch);
        Test.stopTest();
        
        List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead];
        for(Lead leads : updatedLeads){
            Assert.areEqual('WEB', lead.LeadSource);
        }
        }
        catch(exception e){
            string error = e.getMessage();
            System.debug(error);
        }
    }
}