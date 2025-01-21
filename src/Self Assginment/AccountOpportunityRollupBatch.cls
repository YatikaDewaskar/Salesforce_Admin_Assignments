global class AccountOpportunityRollupBatch implements Database.Batchable<sObject>, Database.Stateful{
    
    //accountid, count
    public static Map<Id, Decimal> countAmount = new Map<Id, Decimal>();
    
    global Database.QueryLocator start(Database.BatchableContext bc)
    {
		string query = 'SELECT Id, AccountId, StageName, CloseDate, Amount FROM Opportunity WHERE StageName = \'Closed Won\' AND CloseDate <= NEXT_N_DAYS:365';
        return Database.getQueryLocator(query);        
    }
    
    global void execute(Database.BatchableContext bc, List<Opportunity> scope)
    {
        if(!scope.isEmpty())
        {
            
            System.debug('Scope' + scope); 
            Set<Id> oppIds = new Set<Id>();
            for(Opportunity opp : scope)
            {
                if(opp.AccountId != null)
                {
                    oppIds.add(opp.AccountId);
                }
            }
            
     
           List<Account> accountDetails = [SELECT Id, Total_Opportunity_Amount__c FROM Account WHERE Id In :oppIds];
           //  System.debug(accountDetails);
           //  
           //  
            Map<Id, Opportunity> mapOfOpp = new Map<Id, Opportunity>();
           
            
            for(Opportunity opp : scope)
            {
                if(mapOfOpp.containsKey(opp.AccountId))
                {
                    mapOfOpp.put(opp.AccountId, opp);
                }
                else
                {
                    mapOfOpp.put(opp.AccountId, opp);
                }
            }
            System.debug(mapOfOpp);
            //inital the map 
            for(Account acc : accountDetails)
            {
                if(acc.Id != null)
                {
                    if(countAmount.containsKey(acc.Id))
                    {
                        countAmount.put(acc.Id,acc.Total_Opportunity_Amount__c);
                    }
                    else
                    {
                        countAmount.put(acc.Id,0);
                    }
                    
                }
            }
            System.debug(countAmount);
            
            Decimal amount = 0;
            Decimal bonus = 0;
            for(AggregateResult agg : [SELECT AccountId, Sum(Amount)totalSum FROM Opportunity WHERE AccountId In: countAmount.keySet() Group By AccountId])
                {
                    
                    if((Decimal)agg.get('totalSum') > 100000)
                    { 
                       
                        bonus = (Decimal)agg.get('totalSum') * 0.05;
                        amount = (Decimal)agg.get('totalSum') + bonus;
                        countAmount.put((Id)agg.get('AccountId'), amount);
                    }
                    else
                    {
                        countAmount.put((Id)agg.get('AccountId'), (Decimal)agg.get('totalSum'));
                    }
                    
                }
           
            for( Account acc : accountDetails)
            {
                acc.Total_Opportunity_Amount__c = countAmount.get(acc.Id);
            }
            system.debug('Account ' +accountDetails);
            
            if(!accountDetails .isEmpty())
            {
                try{
                    update accountDetails;
                }
                catch(Exception ex)
                {
                    System.debug('Error in Updaing');
                }
                
            }
       
        }
    }
	
    global void finish(Database.BatchableContext bc)
    {
        
    }
}