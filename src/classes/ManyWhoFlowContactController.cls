global class ManyWhoFlowContactController {
    global String stateId { get; set; }
    global String tenantId { get; set; }

    global ManyWhoFlowContactController(ApexPages.StandardController stdController) {
        String id;

        // Get the id if that exists
        id = ApexPages.currentPage().getParameters().get('id');

        if (String.isNotBlank(id)) {
            // If we have the id, find the associated ManyWhoFlow record
            Contact[] contactFlows = [SELECT JoinUri__c FROM Contact WHERE Id = :id];
            
            // Parse the state identifier out of the join uri
            if (contactFlows.size() > 0 &&
                String.isNotBlank(contactFlows[0].JoinUri__c)) {
                stateId = contactFlows[0].JoinUri__c.split('join=')[1];
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