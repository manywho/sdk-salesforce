({
    initializeFlowIfReady : function(cmp) {
        console.log("trying to initialize");

        var sessionLoaded = false;
        var scriptLoaded = false;
        var flowValuesLoaded = false;

        if (!$A.util.isUndefined(cmp.get("v.sessionLoaded")) && cmp.get("v.sessionLoaded") ) {
            console.log("session loaded");
            sessionLoaded = true;
        }

        if (!$A.util.isUndefined(cmp.get("v.scriptLoaded")) && cmp.get("v.scriptLoaded") ) {
            console.log("script loaded");
            scriptLoaded = true;
        }

        if (!$A.util.isUndefined(cmp.get("v.tenantId")) && cmp.get("v.tenantId") &&
            !$A.util.isUndefined(cmp.get("v.flowId")) && cmp.get("v.flowId")){
            if ($A.util.isUndefined(cmp.get("v.flowVersionId")) || cmp.get("v.flowVersionId") == ""){
                cmp.set("v.flowVersionId", null);
            }

            console.log("tenantId, flowId and flowVersionId loaded")
            flowValuesLoaded = true;
        }
		
		if (sessionLoaded && scriptLoaded && flowValuesLoaded) {
            var flowToLoadIdentify = cmp.get("v.tenantId") + cmp.get("v.flowId") + cmp.get("v.flowVersionId");

            if (cmp.get("v.lastLoadedFlow") !== flowToLoadIdentify) {
                console.log("initialize success");
                manywho.initialize();
                cmp.set("v.lastLoadedFlow", flowToLoadIdentify);
            }

            console.log("Flow already initialized");

        } else if (scriptLoaded === true  && cmp.get("v.defaultFlowLoaded") === false &&
            cmp.get("v.tenantId") === cmp.get("v.defaultTenantId") &&
            cmp.get("v.flowId") === cmp.get("v.defaultFlowId")){

            // for the default flow we don't need session so we can run it
            cmp.set("v.defaultFlowLoaded", true);
            console.log("Default Flow initialized");
            manywho.initialize();
        } else if (cmp.get("v.defaultFlowLoaded") === true) {
            console.log("Flow not initialized because the default flow have been already initialized");
        } else {
            console.log("Flow not initialized");
        }
    },

    persistUrlForSecurityCheck : function(cmp) {
        if (!$A.util.isUndefined(cmp.get("v.persistUrl")) && cmp.get("v.persistUrl")) {
            var action = cmp.get("c.saveDomains");
            action.setParams({
                communityName : cmp.get("v.validDomainName"),
                lightningOriginProd: cmp.get("v.lightningOrigin")
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
