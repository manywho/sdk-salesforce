@isTest
private class ManyWhoFlowContactController_Tests {
  
  static testMethod void ConstructorTest() {

            Contact testObject = new Contact();
            testObject.lastName = 'ok';
            insert(testObject);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(testObject);
            ManyWhoFlowContactController ctr = new ManyWhoFlowContactController (sc);
            PageReference pageRef = new PageReference('apex/BoomiFlowContact');
            pageRef.getParameters().put('id', String.valueOf(testObject));
            Test.setCurrentPage(pageRef);
    }
}