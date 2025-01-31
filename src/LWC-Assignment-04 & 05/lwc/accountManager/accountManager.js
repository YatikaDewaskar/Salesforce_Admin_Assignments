import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

const columns = [
    { label: 'Account Name', fieldName: 'Name' },
    { label: 'Industry', fieldName: 'Industry'},
    { label: 'Phone', fieldName: 'phone', type: 'phone' },
    { label: 'Shipping Address', fieldName: 'ShippingAddress', type: 'currency' },
    { label: 'Account Owner', fieldName: 'OwnerId' },

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