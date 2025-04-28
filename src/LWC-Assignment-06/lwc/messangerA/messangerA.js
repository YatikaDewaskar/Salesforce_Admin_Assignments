import { LightningElement, wire } from 'lwc';
import {publish, subscribe, unsubscribe,  MessageContext} from 'lightning/messageService';
import MESSAGECHANNELATOB_CHANNEL from '@salesforce/messageChannel/messagerChannelAtoB__c';
import MESSAGECHANNELBTOA_CHANNEL from '@salesforce/messageChannel/messagerChannelBtoA__c';

export default class MessangerA extends LightningElement {

    @wire (MessageContext) 
    messageContext;
     
    recevicedMessageB;
    subscription = null;

    connectedCallback() {
        this.subscribeToMessageChannel();
    }
    disconnectedCallback() {
        this.unsubscribeToMessageChannel();
    }
    subscribeToMessageChannel(){
            if(!this.subscription){
                this.subscription = subscribe(this.messageContext, MESSAGECHANNELBTOA_CHANNEL, 
                                    (message) => this.handleMessage(message)
                                    );
            }
    }
    
    unsubscribeToMessageChannel() {
            unsubscribe(this.subscription);
            this.subscription = null;
    }
    
    
    handleMessage(message){
    
               this.recevicedMessageB =  message.inputMessagerB;
               console.log(this.recevicedMessageB);
           
    }

    //publish MessagerA message to MessagerB
    handleChangeMessagerA(){

        const messageInput = this.template.querySelector('lightning-input').value;
        const payload = {
            inputMessagerA: messageInput,
            
        };
        console.log(payload);
        publish(this.messageContext, MESSAGECHANNELATOB_CHANNEL, payload);
    }
}