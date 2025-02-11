public class ContactService{
    
    @AuraEnabled(cacheable = true)
    public static List<Contact> getRelatedContacts(string recordId)
    {
        return ContactSelector.getRelatedContacts(recordId);
        
    }
    
    @AuraEnabled(cacheable = true)
    public static List<Contact> getRelatedSearchedContacts(string recordId, string searchKey)
    {
        return ContactSelector.getRelatedSearchedContacts(recordId, searchKey);
        
    }
    
    @AuraEnabled
    public static List<Contact> createContact(String firstname, String lastname, String email, String phone, Id accountId)
    {    
     List<Contact> newContact = new List<Contact>();
     if(lastname!=null)
     {
            Contact con = new Contact();
            con.FirstName = firstname;
            con.LastName = lastname;
            con.Phone = phone;
            con.Email = email;
            con.AccountId = accountId;
            newContact.add(con);
            System.debug(newContact);         
    }

    try{
        	insert newContact;
            return newContact;      
       }
       catch(Exception ex) {
          throw new AuraHandledException(ex.getMessage());
      }

    }
   
}