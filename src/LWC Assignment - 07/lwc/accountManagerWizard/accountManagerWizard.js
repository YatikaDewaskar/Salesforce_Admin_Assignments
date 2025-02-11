import { LightningElement , wire, api, track} from 'lwc';
import getAccounts from '@salesforce/apex/AccountService.getAccountRecords';
import getRelatedContacts from '@salesforce/apex/ContactService.getRelatedContacts';
import getRelatedSearchedContacts from '@salesforce/apex/ContactService.getRelatedSearchedContacts';
import{ refreshApex } from '@salesforce/apex';

const columns = [
    {label: 'Name', fieldName: 'Name', type: 'text'},
    {label: 'Email', fieldName: 'Email', type: 'email'},
    {label: 'Phone', fieldName: 'Phone', type: 'phone'},
    {label: 'AccountId', fieldName: 'AccountId'}

];

export default class AccountManagerWizard extends LightningElement {

    isGetAccount = false;
    isCreateContact = false;
    filterData;
    getContactsData;
    getAccountData;
    @api recordId;
    accounts;
    @track contacts;
    @track contactsSearchData;
    columns = columns;
    searchKey = '';
    @track name;
    @track owner;
    @track numberofContacts;
    @track description;

    @wire(getAccounts , {recordId: "$recordId"})
    accountsData(result){
        this.getAccountData = result;
        if(result.data){  
            this.accounts = result.data;
            console.log(this.accounts);
            this.name = result.data[0].Name;
            this.owner = result.data[0].OwnerId;
            this.numberofContacts = result.data[0].Number_Of_Contacts__c;
            console.log( this.numberofContacts);
            this.description = result.data[0].Description;  
            console.log(this.description);
            
            this.refreshData();  
        }
        else if(result.error){
            console.log('error'+ result.error);
        }
    }

    handleGetAccount(event) {
        this.isGetAccount = true;
        console.log(this.accounts);
    }

    refreshData(){
        refreshApex(this.getContactsData);
        refreshApex(this.getAccountData);
    }
    
    @wire(getRelatedContacts, {recordId: "$recordId"})
    contactsData(result){
        this.getContactsData  = result;
        console.log(result);
        if(result.data){
            this.contacts = result.data;
            this.refreshData();
            
        }
        else if(result.error){
            console.log('error'+JSON.parse(JSON.stringify(result.error)));
        }
    } 

    @wire(getRelatedSearchedContacts, {recordId: "$recordId", searchKey: "$searchKey"})
    contactsSearchData({data, error}){
        if(data){
            this.contactsSearchData = data;
            console.log(this.contactsSearchData);
        
        }
        else if(error){
            console.log('error'+JSON.parse(JSON.stringify(error)));
        }
    }

    handleSaveContact(){
        this.refreshData();
    }

    handleSearchContact(event) {
        this.searchKey = event.target.value;
        console.log(this.searchKey);
        this.filterData = true;
    }
    
    handleCreateContact(event){
        this.isCreateContact = true;
    }
    
}