/**
 * Created by jose on 14/05/18.
 */

@IsTest
private class ManyWhoFlowCaseController_Tests {
    static testMethod void ConstructorTest() {

        Case testCase = new Case();
        insert(testCase);

        ApexPages.StandardController sc = new ApexPages.StandardController(testCase);
        ManyWhoFlowCaseController ctr = new ManyWhoFlowCaseController (sc);
        PageReference pageRef = new PageReference('apex/BoomiFlowCase');
        pageRef.getParameters().put('id', String.valueOf(testCase));
        Test.setCurrentPage(pageRef);

    }

    static testMethod void ConstructorTestWithJoin() {
        PageReference pageRef = new PageReference('apex/BoomiFlowCase');
        Test.setCurrentPage(pageRef);
        Case testCase = new Case();
        testCase.JoinUri__c = 'url&join=12345';
        insert(testCase);

        ApexPages.currentPage().getParameters().put('id', String.valueOf(testCase.get('id')));
        ApexPages.StandardController sc = new ApexPages.StandardController(testCase);
        ManyWhoFlowCaseController ctr = new ManyWhoFlowCaseController (sc);
        System.assertEquals('12345', ctr.stateId);
    }
}
