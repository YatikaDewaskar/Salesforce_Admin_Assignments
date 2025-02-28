/**
 * Purpose : Implemention of Integration with Postman 
 * 
 * Created By : Yatika Dewaskar
 * 
 * Created Date : 02/20/2025
 * 
 * Revision Logs : V1 Created
 * 
**/
public class ContactTriggerFutureCall{
    
    public static string removeSpaces(String address)
    {
        String temp;
        String newString;
        if(!String.isBlank(address))
        {
            newString = address.replace(' ', '+');
            System.debug(newString); 
        }
        return newString;
    }

    public static void createContact(List<Contact> newContact)
    {
        if(!newContact.isEmpty())
        {
            
        String City = '';
        String Street = '';
        String State = '';
        String id = '';
        for(Contact con : newContact)
        {
                Contact newC = new Contact();
                if(con.Id != Null && con.OtherCity != Null && con.OtherStreet != Null && con.OtherState != Null)
                {
                    Street = removeSpaces(con.OtherStreet);
                    State = removeSpaces(con.OtherState);
                    City = removeSpaces(con.OtherCity);
                    id = con.Id;    
                }        
        }
       
       FutureCallout.futureCallout(id, Street, State, City);  
       }
    }
    
}