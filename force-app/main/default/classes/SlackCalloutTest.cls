@isTest
public with sharing class SlackCalloutTest {

    public class ExampleCalloutMock implements HttpCalloutMock{
        public HttpResponse respond(HTTPRequest req){
            HttpResponse res = new HttpResponse();
            res.setStatus('OK');
            res.setStatusCode(200);
            res.setBody('Salesforcescool');
            return res;
        }
    }
    static testmethod void testInvocableMethod(){

        String recordId = 'testRecordId';
        String oldValue = 'testOldValue';
        String newValue = 'testNewValue';
        
        Test.startTest();
        
        SlackCallout.FlowInput inputs = new SlackCallout.FlowInput();
        inputs.recordId = recordId;
        inputs.newValue = newValue;
        inputs.oldValue = oldValue;

        Test.setMock(HttpCalloutMock.class, new ExampleCalloutMock());
        List<SlackCallout.FlowOutput> outputs = SlackCallout.showOutputs(new List<SlackCallout.FlowInput> {inputs});
        Boolean calloutScheduled = outputs.get(0).calloutScheduled;
        System.assertEquals(true, calloutScheduled);
        Test.stopTest();
        
    }
}