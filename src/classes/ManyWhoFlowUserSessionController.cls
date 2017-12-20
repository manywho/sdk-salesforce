public with sharing class ManyWhoFlowUserSessionController {
    
    private String lightningOriginPreview;
    private String lightningOriginProd;
    private String lightningOrigin;
    private String communityName;
    
    private Boolean valid;
    
    public ManyWhoFlowUserSessionController() {
        Map<String, String> parameters = ApexPages.currentPage().getParameters();
        
        lightningOriginPreview = parameters.get('lightning-origin-preview');
        lightningOriginProd = parameters.get('lightning-origin-prod');
        communityName = parameters.get('community-name');
        valid = false;
    }
    
    public String getLightningOriginProd() {
        return 'https://' + lightningOriginProd;
    }
    	
    public String getLightningOriginPreview() { 
        return 'https://' + lightningOriginPreview;
    }
    
    public Boolean getValid() {
        List<ManyWhoCommunity__c> manyWhoCommunities = [Select Name, LightningOriginProd__c, LightningOriginPreview__c  from ManyWhoCommunity__c where Name = :communityName limit 1];
        
        if (manyWhoCommunities.isEmpty()) {
        	valid = false;
            return false;
        }
        
        ManyWhoCommunity__c manyWhoCommunity = manyWhoCommunities[0];

        valid = !String.isBlank(lightningOriginPreview) && !String.isBlank(lightningOriginProd) && !String.isBlank(communityName) &&
            		lightningOriginPreview == manyWhoCommunities[0].LightningOriginPreview__c &&
            	 	lightningOriginProd == manyWhoCommunities[0].LightningOriginProd__c &&
            		communityName == manyWhoCommunities[0].Name;
        
        return valid;
    }
    
    @AuraEnabled
    public static void saveDomains(String communityName, String lightningOriginPreview, String lightningOriginProd) {        
        delete [Select Name, LightningOriginProd__c, LightningOriginPreview__c  from ManyWhoCommunity__c where Name= :communityName limit 1];
		ManyWhoCommunity__c manyWhoCommunity = new ManyWhoCommunity__c (Name=communityName, LightningOriginProd__c=lightningOriginProd, LightningOriginPreview__c=lightningOriginPreview );
		upsert (manyWhoCommunity);
    }
}