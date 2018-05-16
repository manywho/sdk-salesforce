@isTest
private class ManyWhoFlowAccountController_Tests {

    static testMethod void ConstructorTest() {

        Account testAccount = new Account();
        testAccount.name = 'my test';
        insert(testAccount);

        ApexPages.StandardController sc = new ApexPages.StandardController(testAccount);
        ManyWhoFlowAccountController ctr = new ManyWhoFlowAccountController(sc);
        PageReference pageRef = new PageReference('apex/BoomiFlowAccounts');
        pageRef.getParameters().put('id', String.valueOf(testAccount));
        Test.setCurrentPage(pageRef);

    }

    static testMethod void ConstructorTestWithJoin() {
        PageReference pageRef = new PageReference('apex/BoomiFlowAccounts');
        Test.setCurrentPage(pageRef);
        Account testAccount = new Account();
        testAccount.name = 'my test';
        testAccount.JoinUri__c = 'url&join=12345';
        insert(testAccount);

        ApexPages.currentPage().getParameters().put('id', String.valueOf(testAccount.get('id')));
        ApexPages.StandardController sc = new ApexPages.StandardController(testAccount);
        ManyWhoFlowAccountController ctr = new ManyWhoFlowAccountController(sc);
        System.assertEquals('12345', ctr.stateId);
        System.assertEquals('1ae14654-0699-401f-aaf6-f0adbb5418c8', ctr.tenantId);
        System.assertEquals('0fabfe3a-3226-4288-8ea0-be69bb9cb612', ctr.flowId);
        System.assertEquals('', ctr.flowVersionId);
    }
}
