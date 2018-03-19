global class ManyWhoFlowOpportunityController {
    global String stateId { get; set; }
    global String tenantId { get; set; }

    global ManyWhoFlowOpportunityController(ApexPages.StandardController stdController) {
        String id;

        // Get the id if that exists
        id = ApexPages.currentPage().getParameters().get('id');

        if (String.isNotBlank(id)) {
            // If we have the id, find the associated ManyWhoFlow record
            Opportunity[] opportunityFlows = [SELECT JoinUri__c FROM Opportunity WHERE Id = :id];
            
            // Parse the state identifier out of the join uri
            if (opportunityFlows.size() > 0 &&
                String.isNotBlank(opportunityFlows[0].JoinUri__c)) {
                stateId = opportunityFlows[0].JoinUri__c.split('join=')[1];
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