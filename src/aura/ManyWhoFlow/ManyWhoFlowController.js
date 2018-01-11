({
    doInit: function(cmp, event, helper) {

        var visualforceOriginPreview = "https://" + cmp.get("v.visualforceHostPreview");
        var visualforceOriginProd = "https://" + cmp.get("v.visualforceHostProd");
        var lightningOriginPreview = "https://" + cmp.get("v.lightningOriginPreview");

        window.addEventListener("message", function(event) {
            try {

                console.log("event origin:" + event.origin);
                if (event.origin !== visualforceOriginPreview  && event.origin !== visualforceOriginProd && event.origin !== lightningOriginPreview) {
                    console.log("origin not acepted("+ event.origin + ") because is not *" + visualforceOriginPreview + "* or *"+ visualforceOriginProd+"* or *" + lightningOriginPreview + "*");

                    return;
                }

                var sessionData = JSON.parse(event.data);
                cmp.set("v.sessionId", sessionData.sessionId);
                cmp.set("v.sessionUrl", sessionData.sessionUrl);
                cmp.set("v.sessionLoaded", true);

                helper.persistUrlForSecurityCheck(cmp);
                console.log("eventlistener");
                helper.initializeFlowIfReady(cmp);
            } catch(error) {
                return;
            }
        }, false);
    },

    afterScriptsLoaded : function(cmp, event, helper) {
        cmp.set("v.scriptLoaded", true);
        console.log("scriptloaded");
        helper.persistUrlForSecurityCheck(cmp);
        helper.initializeFlowIfReady(cmp);
    }
})