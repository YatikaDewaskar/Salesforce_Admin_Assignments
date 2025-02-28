public class FutureCallout {
    
    @future(callout=true)
    public static void futureCallout(String id, String Street, String State, String City)
    {
        String tokenEndpoint = 'https://us-street.api.smarty.com/street-address?auth-id=dbffcf53-3a6e-e3c2-a3cf-0f3834b9bdb3&auth-token=2HoDVTJ4skUIEgLVcQW9&street='+Street+'&city='+City+'&state='+State;
        System.debug(tokenEndpoint);
        HttpRequest req = new HttpRequest();
        req.setEndpoint(tokenEndpoint);
        req.setMethod('GET');
        req.setHeader('Content-Type','application/json');
        Http http = new Http();
        HttpResponse res;
    
        String responseStr = '';
        
        try{
            System.debug('inside try');
            if(tokenEndpoint != ''){
                res = http.send(req);
                List<Contact> newUpdatedCon = new List<Contact>();
                if(res.getStatusCode() == 200){
                    System.debug('Body' + res.getBody());
                    responseStr = res.getBody();
                    List<Object> responseContact = (List<Object>)JSON.deserializeUntyped(res.getBody());
                    System.debug('ResponseSTr' + responseStr);
                    
                    if(!responseContact.isEmpty())
                    {
                    List<Contact> updateContact = [SELECT Id, OtherStreet, OtherState, OtherCity, MailingStreet, MailingState, MailingCity, ValidAddress__c FROM Contact WHERE Id =: id];
                    for(Contact updateCon : updateContact)
                    {
                       
                        Contact newUpdatedC = new Contact();
                        newUpdatedC.Id = updateCon.Id;
                        newUpdatedC.MailingStreet = updateCon.OtherStreet;
                        newUpdatedC.MailingState = updateCon.OtherState;
                        newUpdatedC.MailingCity = updateCon.OtherCity;
                        newUpdatedC.ValidAddress__c = true;  
                        newUpdatedCon.add(newUpdatedC);
                    }
                     
                    if(!newUpdatedCon.isEmpty())
                    {
                        Update newUpdatedCon;
                    }
                    }
                }
                
             }
        }catch(Exception e){
         
           system.debug('Exception' +e.getMessage());
        }    
    }

}