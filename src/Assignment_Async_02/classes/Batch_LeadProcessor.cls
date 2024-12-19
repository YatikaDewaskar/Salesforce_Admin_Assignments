/**
 * Purpose : Batch class for updating the LeadSource of the Leads.
 * 
 * Created By : Yatika Dewaskar
 * 
 * Created Date : 12/18/2024
 * 
 * Revision Logs : V1 Created
 * 
**/
public class Batch_LeadProcessor implements Database.Batchable<sObject>
{
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator('SELECT Id FROM Lead');
    }
    
    public void execute(Database.BatchableContext bc, List<Lead> Scope)
    {
        List<Lead> leadToUpdate = new List<Lead>();
        
        for(Lead leads : scope){
                leads.LeadSource = 'Dreamforce';
                leadToUpdate.add(leads);
            }
       
        if(!leadToUpdate.isEmpty()){
            update leadToUpdate;
        }
      
    }
    
    public void finish(Database.BatchableContext bc)
    {
        
    }
        
}