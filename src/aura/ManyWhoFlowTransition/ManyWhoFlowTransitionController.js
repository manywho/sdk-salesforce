({
    doInit: function(cmp, event, helper) {
        
        var visualforceOriginPreview = "https://" + cmp.get("v.visualforceHostPreview");
        var visualforceOriginProd = "https://" + cmp.get("v.visualforceHostProd");
        
        window.addEventListener("message", function(event) {
            try {
            	if (event.origin !== visualforceOriginPreview  && event.origin !== visualforceOriginProd) {
                	return;
            	}
                
            	var sessionData = JSON.parse(event.data);
            	cmp.set("v.sessionId", sessionData.sessionId);
            	cmp.set("v.sessionUrl", sessionData.sessionUrl);
            	cmp.set("v.sessionLoaded", true);
				
                helper.persistUrlForSecurityCheck(cmp);
                helper.initializeFlowIfReady(cmp);
            } catch(error) {
                return;
            }
        }, false);
    },
    
    afterScriptsLoaded : function(cmp, event, helper) {
        cmp.set("v.scriptLoaded", true);
        
        helper.persistUrlForSecurityCheck(cmp);
        helper.initializeFlowIfReady(cmp);
    }
 })