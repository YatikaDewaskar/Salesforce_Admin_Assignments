import { LightningElement, track, api } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import ACCOUNTNAME_FIELD from '@salesforce/schema/Account.Name';
import ACCOUNTDESP_FIELD from '@salesforce/schema/Account.Description';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';



export default class ContactSaveForm extends LightningElement {
   
   accounts; 
   @track isShowModal = true;
   isOpenCreateContact = false;
   @api selectedAccountId;

   accountName = '';
   description = '';
   phone = '';

   handleCloseAction(){
     this.isShowModal = false;
     console.log('Cloasessdd');

   }
   
   handleChange(event){
      const field = event.target.name;
      if(field === 'Name'){
         this.accountName = event.target.value;
         console.log(this.accountName);
      }
      else if(field === 'Phone'){
        this.phone = event.target.value;
        console.log(this.phone);
     }
      else if(field === 'Description'){
         this.description = event.target.value;
        }

       
   }
   handleChangeEvent(event){
    this.selectedAccountId = event.detail.id;
   }

  
   handleSaveAccount(event){
      console.log('Action clickedd');
      const fields = {};
        fields[ACCOUNTNAME_FIELD.fieldApiName] = this.accountName;
        fields[PHONE_FIELD.fieldApiName] = this.phone;
        fields[ACCOUNTDESP_FIELD.fieldApiName] = this.description;
        
        const recordInput = { apiName: ACCOUNT_OBJECT.objectApiName, fields };

        createRecord(recordInput)
        .then(record => {
            console.log('record'+JSON.stringify(record));
            console.log('record Createdd');
          
        })
        .catch(error => {
            console.log(error);
            console.log('error');
        })
       
        this.isOpenCreateContact = true;
       
        
   }

}