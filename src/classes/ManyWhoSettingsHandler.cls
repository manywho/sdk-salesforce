/**
 * Created by jose on 15/05/18.
 *
 * This class handle the default flows for the visualforce pages with embedded flows
 * Note: non of the methods that are using defaultCustomSetting can be used in a constructor of a controller
 */

public  with sharing class ManyWhoSettingsHandler {
    private String settingName;
    private ManyWho_Flow_Config__c customSetting;

    public ManyWhoSettingsHandler(String settingName) {
        customSetting = null;
        this.settingName = settingName;
    }

    public String getTenantId() {
        return defaultCustomSetting().Tenant_Id__c;
    }

    public String getFlowId() {
        if (getParameterUri('flow-id') != null) {
            return getParameterUri('flow-id') ;
        } else {
            return defaultCustomSetting().Flow_Id__c;
        }
    }


    public String getFlowVersionId() {
        if (getParameterUri('flow-id') != null) {
            return getParameterUri('flow-version-id');
        } else {
            return '';
        }
    }

    public String getClientSideValidation() {
        return (defaultCustomSetting().Client_Side_Validation__c)?'true':'false';
    }

    public String getCollaborationUri() {
        if (defaultCustomSetting().Collaboration_Uri__c != null &&
                defaultCustomSetting().Collaboration_Uri__c.length()>0) {

            return '\'' + defaultCustomSetting().Collaboration_Uri__c + '\'';
        }else{
            return 'null';
        }
    }

    public String getIsWizardNavigation() {
        return (defaultCustomSetting().Is_Wizard_Navigation__c)?'true':'false';
    }

    public String getCollapsible() {
        return (defaultCustomSetting().Collapsible__c)?'true':'false';
    }

    public String getMode() {
        if (defaultCustomSetting().Mode__c != null && defaultCustomSetting().Mode__c.length()>0) {
            return '\''+ defaultCustomSetting().Mode__c+'\'';
        } else {
            return 'null';
        }
    }


    private String getParameterUri(String nameParameter) {
        if ( ApexPages.currentPage().getParameters().get(nameParameter) != null &&
                ApexPages.currentPage().getParameters().get(nameParameter).trim().length() > 0) {
            return ApexPages.currentPage().getParameters().get(nameParameter);
        } else {
            return null;
        }
    }

    private ManyWho_Flow_Config__c defaultCustomSetting() {
        if (customSetting != null) {
            return customSetting;
        }

        // check persistence, if exist setting with settingName then we use that configuration
        customSetting = ManyWho_Flow_Config__c.getInstance(settingName);
        if (customSetting != null) {
            return customSetting;
        }

        // the setting is not in the persistence we need to insert the value in persistence
        // with defaults values for tenantId, flowId, flowVersionId
        customSetting = new ManyWho_Flow_Config__c();
        customSetting.Tenant_Id__c = '080361ba-52e8-4001-a44f-4cc88eb54237';
        customSetting.Flow_Id__c = '13b6e4c6-03dd-46ba-85f4-5bab7d8dffc4';
        customSetting.Flow_Version_Id__c = '';

        customSetting.Client_Side_Validation__c = false;
        customSetting.Collaboration_Uri__c = '';
        customSetting.Is_Wizard_Navigation__c = false;
        customSetting.Collapsible__c = false;
        customSetting.Mode__c = '';


        customSetting.Name = settingName;

        // ToDo: this line is currently ignored, it would be good to fix this problem, because then the user will needs
        // to only edit the custom settings, currently the user needs to create a new ManyWho__c setting with name Default
        // and populate Tenant_Id Flow_Id and Flow_Version_Id

        insert (customSetting);

        return customSetting;
    }
}
