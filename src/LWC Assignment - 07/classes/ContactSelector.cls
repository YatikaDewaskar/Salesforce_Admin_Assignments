public class ContactSelector 
{
    public static List<Contact> getRelatedContacts(string recordId)
    {
        return [SELECT Name, Email, Phone, AccountId FROM Contact WHERE AccountId=:recordId ORDER BY CreatedDate desc ];
    }
    
    public static List<Contact> getRelatedSearchedContacts(string recordId, string searchKey)
    {
        String search = '%' + searchKey + '%';
        return [SELECT Name, Email, Phone, AccountId FROM Contact WHERE AccountId=:recordId AND Name Like :search ];
    }

}