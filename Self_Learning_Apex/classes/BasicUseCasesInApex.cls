/**
 * Description : Created this class for implementing different use cases for collection
 *
 * Created By : Yatika Dewaskar
 * 
 * Created Date : 11/25/2024
 * 
 * Revision Logs : V1 Created
 * 
 **/
public class BasicUseCasesInApex {
//Use Case 1 :  method to display log of Number of days you were absent  
    	public static void checkAbsences(Map<String, Boolean> weekLog){
        Integer weekDayCount = 0;
        for(String weekDay : weekLog.keySet()){
            Boolean currentDayStatus = weekLog.get(weekDay);
            if(currentDayStatus == true){
                weekDayCount++;
            }
        }
        System.debug(weekDayCount);    
    }
        // ----------> inside the ApexCode Window
        // Map<String, Boolean> weekLog = new Map<String, Boolean>();
        //     weeklog.put('Mon',true);
        //     weeklog.put('Tues',true);
        //     weeklog.put('Wed',false);
        //     weeklog.put('Thur',true);
        //     weeklog.put('Fri',false);
        // BasicUseCasesInApex.checkAbsences(weekLog);

//Use Case 2 : method that track the number of times a word is used in used in a list     
        public static void checkTheOccuranceOfWordInList(){
            List<String> para = new List<String>();
            para.add('It');
            para.add('Today');
            para.add('can');
            para.add('Today');
            para.add('Be');
            para.add('Today');
            para.add('today');
            Integer countWord = 0;
    
            for (Integer i = 0 ;i < para.size();i++){
                if(para[i].containsIgnoreCase('Today')){
                    countWord++;
                }
            }
            System.debug(countWord);
       }


//Use Case 3 : method that checks the marks on individual subjects and displays the highest and lowest marks.
    	public void checkMarkDisplayHighestandLowest(Map<String, Integer> displayMark){
            Integer maxMarks = 0;
            Integer minMarks = 0;
        
            //for each subject in my displaycard
            for(String subject : displayMark.keySet()){
                Integer marks = displayMark.get(subject);
                if(maxMarks < marks){
                    maxMarks = marks; 
                }
                
                if(minMarks > marks){
                    minMarks = marks;
                }
            }
            System.debug('MaxMarks' + MaxMarks);
            System.debug('MinMarks' + MinMarks);
          
            
		}
        public void  setCollection() {
            List<String> dept = new List<String>{'Marketing','Finances','Information'};
            List<String> users = new List<String>();
            users.add('Abhay');
            users.add('Heer');
            users.add('Naman');
            System.debug(users);
   		 }
//Use Case 4 : a map of Account objects where each account has a map of contacts
    public static void testMap(){
                 
            Map<Account, Map<Id, Contact>> accountContactsMap = new Map<Account, Map<Id, Contact>>();
            
            // Fetch some example data (assuming these IDs exist)
            Account acct = [SELECT Id, Name FROM Account LIMIT 1];
            Contact con1 = [SELECT Id, FirstName, LastName FROM Contact WHERE AccountId = :acct.Id LIMIT 1];
            Contact con2 = [SELECT Id, FirstName, LastName FROM Contact WHERE AccountId = :acct.Id LIMIT 1 OFFSET 1];
            
            // Create the inner map (contacts map for a specific account)
            Map<Id, Contact> contactsMap = new Map<Id, Contact>();
            contactsMap.put(con1.Id, con1);
            contactsMap.put(con2.Id, con2);
            
            // Insert the inner map (contacts) into the outer map (account)
            accountContactsMap.put(acct, contactsMap);
            
            // Accessing a contact from the nested map
            System.debug(accountContactsMap.get(acct).get(con1.Id).FirstName); // Output: First name of contact con1

    }
 
}