@isTest
private class ManyWhoCurrentUserController_Tests {
	
	static testMethod void getUserInfoTest() {
         // Create a dummy manywho flow to check against        
        ManyWhoUserInfo info = ManyWhoCurrentUserController.getUserInfo();
        
        System.assertNotEquals('', info.sessionId);
        System.assertNotEquals('', info.sessionUrl);
        System.assertEquals(null, info.tenantId);
        System.assertNotEquals(null, info.userId);
    	
    }
    
    static testMethod void getStateIdTest() {
         // Create a dummy manywho flow to check against        
        String id = ManyWhoCurrentUserController.getStateId('1');
        System.assertEquals(null, id);
    }
}