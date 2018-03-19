@isTest
private class ManyWhoFlowLeadController_Tests {
  
  static testMethod void ConstructorTest() {

            Lead testObject = new Lead();
            testObject.lastName = 'ok';
            testObject.Company = 'ok too';
            insert(testObject);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(testObject);
            ManyWhoFlowLeadController ctr = new ManyWhoFlowLeadController (sc);
            PageReference pageRef = new PageReference('apex/BoomiFlowLead');
            pageRef.getParameters().put('id', String.valueOf(testObject));
            Test.setCurrentPage(pageRef);
    }
}