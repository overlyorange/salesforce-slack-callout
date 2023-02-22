public with sharing class SlackCallout {

    /////////////////////
    //  SLACK CALLOUT  //
    /////////////////////

    @future(callout=true)
    public static void announceFieldUpdate(
      String recordId,
      String oldValue,
      String newValue
    ) {
  
      HttpRequest req = new HttpRequest();
      HttpResponse res = new HttpResponse();
      Http http = new Http();
  
      JSONGenerator jsGen = JSON.createGenerator(true);
      jsGen.writeStartObject();
      jsGen.writeStringField('Record ID', String.valueOf(recordId));
      jsGen.writeStringField('Old Value', String.valueOf(oldValue));
      jsGen.writeStringField('New Value', String.valueOf(newValue));

      jsGen.writeEndObject();
  
      req.setEndpoint(
        '{{ENTER_SLACK_WEBHOOK_HERE}}'
      );
      req.setMethod('POST');
      req.setBody(jsGen.getAsString());
  
      try {
        res = http.send(req);
      } catch (System.CalloutException e) {
        System.debug('Callout error: ' + e);
        System.debug(res.toString());
      }
    }

    ////////////////////////
    //  INVOCABLE METHOD  //
    ////////////////////////

    @InvocableMethod(
        label='Announce Record Update on Slack'
        description='Sends a Slack notification to #channel'
      )
      public static List<FlowOutput> showOutputs(List<FlowInput> inputs) {

        FlowInput objInput = inputs.get(0);
        String recordId = objInput.recordId;
        String oldValue = objInput.oldValue;
        String newValue = objInput.newValue;
    
    
        List<FlowOutput> outputs = new List<FlowOutput>();
        FlowOutput objOutput = new FlowOutput();
        objOutput.calloutScheduled = false;
    
        if (recordId != null) {
            announceFieldUpdate(recordId, oldValue, newValue);
            objOutput.calloutScheduled = true;
        }
    
        outputs.add(objOutput);
        return outputs;
      }
    
      public class FlowOutput {
        @InvocableVariable(required=true)
        public Boolean calloutScheduled;
      }
    
      public class FlowInput {

        @InvocableVariable(label='Record for Input' description='yourDescription' required=true)
        public String recordId;
    
        @InvocableVariable(label='Old Value' description='yourDescription' required=true)
        public String oldValue;
    
        @InvocableVariable(label='New Value' description='yourDescription' required=true)
        public String newValue;
    
      }
}