import { LightningElement, track , api} from 'lwc';
import createContact from '@salesforce/apex/ContactController.createContact';


export default class ContactSaveForm extends LightningElement {
   
   contacts; 
   @track isShowModal = true;
   @api accountid;
   @api errorMessage;
   isError = false;
   handleCloseAction(){
     this.isShowModal = false;
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
      else if(field === 'Email'){
         this.Email = event.target.value;
      }
      else if(field === 'Phone'){
         this.Phone = event.target.value;
      }
   }
  
   createContactOnSave(){
      createContact({firstname: this.FirstName, lastname: this.LastName, email: this.Email, phone: this.Phone, accountId : this.accountid })
      .then((result) => {
        console.log('save result' + result);
        this.dispatchEvent(new CustomEvent("savecontact"));
     })
     .catch((error) => {
        console.log(error);
     });
     this.isShowModal = false;  
   }

   handleSaveContact(event){
      event.preventDefault();
      if(!this.LastName)
      {
         this.errorMessage = 'Please enter last name';
         this.isError = true;
      }
      else{
         this.isError = false;
      }
      if(!this.Email)
      {
         this.errorMessage = 'Please enter email';
         this.isError = true;
      }
      else if(!this.validateEmail(this.Email)){
         this.errorMessage = 'Please enter valid email address';
         this.isError = true;
      }
      else{
         this.isError = false;
         this.createContactOnSave();
         
      }
      
   }

   validateEmail(email){
      const regexPattern = /[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
      return regexPattern.test(email);
    }
   
   
}