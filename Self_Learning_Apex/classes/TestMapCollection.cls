/**
 * Description : Created this class for implementing different methods of Map for collection
 *
 * Created By : Yatika Dewaskar
 * 
 * Created Date : 11/25/2024
 * 
 * Revision Logs : V1 Created
 * 
 **/
public  class TestMapCollection {
    public static void mapCollectionTest() {
        Map<Integer,String> myMap = new Map<Integer,String>();
        myMap.put(1,'one');
        myMap.put(2,'two');
        myMap.put(3,'three');
        //System.debug(myMap);
        //myMap.clone();
        if(myMap.containsKey(3)){
            System.debug('conatins true');
        }
        else{
            System.debug('conatins false');
        }
        //System.debug(myMap.get(1));
        //
        //keySet ---> only returns the key 
        System.debug(myMap.keySet());
        
   }
    public static void nestedMapCollection(){
            Map<String, Map<Integer, String>> nestedMap = new Map<String, Map<Integer, String>>();

            Map<Integer, String> innerMap1 = new Map<Integer, String>();
            innerMap1.put(1, 'One');
            innerMap1.put(2, 'Two');
            nestedMap.put('A', innerMap1);
            Map<Integer, String> innerMap2 = new Map<Integer, String>();
            innerMap2.put(1, 'Four');
            innerMap2.put(2, 'Five');
            nestedMap.put('B', innerMap2);
        	System.debug(nestedMap);
            System.debug(nestedMap.get('A')); 
            System.debug(nestedMap.get('B'));         
    }
}