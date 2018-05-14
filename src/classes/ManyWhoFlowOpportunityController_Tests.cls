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
    }
}
