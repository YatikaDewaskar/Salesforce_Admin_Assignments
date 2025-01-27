import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {

    
 //   handleMessage(event){
 //      this.parentVar = this.template.querySelector('c-child-component').message;
 //   }

 //   handleMethod(event){
 //       this.parentVar = this.template.querySelector('c-child-component').changeMessage();
 //   }

    parentGreetting;
    handleChangeGreetings(event){
        this.parentGreetting = event.target.value;
    }
}