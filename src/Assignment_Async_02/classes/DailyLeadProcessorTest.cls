@isTest
public class DailyLeadProcessorTest{
	public static String sch = '0 30 6 * * ?';
    @testSetup
    static void setupLeadData(){
        
        List<Lead> leads = new List<Lead>();
        for(Integer i=0; i<200; i++){
            leads.add(new Lead(
                      FirstName = 'Test' + i,
                      LastName =  'Demo',
                	  Company = 'Test',
                	  LeadSource = ''
                     ));
        }
        insert leads;  
    }
    
    @isTest
    static void testUpdateLeadPostiveTest(){
        try{
        Test.startTest();
        String jobID = System.schedule('Update lead', sch, new DailyLeadProcessor());
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
		String jobID = System.schedule('Update lead', sch, new DailyLeadProcessor());
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