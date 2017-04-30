public with sharing class ManyWhoCurrentUserController {
     
    @AuraEnabled
    public static ManyWhoUserInfo getUserInfo() {
        // Get the tenant id from custom settings
        String manywhoTenantId = null;
        ManyWho__c customSetting = ManyWho__c.getInstance('Default');
        if (customSetting != null) {
            manywhoTenantId = customSetting.Tenant_Id__c;
        }
    	
        ManyWhoUserInfo manywhoUserInfo = new ManyWhoUserInfo(
            userinfo.getSessionId(),
            System.URL.getSalesforceBaseURL().toExternalForm() + '/services/Soap/u/26.0/' + userInfo.getOrganizationId(),
            manywhoTenantId,
            userinfo.getUserId()
        );
            
        return manywhoUserInfo;
    }
    
    @AuraEnabled
    public static String getStateId(String id) {
        ManyWhoFlow__c[] manywhoflows = null;
        String stateId = null;
        
        if (String.isNotBlank(id)) {
            // If we have the id, find the associated ManyWhoFlow record
            manywhoflows = [SELECT JoinUri__c FROM ManyWhoFlow__c WHERE Id = :id];
            
            // Parse the state identifier out of the join uri
            if (manywhoflows.size() > 0 &&
                String.isNotBlank(manywhoflows[0].JoinUri__c)) {
                stateId = manywhoflows[0].JoinUri__c.split('join=')[1];
            }
        }

        return stateId;
    }
}