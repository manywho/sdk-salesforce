global class ManyWhoFlowLeadController {
    global String stateId { get; set; }
    global String tenantId { get; set; }

    global ManyWhoFlowLeadController(ApexPages.StandardController stdController) {
        String id;

        // Get the id if that exists
        id = ApexPages.currentPage().getParameters().get('id');

        if (String.isNotBlank(id)) {
            // If we have the id, find the associated ManyWhoFlow record
            Lead[] leadFlows = [SELECT JoinUri__c FROM Lead WHERE Id = :id];
            
            // Parse the state identifier out of the join uri
            if (leadFlows.size() > 0 &&
                String.isNotBlank(leadFlows[0].JoinUri__c)) {
                stateId = leadFlows[0].JoinUri__c.split('join=')[1];
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