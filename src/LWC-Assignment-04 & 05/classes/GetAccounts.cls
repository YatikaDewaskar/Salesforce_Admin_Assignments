public with sharing class GetAccounts {
    @AuraEnabled(cacheable=true)
    public static Account getAccountInfo(Id accountId) {
        return [SELECT Name, Account_Company__c, Website, Phone FROM Account WHERE Id = :accountId LIMIT 1];
    }
}