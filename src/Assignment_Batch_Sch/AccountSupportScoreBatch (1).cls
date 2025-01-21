global class AccountSupportScoreBatch implements Database.Batchable<sObject>, Database.Stateful
{
    public static Map<Id, Decimal> storeScore = new Map<Id, Decimal>();
    
    global static Database.QueryLocator start(Database.BatchableContext bc)
    {
        string query = 'SELECT Id, AccountId, Status, Priority FROM Case WHERE Status != \'Closed\' '; 
	    return Database.getQueryLocator(query);        
    }
    
    global static void execute(Database.BatchableContext bc, List<Case> scope)
    {
        if(!scope.isEmpty())
        {
            System.debug('Scope'+scope);
            
            Set<Id> accountIds = new Set<Id>();
            for(Case newCase : scope)
            {   
                if(newCase.AccountId != null)
                {
                     accountIds.add(newCase.AccountId);
                }
                   
            }
            
            List<Account> accDetails = [SELECT Id, Support_Score__c FROM Account WHERE Id IN : accountIds];
            System.debug('accDetails' + accDetails);
            for(Account acc : accDetails)
            { 
                if(acc.Support_Score__c != null)
                {
                    storeScore.put(acc.Id, acc.Support_Score__c);
                    System.debug('storeScore' + storeScore);
                }
                else
                {
                    storeScore.put(acc.Id, 0);
                    System.debug('storeScore' + storeScore);
                }  
            }
            for(Case newCase : scope)
            {
                Decimal currentScore = storeScore.get(newCase.AccountId);
                currentScore = scoreCalculation(currentScore, newCase);
                System.debug('currentScore' + currentScore);
            }
            List<Account> accountsToUpdate = new List<Account>();
            for (Id accountId : storeScore.keySet()) 
            {
                Account acc = new Account(Id=accountId);
                acc.Support_Score__c = storeScore.get(accountId);
                accountsToUpdate.add(acc);
                
            }
            
            if(!accountsToUpdate.isEmpty())
            {
                System.debug(accountsToUpdate);
                try{
                    update accountsToUpdate;
                }
                catch(Exception e){
                    System.debug('Error in updating');
                }
                    
            }
        } 
    }
    
    global static void finish(Database.BatchableContext bc)
    {
        
    }
    
    private static Decimal scoreCalculation(Decimal currentScore, Case newCase)
    {          
        		System.debug('newCase'+newCase);
                
       			Decimal score = currentScore; 
        		System.debug(score);
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
                   if(newcase.CreatedDate >= Date.today().addDays(-30))
                    {
                        score +=1;
                    }
                    if(newcase.CreatedDate >= Date.today().addDays(60))
                    {
                        score -=1;
                    }
      
        			//if score is negative
        			if(score < 0)
                    {
                        score = 0;
                    }
        System.debug('updated'+score); 
        return score;
    }
}