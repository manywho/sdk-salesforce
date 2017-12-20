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
        System.assertEquals(sessionController.getValid(), false);
    }
}