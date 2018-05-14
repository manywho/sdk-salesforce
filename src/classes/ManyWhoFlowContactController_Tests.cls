@isTest
private class ManyWhoFlowContactController_Tests {
    static testMethod void ConstructorTest() {
        Contact testObject = new Contact();
        testObject.LastName = 'ok';
        insert(testObject);

        ApexPages.StandardController sc = new ApexPages.StandardController(testObject);
        ManyWhoFlowContactController ctr = new ManyWhoFlowContactController(sc);
        PageReference pageRef = new PageReference('apex/BoomiFlowContact');
        pageRef.getParameters().put('id', String.valueOf(testObject));
        Test.setCurrentPage(pageRef);
    }
    static testMethod void ConstructorTestWithJoin() {
        PageReference pageRef = new PageReference('apex/BoomiFlowContact');
        Test.setCurrentPage(pageRef);
        Contact testContact = new Contact();
        testContact.LastName = 'ok';
        testContact.JoinUri__c = 'url&join=12345';
        insert(testContact);

        ApexPages.currentPage().getParameters().put('id', String.valueOf(testContact.get('id')));
        ApexPages.StandardController sc = new ApexPages.StandardController(testContact);
        ManyWhoFlowContactController ctr = new ManyWhoFlowContactController(sc);
        System.assertEquals('12345', ctr.stateId);
    }
}
