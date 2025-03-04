public class AccountControllerComponent {
    @AuraEnabled
    public static List<Account> getAccount()
    {
        List<Account> accList = [SELECT Name, Phone, Description FROM Account ORDER BY CreatedDate desc limit 6];
        System.debug(accList);
        return accList;
        
    }

}