/**
 * Purpose :  Queueable for inserting Contacts with Specific BillingState on Acccount
 * 
 * Created By : Yatika Dewaskar
 * 
 * Created Date : 12/20/2024
 * 
 * Revision Logs : V1 Created
 * 
**/
public class AddPrimaryContact implements Queueable
{
     private Contact contactsRecords;
     private String states;
    
    public AddPrimaryContact(Contact contactsRecords, String states)
    {
        this.contactsRecords = contactsRecords;
        this.states = states;
    }
    
    public void execute(QueueableContext context)
    {
        List<Account> accountList = [SELECT Id FROM Account WHERE BillingState=:states];
        List<Contact> contactToInsert = new List<Contact>();
        
        for(Account acc : accountList){
           
           Contact clonedCon = contactsRecords.clone(false, true, false, false);
           contactsRecords.AccountId = acc.Id;
           contactToInsert.add(contactsRecords);
        }
        
        if( !contactToInsert.isEmpty()){
            insert contactToInsert;    
        }
        
    }

}