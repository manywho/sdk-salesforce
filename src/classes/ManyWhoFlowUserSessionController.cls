public with sharing class ManyWhoFlowUserSessionController {

    private String lightningOrigin;
    private String communityName;
    
    private Boolean valid;
    
    public ManyWhoFlowUserSessionController() {
        Map<String, String> parameters = ApexPages.currentPage().getParameters();
        
        lightningOrigin = parameters.get('lightning-origin');
        communityName = parameters.get('community-name');
        valid = false;
    }

    public String getLightningOrigin() {
        return 'https://' + lightningOrigin;
    }

    public Boolean getValid() {
        List<ManyWhoCommunity__c> manyWhoCommunities = [Select Name, LightningOrigin__c  from ManyWhoCommunity__c where Name = :communityName limit 1];
        
        if (manyWhoCommunities.isEmpty()) {
            valid = false;
            return false;
        }
        
        ManyWhoCommunity__c manyWhoCommunity = manyWhoCommunities[0];

        valid =  !String.isBlank(lightningOrigin) && !String.isBlank(communityName) &&
                    lightningOrigin == manyWhoCommunities[0].LightningOrigin__c &&
                    communityName == manyWhoCommunities[0].Name;
        
        return valid;
    }
    
    @AuraEnabled
    public static void saveDomains(String communityName, String lightningOrigin) {
        delete [Select Name, LightningOrigin__c  from ManyWhoCommunity__c where Name= :communityName limit 1];
        ManyWhoCommunity__c manyWhoCommunity = new ManyWhoCommunity__c (Name=communityName, LightningOrigin__c= lightningOrigin);
        upsert (manyWhoCommunity);
    }
}