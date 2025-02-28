/**
 * Purpose : Implemention of Integration with Postman 
 * 
 * Created By : Yatika Dewaskar
 * 
 * Created Date : 02/21/2025
 * 
 * Revision Logs : V1 Created
 * 
**/

@RestResource (UrlMapping = '/AccountContactApi/*')
global class AccountContactApi{
    
     /**
     * Purpose : Method to get Account Details 
     * Created By : Yatika Dewaskar
     * Created Date :  02/21/2025
     * Revision Logs : V1 Created
     * 
    **/  
    @httpGet
    global static void getAccountName()
    {
        RestRequest req = RestContext.Request;
        RestResponse res = RestContext.Response;
        
        String body = req.requestBody.toString();
        System.debug('@@@ Body' + body);
        JsonAccountData jsonAccData = (JsonAccountData) JSON.deserialize(body, JsonAccountData.class);
        System.debug('@@@ AccountId' + jsonAccData.accountId );
        
        List<Account> accList = [SELECT Name FROM Account WHERE Id =: jsonAccData.accountId ];
        System.debug(accList);        
            if(!accList.isEmpty())
            {   
                res.statusCode = 200 ;
                Map<String, Object> responseMap = new Map<String, Object>();
                responseMap.put('AccountId', accList[0].Id);
                res.responseBody = Blob.valueOf(JSON.serialize(responseMap));
                res.addHeader('Content-Type', 'application/json');
            }
     }
 
     /**
     * Purpose : Method to create Account and Contact based on conditions
     * Created By : Yatika Dewaskar
     * Created Date :  02/24/2025
     * Revision Logs : V1 Created
     * 
    **/  
    @httpPost
    global static void createAccountAndRelatedContact() {
    RestRequest req = RestContext.Request;
    RestResponse res = RestContext.Response;

    List<Contact> conList = new List<Contact>();
    List<Account> accList = new List<Account>();

    String body = req.requestBody.toString();
    JsonAccountCreateData jsonAccoData = (JsonAccountCreateData) JSON.deserialize(body, JsonAccountCreateData.class);
    System.debug('@@@' + jsonAccoData);
    List<Account> accountDetails = [SELECT Id, Name FROM Account WHERE Name = :jsonAccoData.AccountName LIMIT 1];
    Account existingAcc = new Account();
    if(!accountDetails.isEmpty())
    {
        existingAcc = accountDetails[0];
    }
    else
    {
        existingAcc = null;
    }
    System.debug('@@@'+existingAcc);
        
    List<Contact> contactList = new List<Contact>();
    if (existingAcc != null) {
        contactList = [SELECT Id, Email FROM Contact WHERE AccountId = :existingAcc.Id];
    }

    List<String> contactEmail = new List<String>();
    for (Contact con : contactList) {
        contactEmail.add(con.Email);
    }

    if (existingAcc != null) {
        Contact con = new Contact();
        con.AccountId = existingAcc.Id;
        con.LastName = jsonAccoData.LastName;
        con.FirstName = jsonAccoData.FirstName;
        if (contactEmail.contains(jsonAccoData.Email)) {
            res.statusCode = 400; 
            res.responseBody = Blob.valueOf('{"error": "Contact Email already Exists"}');
            res.addHeader('Content-Type', 'application/json');
            return;
        } else {
            con.Email = jsonAccoData.Email;
        }
        conList.add(con);

    } else 
    {
        Account newAcc = new Account();
        newAcc.Name = jsonAccoData.AccountName;
        accList.add(newAcc);
        Contact con = new Contact();
        con.AccountId = newAcc.Id;
        con.LastName = jsonAccoData.LastName;
        con.FirstName = jsonAccoData.FirstName;
        for (Contact existingCon : contactList) {
            if (existingCon.Email == jsonAccoData.Email) {
                res.statusCode = 400; 
                res.responseBody = Blob.valueOf('{"error": "Contact Email already Exists"}');
                res.addHeader('Content-Type', 'application/json');
                return;
            }
        }

        con.Email = jsonAccoData.Email;
        conList.add(con);
    }

    if (!conList.isEmpty()) {
        insert conList;
    }

    if (!accList.isEmpty()) {
        try {
            insert accList;
            Account createdAcc = accList[0];

            res.statusCode = 200;
            Map<String, Object> responseMap = new Map<String, Object>();
            responseMap.put('AccountId', createdAcc.Id);
            responseMap.put('ContactId', conList[0].Id); 

            res.responseBody = Blob.valueOf(JSON.serialize(responseMap));
            res.addHeader('Content-Type', 'application/json');
        } 
        catch (DMLException e) {
            res.statusCode = 500;
            res.responseBody = Blob.valueOf('{"error": "Failed to create Account and Contact"}');
            res.addHeader('Content-Type', 'application/json');
            System.debug('Error: ' + e.getMessage());
        }
    }
  }
    
   /**
     * Purpose : Method to Update Account Address 
     * Created By : Yatika Dewaskar
     * Created Date :  02/25/2025
     * Revision Logs : V1 Created
     * 
    **/ 
  @httpPut
   global static void updateAccount()
   {
         RestRequest req = RestContext.Request;
   		 RestResponse res = RestContext.Response;
         String body = req.requestBody.toString();
       
        JsonAccountUpdateData jsonAccUpdate = (JsonAccountUpdateData) JSON.deserialize(body, JsonAccountUpdateData.class);
        List<Account> accDetails = [SELECT Id, ShippingAddress FROM Account WHERE Id =: jsonAccUpdate.AccountId];
       System.debug('@@@ Account details' + accDetails);
        List<Account> accUpdated = new List<Account>();
        for(Account acc : accDetails)
        {   
            acc.ShippingStreet = jsonAccUpdate.Street;
            acc.ShippingCity = jsonAccUpdate.City;
            accUpdated.add(acc); 
            System.debug(accUpdated);
        }
        if(!accUpdated.isEmpty())
        {
            update accUpdated;
        }    
   }
                 
 
        
}