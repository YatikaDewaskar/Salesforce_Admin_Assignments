@isTest
public class ContactApiTest {

    @isTest
    static void testExternalCalloutPostive() {
        Test.setMock(HttpCalloutMock.class, new ContactApiMock());
        List<Contact> conlist = new List<Contact>();
        Contact contactOne = new Contact(LastName = 'testDemoPost', OtherCity = 'Pittsford', OtherStreet = '142 Park Rd', OtherState = 'NY');
        conlist.add(contactOne);
        
        Test.startTest();
            // Execute the method that makes the HTTP callout.
            insert conList;
            ContactTriggerFutureCall.createContact(conList);
            conList = [SELECT Id , ValidAddress__c FROM Contact];
        Test.stopTest();
         Assert.areEqual(true,conList[0].ValidAddress__c,'address is valid');
     }
        @isTest
    static void testExternalCalloutNegative() {
        Test.setMock(HttpCalloutMock.class, new ContactApiMock());
        List<Contact> conlist = new List<Contact>();
        Contact contactOne = new Contact(LastName = 'testDemoposttwo', OtherCity = 'PiterSetor', OtherStreet = '12/secotr A', OtherState = 'Jaipur');
        conlist.add(contactOne);
        
        Test.startTest();
            // Execute the method that makes the HTTP callout.
            insert conList;
            ContactTriggerFutureCall.createContact(conList);
            conList = [SELECT Id , ValidAddress__c FROM Contact];
        Test.stopTest();
         Assert.areEqual(false,conList[0].ValidAddress__c,'address is not valid');
     }

}