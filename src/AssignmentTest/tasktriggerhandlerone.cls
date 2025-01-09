public class tasktriggerhandlerone {
 /*   
    public static void counttheTaskDisplayOnAccount(List<Task>newTask, Map<Id,Task>oldMap) 
    {
        if(newTask.isEmpty())
            return;
        
        set<Id> AccountIds = new Set<Id>();
        Map<Id,Integer> countTask = new Map<Id,Integer>();
        if(oldMap != null)
        {
			 for(Task tasknew : newTask) 
             {
                 if(oldMap != null)
                     {
                     if( tasknew.Id != oldMap.get(tasknew.Id).Id)
                         {
                             AccountIds.add(tasknew.WhatId);
                             
                         }
                     else
                     {
                         AccountIds.add(tasknew.WhatId);
                     }
                 }
                  else
         			 AccountIds.add(tasknew.WhatId);  
             }
            
        }
           
            if(!AccountIds.isEmpty())
            {
               Map<Id, Integer> accountCountToTaskWithOpenstatus = new Map<Id,Integer>();
               Map<Id, Integer> accountCountToTaskWithCLosedstatus = new Map<Id,Integer>();
                Map<Id, Integer> accountCountToTask = new Map<Id,Integer>();
               List<Account> accToUpdate = new List<Account>(); 
               List<AggregateResult> aggresOpenTask = [SELECT Id, WhatId, Status, COUNT(Id) totalTaskOpen
                                                        FROM Task
                                                        WHERE whatId IN : AccountIds And Status = 'Open'
                                                        GROUP BY WhatId
                                                       ];
               List<AggregateResult> aggresClosedTask = [SELECT Id, WhatId, Status, COUNT(Id) totalTaskclodes
                                                            FROM Task
                                                            WHERE whatId IN : AccountIds And Status = 'Closed'
                                                            GROUP BY WhatId
                                                           ];
              List<AggregateResult> aggresTask = [SELECT Id, WhatId, Status, COUNT(Id) totalTask
                                                            FROM Task
                                                            WHERE whatId IN : AccountIds  
                                                            GROUP BY WhatId
                                                           ];
                
                 for(AggregateResult res : aggresOpenTask){
                    accountCountToTaskWithOpenstatus.put((Id)res.get('WhatId'), (Integer)res.get('totalTaskOpen'));
                 }
                
                 for(AggregateResult res : aggresClosedTask){
                    accountCountToTaskWithCLosedstatus.put((Id)res.get('WhatId'), (Integer)res.get('totalTaskclodes'));
                 }
         
				 for(AggregateResult res : aggresOpenTask){
                    accountCountToTaskWithOpenstatus.put((Id)res.get('WhatId'), (Integer)res.get('totalTask'));
                 }                
                 List<Account> accountToBeUpdated = [SELECT Id, Total_Activities__c, Total_Closed_Activities__c, Total_Open_Activities__c 
                                                    FROM Account
                                                    WHERE ID IN : AccountIds];
                
                
                 List<Account> newAcc = new List<Account>();
                for(Account acc : accountToBeUpdated)
                {
					                    
                    acc.Total_Closed_Activities__c = accountCountToTaskWithCLosedstatus.get(totalTaskclodes);
                    acc.Total_Open_Activities__c = accountCountToTaskWithOpenstatus.get(totalTaskOpen);
                    acc.Total_Activities__c = accountCountToTask.get(totalTask);
                    newAcc.add(acc);
                }
                
            }
        
        if(!newAcc.isEmpty()){
            Insert newAcc;
        }
            }
            
            
           }
*/
}