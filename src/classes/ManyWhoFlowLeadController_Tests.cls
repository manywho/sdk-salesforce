@isTest
private class ManyWhoFlowLeadController_Tests {

    static testMethod void ConstructorTest() {

        Lead testObject = new Lead();
        testObject.lastName = 'ok';
        testObject.Company = 'ok too';
        insert(testObject);

        ApexPages.StandardController sc = new ApexPages.StandardController(testObject);
        ManyWhoFlowLeadController ctr = new ManyWhoFlowLeadController(sc);
        PageReference pageRef = new PageReference('apex/BoomiFlowLead');
        pageRef.getParameters().put('id', String.valueOf(testObject));
        Test.setCurrentPage(pageRef);
    }

    static testMethod void ConstructorTestWithJoin() {
        PageReference pageRef = new PageReference('apex/BoomiFlowLead');
        Test.setCurrentPage(pageRef);
        Lead testLead = new Lead();
        testLead.lastName = 'ok';
        testLead.Company = 'ok too';
        testLead.JoinUri__c = 'url&join=12345';
        insert(testLead);

        ApexPages.currentPage().getParameters().put('id', String.valueOf(testLead.get('id')));
        ApexPages.StandardController sc = new ApexPages.StandardController(testLead);
        ManyWhoFlowLeadController ctr = new ManyWhoFlowLeadController(sc);
        System.assertEquals('12345', ctr.stateId);
    }
}
