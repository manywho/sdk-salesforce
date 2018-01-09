@isTest
private class ManyWhoReportingService_Tests {

    static testMethod void myUnitTest() {
      
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Lead';  //Request URL
        req.httpMethod = 'POST';//HTTP Request Type
        req.requestBody = Blob.valueof('{}');
        RestContext.request = req;
        RestContext.response= res;

        ManyWhoReportingService.dopost();
        
    }
}