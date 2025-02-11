public class AccountSelector 
{
	public static List<Account> getAccountRecords(string recordId)
    {
        return [SELECT Id, Name, Number_Of_Contacts__c, OwnerId, Description FROM Account WHERE Id=:recordId];
    }
	
    
}