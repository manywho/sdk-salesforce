@isTest
private class ManyWhoFlowAccountController_Tests {
  
  static testMethod void ConstructorTest() {

            Account testAccount = new Account();
            testAccount.name = 'my test';
            insert(testAccount);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(testAccount);
            ManyWhoFlowAccountController ctr = new ManyWhoFlowAccountController (sc);
            PageReference pageRef = new PageReference('apex/BoomiFlowAccounts');
            pageRef.getParameters().put('id', String.valueOf(testAccount));
            Test.setCurrentPage(pageRef);

    }
}