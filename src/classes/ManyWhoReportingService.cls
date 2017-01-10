@RestResource(urlMapping='/report')
global class ManyWhoReportingService {
 
    @HttpPost
    global static void doPost() {
        ManyWhoAPI.StateAPI stateAPI = null;
        JSONParser jsonParser = null;
        ManyWhoFlow__c flow = null;
        List<ManyWhoFlow__c> flows = null;
        
        if (RestContext.request.requestBody.toString() != null &&
            RestContext.request.requestBody.toString().trim().length() > 0) {
            // Get the JSON body in the request
            jsonParser = JSON.createParser(RestContext.request.requestBody.toString());
                
            // Parse out the state objects
            stateAPI = (ManyWhoAPI.StateAPI)jsonParser.readValueAs(ManyWhoAPI.StateAPI.class);
        
            String newSearchText = '%' + stateAPI.id + '%';
        
            flows = [SELECT Name FROM ManyWhoFlow__c WHERE JoinUri__c LIKE :newSearchText];
        
            if (flows != null &&
                flows.size() > 0) {
                flow = flows[0];
                
                // We serialize it back as it won't have a number of the fields that will be in the original string
                JSONGenerator jsonGenerator = JSON.createGenerator(false);
                jsonGenerator.writeObject(stateAPI);
                
                flow.Step__c = stateAPI.currentMapElementDeveloperName;
                flow.StateJSON__c = jsonGenerator.getAsString();
                
                update flow;
            }
        }
        
        RestContext.response.addHeader('Content-Type', 'application/json');
    }
}