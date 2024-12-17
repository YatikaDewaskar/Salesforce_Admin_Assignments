/**
 * Purpose : Implement the count of Contacts 
 * 
 * Created By : Yatika Dewaskar
 * 
 * Created Date : 12/15/2024
 * 
 * Revision Logs : V1 Created
 * 
**/

public class AccountProcessor {
      /**
     * Purpose : Method to implement the count of Contacts Associated with Account
     * 
     * Params : List<Id>
     * 
     * Return : Void
     * 
     * Created By : Yatika Dewaskar
     * 
     * Created Date : 12/15/2024
     * 
     * Revision Logs : V1 Created
     * 
    **/
    @future
    public static void countContacts(List<Id> accIds){
        
        List<Account> accList = [Select Id, (Select Id From Contacts)
                        From Account
                        Where Id IN : accIds];
        for(Account acc : accList){
			acc.Number_Of_Contacts__c = acc.Contacts.Size();
        }
        
        if(!accList.isEmpty()){
            update accList;
        }
    }

}