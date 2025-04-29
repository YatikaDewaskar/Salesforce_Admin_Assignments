import { LightningElement, wire} from 'lwc';
import getAccounts from '@salesforce/apex/GetAccountsForLWCDataTable.getAccounts';

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Id', fieldName: 'Id' }     
];

export default class accountManager extends LightningElement {
   columns = columns;
   accounts;
  @wire(getAccounts)
    wiredAccounts({ error, data })
    {
        if(data)
        {
            this.accounts = data;
        }
        else if(error)
        {
            console.log(error);
        }
    }
}
