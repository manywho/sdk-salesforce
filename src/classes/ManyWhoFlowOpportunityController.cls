global class ManyWhoFlowOpportunityController {
    private ManyWhoSettingsHandler settingHandler;

    global ManyWhoFlowOpportunityController(ApexPages.StandardController stdController) {
        String id = ApexPages.currentPage().getParameters().get('id');
        settingHandler = new ManyWhoSettingsHandler('OpportunityDefault');

        if (String.isNotBlank(id)) {
            // If we have the id, find the associated ManyWhoFlow record
            Opportunity[] opportunityFlows = [SELECT JoinUri__c FROM Opportunity WHERE Id = :id];
            
            // Parse the state identifier out of the join uri
            if (opportunityFlows.size() > 0 &&
                String.isNotBlank(opportunityFlows[0].JoinUri__c)) {
                stateId = opportunityFlows[0].JoinUri__c.split('join=')[1];
            }
        }

    }

    global String stateId { get; set; }

    global String tenantId {
        get { return settingHandler.getTenantId();}
        set;
    }

    global String flowId {
        get { return settingHandler.getFlowId();}
        set;
    }

    global String flowVersionId {
        get { return settingHandler.getFlowVersionId();}
        set;
    }
}
