/**
 * Purpose : Scheduler class for Batch_LeadProcessor to schedule it on Daily basis.
 * 
 * Created By : Yatika Dewaskar
 * 
 * Created Date : 12/18/2024
 * 
 * Revision Logs : V1 Created
 * 
**/
global class DailyLeadProcessor implements Schedulable{
    
    global void execute(SchedulableContext ctx){
        
        List<Lead> leadList = [SELECT Id, LeadSource FROM Lead];
        for(Lead leads : leadList){
            
            if(String.isBlank(leads.LeadSource)){
            	leads.LeadSource  = 'Dreamforce';
            }
        }
        update leadList;
    }
		
}