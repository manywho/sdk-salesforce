@istest
public class ManyWhoFlowController_Tests {

    private static testmethod void TestManyWhoFlowController() {
        // Create a dummy manywho flow to check against        
        ManyWhoFlow__c flow = new ManyWhoFlow__c();
        flow.Name = 'Test';
        insert flow;

        // Put the manywho flow into the page parameters
        ApexPages.currentPage().getParameters().put('id', flow.id);
        ApexPages.StandardController manywhoFlowController = new ApexPages.StandardController(flow);
        ManyWhoFlowController manywhoController  = new ManyWhoFlowController(manywhoFlowController);
    }

}