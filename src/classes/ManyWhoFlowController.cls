public class ManyWhoFlowController {

    private ManyWhoFlow__c[] manywhoflows;

    public String stateId { get; set; }
    public String tenantId { get; set; }

    public ManyWhoFlowController(ApexPages.StandardController stdController) {
        String id;

        // Get the id if that exists
        id = ApexPages.currentPage().getParameters().get('id');

        if (String.isNotBlank(id)) {
            // If we have the id, find the associated ManyWhoFlow record
            manywhoflows = [SELECT JoinUri__c FROM ManyWhoFlow__c WHERE Id = :id];
            
            // Parse the state identifier out of the join uri
            if (manywhoflows.size() > 0 &&
                String.isNotBlank(manywhoflows[0].JoinUri__c)) {
                stateId = manywhoflows[0].JoinUri__c.split('join=')[1];
            }
        }
        
        // Get the tenant id from custom settings
        ManyWho__c customSetting = ManyWho__c.getInstance('Default');
        if (customSetting != null) {
            tenantId = customSetting.Tenant_Id__c;
        } else {
            tenantId = '';
        }
    }
}