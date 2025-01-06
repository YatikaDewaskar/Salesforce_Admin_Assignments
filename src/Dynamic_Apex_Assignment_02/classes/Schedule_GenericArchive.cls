/**
 * Purpose : Scheduler class for Batch_GenericArchive to schedule it on Monthly basis.
 * 
 * Created By : Yatika Dewaskar
 * 
 * Created Date : 01/01/2025
 * 
 * Revision Logs : V1 Created
 * 
**/

public class Schedule_GenericArchive implements Schedulable {
    public void execute(SchedulableContext sc) {
        string objectName;
        Batch_GenericArchive batch = new Batch_GenericArchive(objectName);
        Database.executeBatch(batch, 200);
    }
    
    public static void scheduleBatchJob(){
        String cronExpression = '0 0 1 * * ?';
        System.schedule('Schedule on Monthly basis', cronExpression, new Schedule_GenericArchive());
    }
}