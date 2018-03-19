@isTest
private class ManyWhoFlowOpportunityController_Tests {
  
  static testMethod void ConstructorTest() {

            Opportunity testOpportunity = new Opportunity();
            testOpportunity.Name = 'ok';
            testOpportunity.StageName = 'ok too';
            testOpportunity.CloseDate = Date.newInstance(2020,2,3);
            insert(testOpportunity);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(testOpportunity);
            ManyWhoFlowOpportunityController ctr = new ManyWhoFlowOpportunityController (sc);
            PageReference pageRef = new PageReference('apex/BoomiFlowAccounts');
            pageRef.getParameters().put('id', String.valueOf(testOpportunity));
            Test.setCurrentPage(pageRef);

    }
}