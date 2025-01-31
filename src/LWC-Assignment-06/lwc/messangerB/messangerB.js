import { LightningElement, wire} from 'lwc';
import { subscribe, unsubscribe, publish,  MessageContext } from 'lightning/messageService';
import MESSAGECHANNELATOB_CHANNEL from '@salesforce/messageChannel/messagerChannelAtoB__c';
import MESSAGECHANNELBTOA_CHANNEL from '@salesforce/messageChannel/messagerChannelBtoA__c';

export default class MessangerB extends LightningElement {

    //recevied Message from A to publish
    recevicedMessageA;
    subscription = null;

    @wire(MessageContext)
    messageContext;

    connectedCallback() {
        this.subscribeToMessageChannel();
    }

    disconnectedCallback() {
        this.unsubscribeToMessageChannel();
    }

    subscribeToMessageChannel(){
       
            this.subscription = subscribe(this.messageContext, MESSAGECHANNELATOB_CHANNEL, 
                                (message) => this.handleMessage(message)
                                );
        
    }

    unsubscribeToMessageChannel() {
        unsubscribe(this.subscription);
       
    }


    handleMessage(message){

           this.recevicedMessageA =  message.inputMessagerA;
           console.log(this.recevicedMessageA);
       
    }

    //published the message From MessagerB
    handleChangeMessageB(){
    
            const messageInput = this.template.querySelector('lightning-input').value;
            const payload = {
                inputMessagerB: messageInput
            };
            publish(this.messageContext, MESSAGECHANNELBTOA_CHANNEL, payload);
    }
}