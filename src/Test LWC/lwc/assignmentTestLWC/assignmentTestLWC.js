import { LightningElement, wire } from 'lwc';
import getAccount from '@salesforce/apex/AccountControllerComponent.getAccount';
import { refreshApex } from '@salesforce/apex';

const columns = [
    {label: 'Name', fieldName: 'Name', type: 'text'},
    {label: 'Phone', fieldName: 'Phone', type: 'phone'},
    {label : 'Description', fieldName: 'Description', type: 'text'}
];

export default class AssignmentTestLWC extends LightningElement {

    isOpenCreateAccount = false;
    isOpenCreateContact = false;
    wiredAccountResult;
   


    handleCreateAccount(){
        this.isOpenCreateAccount = true;

    }

    wiredAccountResult;

    @wire(getAccount) 
    getAccounts(result){
        this.wiredAccountResult=result;
        if(result.data){
            this.accounts = result.data;
            console.log( this.accounts);
            this.refreshData();
        }
        else if(result.error){
            console.log('error'+JSON.parse(JSON.stringify(result.error)));
        }
        }

   refreshData(){
       refreshApex(this.wiredAccountResult);
   }
            
   
}