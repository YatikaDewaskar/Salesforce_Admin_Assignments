/**
 * Description : Created this class for implementing different methods of List for collection
 *
 * Created By : Yatika Dewaskar
 * 
 * Created Date : 11/25/2024
 * 
 * Revision Logs : V1 Created
 * 
 **/
public  class TestListCollection {
  
    public static void setCollection() {
        List<String> dept = new List<String>{'Marketing','Finances','Information'};
        List<String> users = new List<String>();
        users.add('Abhay');
        users.add('Heer');
        users.add('Naman');
        System.debug(users);
        
        users.add(1,'Div');
        System.debug(users);
        //Set() --> removes the element of the specfic index
        users.set(2,'Den');
        System.debug(users);
        
    }
    public static void testList(){
        List<Integer> numOne = new List<Integer>{1,2,5,3,6};
        List<Integer> numTwo = new List<Integer>{4,3,8,6};
        //addAll() -> all elements in numTwowill be in numOne with duplicates
        numOne.addAll(numTwo);
        System.debug(numOne);
        System.debug(numOne.get(2));
        //getSobjectType()
        //iterator()
		   
        //while(numOne.hasNext()){
        //  system.debug(numOne.next());
        //}
	    
        
       // System.debug(numTwo.toString());
       
        
    }
    
    public static void testSetforNestedConditions(){
     	List<List<String>>myList =  new List<List<String>>();
        
        List<String>part1 = new List<String>{'one','two'};
        List<String>part2 = new List<String>{'four'};
        
        myList.add(part1);
        myList.add(part2);
        System.debug(myList);   
    }
}