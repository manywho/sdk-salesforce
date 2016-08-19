global class ManyWhoHttpMock implements HttpCalloutMock {
    private String json;
    
    public ManyWhoHttpMock(String developerName, String developerSummary) {
        if (String.isNotBlank(developerName) &&
            String.isNotBlank(developerSummary)) {
            json = '[{"id":{"id": "abcd","versionId": "efgh"},"developerName": "' + developerName + '","developerSummary": "' + developerSummary + '","startMapElementId": "ijkl"}]';
        } else {
            json = null;
        }
    }
    
    global HTTPResponse respond(HTTPRequest req) {

        HttpResponse res;

        if (req.getEndpoint().indexOf('api/run/1/flow') > 0) {
            System.assertEquals('GET', req.getMethod());
        
            // Return a basic list of Flows
            res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody(json);
            res.setStatusCode(200);
    
            return res;
        }

        res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(500);
        
        return res;

    }
}