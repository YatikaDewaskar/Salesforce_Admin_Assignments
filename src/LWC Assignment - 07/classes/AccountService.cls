public class AccountService {
		
    @AuraEnabled(cacheable = true)
    public static List<Account> getAccountRecords(string recordId)
    {
        return AccountSelector.getAccountRecords(recordId);
    }
}