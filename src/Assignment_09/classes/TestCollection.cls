/**
 * Description : Created this class for implementing different operations on Collections (Assignment 01 of Apex)
 *
 * Created By : Yatika Dewaskar
 * 
 * Created Date : 11/23/2024
 * 
 * Revision Logs : V1 Created
 * 
 **/


public class TestCollection {
/*
* Description : Create a list of integers and add ten random numbers to it and sort the list in ascending order
* 
* Created By : Yatika Dewaskar
* Created Date : 11/23/2024
* 
* Revision Logs : V1 Created
*/

    public  void testListCollection(){
        //List of Integer to store the integers value
        List<Integer> myNumber = new List<Integer>{1,2,3,4,9,6,7,4,5,8};
        myNumber.sort();
        System.debug(myNumber); 
       
    }
/*
* Description : Created two sets of strings representing two different groups of students to find union, intersection, and difference of the two sets
*
* Created By : Yatika Dewaskar
*
* Created Date : 11/23/2024
* 
* Revision Logs : V1 Created
*/

    public  void testSetCollection(){
        Set<String> groupA = new Set<String>{'Abhay','Anay','Harry','Shurti'};
        Set<String> groupB = new Set<String>{'Harleen','Anay','Abhivk','Shery'};
        //set to store the union of two sets 
        Set<String> union = new Set<String>();
        union.addAll(groupB);
        System.debug(union);

        //set to store the intersection of two sets
        Set<String> intersection = new Set<String>();
        intersection.retainAll(groupB);
        System.debug(intersection);

        //set to store the difference of two sets
        Set<String> difference = new Set<String>();
        difference.removeAll(groupB);
        System.debug(groupA);
    }

/*
* Description : Create a map where the keys are strings and the values are lists of strings. Add some data representing a department (key) and the list of employees (value) in each department.
*
* Created By : Yatika Dewaskar
*
* Created Date : 11/24/2024
* 
* Revision Logs : V1 Created
*
*/
public static void testMapCollection(){
    //Map to store the string as key and the List of list as the value
    Map<String, List<String>> departmentEmployees = new Map<String, List<String>>();
    departmentEmployees.put('HR', new List<String>{'Apel', 'Heen'});
    departmentEmployees.put('Finances', new List<String>{'David', 'Abhay', 'Aman'});
    departmentEmployees.put('Sales', new List<String>{'Heerna','Jon','Harleen'});
    System.debug('Department Employees: ' + departmentEmployees);

}


}