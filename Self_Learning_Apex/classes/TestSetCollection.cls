/**
 * Description : Created this class for implementing different methods of Set for collection
 *
 * Created By : Yatika Dewaskar
 * 
 * Created Date : 11/25/2024
 * 
 * Revision Logs : V1 Created
 * 
 **/
public class TestSetCollection {
   public static void testSetCollection(){
     Set<Integer> mySet = new Set<Integer>();
     mySet.add(1);
     mySet.add(4);
     mySet.add(6);
     mySet.add(8);
     System.debug(mySet);

     Set<Integer> mySet2 = new Set<Integer>{4,5,6,2};
     System.debug(mySet.addAll(mySet2));
     System.debug(mySet);
       
     mySet.retainAll(mySet2);
     System.debug(mySet);
     //Doubt
   }
    public static void nestedSetCollection(){
        Set<String> set1 = new Set<String>{'A', 'B', 'C'};
        Set<String> set2 = new Set<String>{'D', 'E', 'F'};
            
    }
}