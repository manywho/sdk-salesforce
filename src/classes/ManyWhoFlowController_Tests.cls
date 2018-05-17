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
        System.assertEquals('1ae14654-0699-401f-aaf6-f0adbb5418c8', manywhoController.tenantId);
        System.assertEquals('0fabfe3a-3226-4288-8ea0-be69bb9cb612', manywhoController.flowId);
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
        System.assertEquals('1ae14654-0699-401f-aaf6-f0adbb5418c8', manywhoController.tenantId);
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
        System.assertEquals('1ae14654-0699-401f-aaf6-f0adbb5418c8', manywhoController.tenantId);
        System.assertEquals('0fabfe3a-3226-4288-8ea0-be69bb9cb612', manywhoController.flowId);
        System.assertEquals('null', manywhoController.collaborationUri);
        System.assertEquals('false', manywhoController.clientSideValidation);
        System.assertEquals('false', manywhoController.isWizardNavigation);
        System.assertEquals('null', manywhoController.mode);
        System.assertEquals('false', manywhoController.collapsible);
        System.assertEquals('', manywhoController.flowVersionId);
    }

}
