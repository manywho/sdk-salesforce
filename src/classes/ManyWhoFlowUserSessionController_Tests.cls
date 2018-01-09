@isTest
public class ManyWhoFlowUserSessionController_Tests {

    public static testMethod void myUnitTestConstructor() {
        ManyWhoFlowUserSessionController sessionController = new ManyWhoFlowUserSessionController();
    }
    
     public static testMethod void myUnitTestLightningOriginProd() {
        ManyWhoFlowUserSessionController sessionController = new ManyWhoFlowUserSessionController();
        System.assertEquals('https://null', sessionController.getLightningOriginProd());
    }
    
     public static testMethod void myUnitTestLightningOriginPreview() {
        ManyWhoFlowUserSessionController sessionController = new ManyWhoFlowUserSessionController();
        System.assertEquals('https://null', sessionController.getLightningOriginPreview());
    }
    
     public static testMethod void myUnitTestGetValid() {
        ManyWhoFlowUserSessionController sessionController = new ManyWhoFlowUserSessionController();
        System.assertEquals(false, sessionController.getValid());
    }
    
    public static testMethod void myUnitTestGetValidCommunites() {
    	Test.setCurrentPageReference(new PageReference('Page.myPage'));
   		System.currentPageReference().getParameters().put('lightning-origin-preview', 'lightningOriginPreview');
		System.currentPageReference().getParameters().put('lightning-origin-prod', 'lightningOriginProd');
		System.currentPageReference().getParameters().put('community-name', 'communityName');
		
		ManyWhoCommunity__c manyWhoCommunity = new ManyWhoCommunity__c(Name='communityName', LightningOriginProd__c='lightningOriginProd', LightningOriginPreview__c = 'lightningOriginPreview' );
		insert manyWhoCommunity;
    	
    	ManyWhoFlowUserSessionController sessionController = new ManyWhoFlowUserSessionController();
    	ManyWhoFlowUserSessionController.saveDomains('communityName','lightningOriginPreview','lightningOriginProd');
    	
    	Boolean valid = sessionController.getValid();
    	System.assertEquals(true, sessionController.getValid());
    	
    }
}
