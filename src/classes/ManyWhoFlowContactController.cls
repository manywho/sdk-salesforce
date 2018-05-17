global class ManyWhoFlowContactController {
    private ManyWhoSettingsHandler settingHandler;

    global ManyWhoFlowContactController(ApexPages.StandardController stdController) {
        String id = stdController.getId();
        settingHandler = new ManyWhoSettingsHandler('ContactDefault');

        if (String.isNotBlank(id)) {
            // If we have the id, find the associated ManyWhoFlow record
            Contact[] contactFlows = [SELECT JoinUri__c FROM Contact WHERE Id = :id];
            
            // Parse the state identifier out of the join uri
            if (contactFlows.size() > 0 &&
                String.isNotBlank(contactFlows[0].JoinUri__c)) {
                stateId = contactFlows[0].JoinUri__c.split('join=')[1];
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
