import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {

    parentGreetting;
    handleChangeGreetings(event){
        this.parentGreetting = event.target.value;
    }
}
