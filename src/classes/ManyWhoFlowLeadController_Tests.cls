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
