public class AccountSupportScoreBatchScheduler implements Schedulable {
    
    public void execute (SchedulableContext context)
    {
        AccountSupportScoreBatch batchacc = new AccountSupportScoreBatch();
 		String CronExpress = '0 0 0 * 1 *';
//	   System.schedule('Daily',batchacc,CronExpress);
     
    }
		
}