import { LightningElement, track, wire } from "lwc";
import { getPicklistValues , getObjectInfo} from "lightning/uiObjectInfoApi";

export default class GenericComponent extends LightningElement {

    @track objectName;
    @track fieldName;
    ObjectRecordTypeId;
    picklistValues = [];
    error;

    handleObjectNameChange(event) {
        this.objectName = event.target.value;
    }
    handleFieldNameChange(event) {
        this.fieldName = event.target.value;
    }
    
    @wire(getObjectInfo, { objectApiName: '$objectName' })
    results({error, data}){
        if(data){
            this.ObjectRecordTypeId = data.defaultRecordTypeId;
            console.log(this.ObjectRecordTypeId);
            this.error = undefined;
        }
        else if(error){
            this.ObjectRecordTypeId = undefined;
            this.error = error;
            console.log('error');
        }
    }

    @wire(getPicklistValues, {recordTypeId: '$ObjectRecordTypeId', fieldApiName: '$fieldApiName'})
    recordPicklistValue({error, data})
    {
        if(data){
            this.picklistValues = data.values.map(({ label, value }) => ({ label, value }));
            console.log('picklist values'+ this.picklistValues);
            this.error = undefined;
        }
        else if(error){
            this.error = error;
            this.picklistValues = undefined;
        }
    }

    get fieldApiName() {
        console.log('FIeld in fieldMap method()'+this.fieldName);
        return this.fieldName ? `${this.objectName}.${this.fieldName}` : '';     
    }    
}