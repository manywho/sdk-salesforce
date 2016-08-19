global class ManyWhoHttp {
    
    public static final String HTTP_ROOT_RUN_API = 'https://flow.manywho.com/api/run/1';
    
    public static List<ManyWhoAPI.FlowResponseAPI> getRunFlows(String tenantId, String flowName, Boolean isExactSearch) {
        
        JSONGenerator jsonGenerator = null;
        JSONParser jsonParser = null;
        HTTPResponse httpResponse = null;
        HttpRequest httpRequest = null;
        Http http = null;
        
        httpRequest = new HttpRequest();
        httpRequest.setMethod('GET');
        httpRequest.setHeader('ManyWhoTenant', tenantId);

        String query = '';

        if (!String.isBlank(flowName)) {
            flowName = EncodingUtil.urlEncode(flowName, 'UTF-8');
            
            if (isExactSearch) {
                query = '?filter=developerName eq \'' + flowName + '\'';
            } else {
                query = '?filter=substringof(developerName, \'' + flowName + '\')';
            }
        }
        
        httpRequest.setEndpoint(HTTP_ROOT_RUN_API + '/flow' + query);

        http = new Http();
        httpResponse = http.send(httpRequest);

        jsonParser = JSON.createParser(httpResponse.getBody());
        
        return (List<ManyWhoAPI.FlowResponseAPI>)jsonParser.readValueAs(List<ManyWhoAPI.FlowResponseAPI>.class);

    }

}