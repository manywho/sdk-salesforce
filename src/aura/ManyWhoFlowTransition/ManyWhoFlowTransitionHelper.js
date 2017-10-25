({
	initializeFlowIfReady : function(cmp) {
        console.log("trying to initialize");
        
        var sessionLoaded = false;
        var scriptLoaded = false;
        var flowValuesLoaded = false;
        
        if (!$A.util.isUndefined(cmp.get("v.sessionLoaded")) && cmp.get("v.sessionLoaded") ) {
            console.log("session loaded")
            sessionLoaded = true;
        }
        
        if (!$A.util.isUndefined(cmp.get("v.scriptLoaded")) && cmp.get("v.scriptLoaded") ) {
            console.log("script loaded")
            scriptLoaded = true;
        }
        
        if (!$A.util.isUndefined(cmp.get("v.tenantId")) && cmp.get("v.tenantId") && 
        	!$A.util.isUndefined(cmp.get("v.flowId")) && cmp.get("v.flowId") && 
        	!$A.util.isUndefined(cmp.get("v.flowVersionId")) && cmp.get("v.flowVersionId")) {
            	console.log("tenantId, flowId and flowVersionId loaded")
            	flowValuesLoaded = true;
        }
        
    	if (sessionLoaded && scriptLoaded && flowValuesLoaded) {
        	console.log("initialize success");
       		manywho.initialize(); 
        } else{
        	console.log("Flow not initialized")
        }
    },
    
    persistUrlForSecurityCheck : function(cmp) {
        if (!$A.util.isUndefined(cmp.get("v.persistUrl")) && cmp.get("v.persistUrl")) {
        	var action = cmp.get("c.saveDomains");
        	action.setParams({ 
                communityName : cmp.get("v.communityName"), 
                lightningOriginPreview: cmp.get("v.lightningOriginPreview"), 
                lightningOriginProd: cmp.get("v.visualforceHostProd")
            });
        	
            action.setCallback(this, function(response) {
            	var state = response.getState();
            	if (state === "ERROR") {
                	var errors = response.getError();
                    
                	if (errors && errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                	}
            	}
        	});
        	
            $A.enqueueAction(action);
        }
	}
})