/**
 * Purpose : Insert and Update records on Contact associated with Account 
 * 
 * Created By : Yatika Dewaskar
 * 
 * Created Date : 12/05/2024
 * 
 * Revision Logs : V1 Created
 * 
 **/
public class ContactAccountHandler{
    /**
     * Purpose : Method to Implement insertion of records on Contacts associated with related domain name of Account
     * Param : List<Contact>
     * Return type: void
     * Created By : Yatika Dewaskar
     * Created Date : 12/05/2024
     * Revision Logs : V1 Created
     * 
     **/
	public static void allowRecordsWithOnlySpecificDomain(List<Contact> newContacts){
        if( !newContacts.isEmpty()){
        Set<Id> accountIds = new Set<Id>();
        for(Contact con : newContacts){
            //more use case less processing 
            if(con.AccountId != null){
           		 accountIds.add(con.AccountId);
            }
        }
       // System.debug(accountIds);
        Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id, Domain__c FROM Account WHERE Id IN :accountIds ]);
                               
        for(Contact newContact : newContacts){
           
            Account acc = accountMap.get(newContact.AccountId); 
            if(newContact.AccountId != null){
                if( acc.Id != null && acc.Domain__c != null){
                    String domain = acc.Domain__c;
                    if( !((newContact.Email).containsIgnoreCase(domain)))  
                        newContact.addError('Domain name of Email does not match with '+ domain);
                }
            }
        }
           
            }
            
      }
   
    /**
     * Purpose : Method to Implement updation of records on Contacts associated with related Account
     * Param : List<Contact>, Map<Id, Contact>
     * Return type: void
     * Created By : Yatika Dewaskar
     * Created Date : 12/06/2024
     * Revision Logs : V1 Created
     * 
     **/
    public static void updateRecordsWithEmailandSpecificDomain(List<Contact> newContacts, Map<Id, Contact> oldContactMap){
        
        if( !oldContactMap.isEmpty()){
            //existing user 
            Set<Id> accountIds = new Set<Id>();
            for(Contact con : newContacts){
                
                if(con.AccountId != null){
                    accountIds.add(con.AccountId);
                }
            }
            
            Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id, Domain__c FROM Account WHERE Id IN :accountIds ]);        
            Map<Id, Contact> newContactMap = new Map<Id, Contact>();
            for(Contact con : newContacts){
                Account acc = accountMap.get(con.AccountId); 
                if(con.AccountId != null){
                    String domain = acc.Domain__c;
                    System.debug(domain);
                    {   
                        
                        if(oldContactMap.get(con.Id).Email != con.Email && con.Email.contains(domain) ){
                            newContactMap.put(con.Id, con);
                            
                        }
                        else{
                            con.addError('Invalid email');
                        }
                        
                    }
                }
            }
            System.debug(newContactMap);
            List<Contact> conList = [SELECT Id, Name,  Email FROM Contact WHERE AccountId IN : accountMap.KeySet()];
            List<Contact>listToUpdate = new List<Contact>();
            if( !conList.isEmpty()){
                for(Contact con : conList){
                    con.Email = newContactMap.get(con.Id).Email;
                    listToUpdate.add(con);
                }
            }
            if( !listToUpdate.isEmpty()){
                update listToUpdate;
            }
            
        }
        
    }  
}