global with sharing class ManyWhoFlowController {

    private ManyWhoFlow__c[] manywhoflows;
    private ManyWhoSettingsHandler settingHandler;

    global ManyWhoFlowController(ApexPages.StandardController stdController) {
        String id = stdController.getId();
        settingHandler = new ManyWhoSettingsHandler('FlowDefault');

        if (String.isNotBlank(id)) {
            // If we have the id, find the associated ManyWhoFlow record
            manywhoflows = [SELECT JoinUri__c FROM ManyWhoFlow__c WHERE Id = :id];
            
            // Parse the state identifier out of the join uri
            if (manywhoflows.size() > 0 && String.isNotBlank(manywhoflows[0].JoinUri__c)) {
                stateId = manywhoflows[0].JoinUri__c.split('join=')[1];
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
