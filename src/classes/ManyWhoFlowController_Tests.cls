@istest
public class ManyWhoFlowController_Tests {

    private static testmethod void TestManyWhoFlowController() {

        // Create a dummy manywho flow to check against
        ManyWhoFlow__c flow = new ManyWhoFlow__c();
        flow.Name = 'My Flow';
        insert flow;

        ApexPages.StandardController manywhoFlowController = new ApexPages.StandardController(flow);
        ManyWhoFlowController manywhoController  = new ManyWhoFlowController(manywhoFlowController);
        PageReference pageRef = new PageReference('apex/ManyWhoFlow');
        //pageRef.getParameters().put('id', String.valueOf(testObject));
        Test.setCurrentPage(pageRef);

        System.assertEquals(true, true);
        System.assertEquals('080361ba-52e8-4001-a44f-4cc88eb54237', manywhoController.tenantId);
        System.assertEquals('13b6e4c6-03dd-46ba-85f4-5bab7d8dffc4', manywhoController.flowId);
    }


    private static testmethod void TestManyWhoFlowControllerWithParameters() {

        // Create a dummy manywho flow to check against
        ManyWhoFlow__c flow = new ManyWhoFlow__c();
        flow.Name = 'My Flow';
        insert flow;

        ApexPages.StandardController manywhoFlowController = new ApexPages.StandardController(flow);
        ManyWhoFlowController manywhoController  = new ManyWhoFlowController(manywhoFlowController);
        PageReference pageRef = new PageReference('apex/ManyWhoFlow');
        pageRef.getParameters().put('flow-id', '1234');
        pageRef.getParameters().put('flow-version-id', '123456');

        Test.setCurrentPage(pageRef);

        System.assertEquals(true, true);
        System.assertEquals('080361ba-52e8-4001-a44f-4cc88eb54237', manywhoController.tenantId);
        System.assertEquals('1234', manywhoController.flowId);
        System.assertEquals('123456', manywhoController.flowVersionId);
    }

    private static testmethod void TestManyWhoFlowControllerWithParametesrWithoutVersionId() {

        // Create a dummy manywho flow to check against
        ManyWhoFlow__c flow = new ManyWhoFlow__c();
        flow.Name = 'My Flow';
        insert flow;

        ApexPages.StandardController manywhoFlowController = new ApexPages.StandardController(flow);
        ManyWhoFlowController manywhoController  = new ManyWhoFlowController(manywhoFlowController);
        PageReference pageRef = new PageReference('apex/ManyWhoFlow');
        pageRef.getParameters().put('flow-version-id', '123456');

        Test.setCurrentPage(pageRef);

        System.assertEquals(true, true);
        System.assertEquals('080361ba-52e8-4001-a44f-4cc88eb54237', manywhoController.tenantId);
        System.assertEquals('13b6e4c6-03dd-46ba-85f4-5bab7d8dffc4', manywhoController.flowId);
        System.assertEquals('null', manywhoController.collaborationUri);
        System.assertEquals('false', manywhoController.clientSideValidation);
        System.assertEquals('false', manywhoController.isWizardNavigation);
        System.assertEquals('null', manywhoController.mode);
        System.assertEquals('false', manywhoController.collapsible);
        System.assertEquals('', manywhoController.flowVersionId);
    }

}
