import { LightningElement, track, api } from 'lwc';
import createContact from '@salesforce/apex/ContactControllerComponent.createContact';


export default class ContactSaveForm extends LightningElement {
   
   contacts; 
   @track isShowModal = true;
   @api accountId;

   handleCloseAction(){
     this.isShowModal = false;
     console.log('Cloasessdd');

   }
   
   handleChange(event){
      const field = event.target.name;
      if(field === 'FirstName'){
         this.FirstName = event.target.value;
     
      }
      else if(field === 'LastName'){
         this.LastName = event.target.value;
         console.log(this.LastName);
      }
      else if(field === 'AccountId'){
        this.AccountId = {accountId};
     }
      else if(field === 'Email'){
         this.Email = event.target.value;
      }
      else if(field === 'Phone'){
         this.Phone = event.target.value;
      }

   }
  

   handleSaveContact(event){
      console.log('Action clickedd');
      createContact({firstname: this.FirstName, lastname: this.LastName, email: this.Email, phone: this.Phone, accountid: this.AccountId})
      .then((result) => {
         console.log('save result' + result);
      })
      .catch((error) => {
         console.log(error);
      });
      this.isShowModal = false;
   }

}