global class ManyWhoFlowLeadController {
    private ManyWhoSettingsHandler settingHandler;

    global ManyWhoFlowLeadController(ApexPages.StandardController stdController) {
        String id = stdController.getId();
        settingHandler = new ManyWhoSettingsHandler('LeadDefault');

        if (String.isNotBlank(id)) {
            // If we have the id, find the associated ManyWhoFlow record
            Lead[] leadFlows = [SELECT JoinUri__c FROM Lead WHERE Id = :id];
            
            // Parse the state identifier out of the join uri
            if (leadFlows.size() > 0 &&
                String.isNotBlank(leadFlows[0].JoinUri__c)) {
                stateId = leadFlows[0].JoinUri__c.split('join=')[1];
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

    global String clientSideValidation {
        get { return settingHandler.getClientSideValidation();}
        set;
    }

    global String collapsible {
        get { return settingHandler.getCollapsible();}
        set;
    }

    global String isWizardNavigation {
        get { return settingHandler.getIsWizardNavigation();}
        set;
    }

    global String collaborationUri {
        get { return settingHandler.getCollaborationUri();}
        set;
    }

    global String mode {
        get { return settingHandler.getMode();}
        set;
    }
}
