import { LightningElement } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

const colummns = [
    { label: 'Account Name', fieldName: 'Name' },
    { label: 'Industry', fieldName: 'Industry'},
    { label: 'Phone', fieldName: 'phone', type: 'phone' },
    { label: 'Shipping Address', fieldName: 'ShippingAddress', type: 'currency' },
    { label: 'Account Owner', fieldName: 'OwnerId' },
]

export default class GetAccountImperatively extends LightningElement {

    colummns = colummns;
    data = [];
    connectedCallback(){
        getAccounts()
            .then(result => {
                this.data = result;
            })
            .catch(error => {
                console.log('error occured');
            })
            
    }
}