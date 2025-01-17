global class AccountSupportScoreBatch implements Database.Batchable<sObject>
{
    global static Database.QueryLocator start(Database.BatchableContext bc)
    {
        string query = 'SELECT Id, AccountId, Status, Priority  FROM Case WHERE Status != Closed';
	    return Database.getQueryLocator(query);        
    }
    
    global static void execute(Database.BatchableContext bc, List<Case> scope)
    {
        if(!scope.isEmpty())
        {
            Set<Id> accountIds = new Set<Id>();
            List<Account> accDetails = [SELECT Id, Support_Score__c FROM Account WHERE Id IN : accountIds];
            for(Case newCase : scope)
            {
                accountIds.add(newCase.AccountId);
            }
          
            for(Account acc : accDetails)
            { 
                acc.Support_Score__c = scoreCalculation(scope, accountIds);
                
            }
              
            update accDetails;
    
        } 
    }
    
    global static void finish(Database.BatchableContext bc)
    {
        
    }
    
    private static Decimal scoreCalculation(List<Case> scope, Set<Id> accountIds)
    {
       List<Account> accountDetails = [SELECT Id, Support_Score__c FROM Account WHERE Id IN : accountIds];
       Decimal score = 0; 
       if(!accountIds.isEmpty() && !scope.isEmpty())
        {
      		for(Account acc : accountDetails)
            {
                score = acc.Support_Score__c;
            }
            
//     if(scope > 0) 
//   	 {
                for(Case newcase : scope)
                {
                    if(newcase.Priority =='High')
                    {
                        score += 3;    
                    }
                    if(newcase.Priority =='Medium')
                    {
                        score +=2;          
                    }
                    if(newcase.Priority == 'Low')
                    {
                        score +=1;
                    }
                    if(newcase.CreatedDate <= system.today().addDays(-30))
                    {
                        score +=1;
                    }
                    if(newcase.CreatedDate <= system.today().addDays(60))
                    {
                        score -=1;
                    }
            	}
                
            }
          
 //     }
        return score;
    }
}