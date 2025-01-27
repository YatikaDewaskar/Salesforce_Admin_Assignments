import { LightningElement, api , wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import Account from '@salesforce/schema/Account';
import Contact from '@salesforce/schema/Contact';
import Name_Field from '@salesforce/schema/Account.Name';
import Company_FIELD from '@salesforce/schema/Account.Account_Company__c';
import Website_FIELD from '@salesforce/schema/Account.Website';
import Phone_FIELD from '@salesforce/schema/Account.Phone';
import FirstName from '@salesforce/schema/Contact.FirstName';
import LastName from '@salesforce/schema/Contact.LastName';
import Phone from '@salesforce/schema/Contact.Phone';
import Email from '@salesforce/schema/Contact.Email';

export default class GetAccountDetails extends LightningElement {
   
    @api recordId;
    
    accountObj = Account;
    contactObj = Contact;
    Name = Name_Field;
    company = Company_FIELD;
    website = Website_FIELD;
    phone = Phone_FIELD;
    FirstNamefield = FirstName;
    LastNamefield = LastName;
    Emailfield = Email;
    Phonefield = Phone;
    iscreateContact = false;

    handleCreateContact(event){
       this.iscreateContact = true;
       console.log("successfully Clicked");
    }


    saveCreateContact(){
       const events = new ShowToastEvent({
            title: 'Contact Created',
            message: 'Contact Created Successfully',
            variant: 'success'
        });
        this.dispatchEvent(event);
        console.log("successfully created");
        this.iscreateContact = false;
    }


   
}
