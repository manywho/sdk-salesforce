@isTest
private class ManyWhoFlowOpportunityController_Tests {

    static testMethod void ConstructorTest() {

        Opportunity testOpportunity = new Opportunity();
        testOpportunity.Name = 'ok';
        testOpportunity.StageName = 'ok too';
        testOpportunity.CloseDate = Date.newInstance(2020, 2, 3);
        insert(testOpportunity);

        ApexPages.StandardController sc = new ApexPages.StandardController(testOpportunity);
        ManyWhoFlowOpportunityController ctr = new ManyWhoFlowOpportunityController(sc);
        PageReference pageRef = new PageReference('apex/BoomiFlowOpportunity');
        pageRef.getParameters().put('id', String.valueOf(testOpportunity));
        Test.setCurrentPage(pageRef);
    }

    static testMethod void ConstructorTestWithJoin() {
        PageReference pageRef = new PageReference('apex/BoomiFlowLead');
        Test.setCurrentPage(pageRef);
        Opportunity testOpportunity = new Opportunity();
        testOpportunity.Name = 'ok';
        testOpportunity.StageName = 'ok too';
        testOpportunity.CloseDate = Date.newInstance(2020, 2, 3);
        testOpportunity.JoinUri__c = 'url&join=12345';
        insert(testOpportunity);

        ApexPages.currentPage().getParameters().put('id', String.valueOf(testOpportunity.get('id')));
        ApexPages.StandardController sc = new ApexPages.StandardController(testOpportunity);
        ManyWhoFlowOpportunityController ctr = new ManyWhoFlowOpportunityController(sc);
        System.assertEquals('12345', ctr.stateId);
        System.assertEquals('080361ba-52e8-4001-a44f-4cc88eb54237', ctr.tenantId);
        System.assertEquals('13b6e4c6-03dd-46ba-85f4-5bab7d8dffc4', ctr.flowId);
        System.assertEquals('null', ctr.collaborationUri);
        System.assertEquals('false', ctr.clientSideValidation);
        System.assertEquals('false', ctr.isWizardNavigation);
        System.assertEquals('null', ctr.mode);
        System.assertEquals('false', ctr.collapsible);
        System.assertEquals('', ctr.flowVersionId);
    }
}
