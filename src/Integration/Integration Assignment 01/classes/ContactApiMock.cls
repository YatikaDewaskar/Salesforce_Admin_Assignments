global class ContactApiMock implements HttpCalloutMock {
    
   global HttpResponse respond(HTTPRequest request)
   {
		HttpResponse response = new HttpResponse();
       response.setHeader('Content-type','application/json');
       response.setBody('{"status": "success"}');
       response.setStatusCode(200);
       return response;       
   }
      

}