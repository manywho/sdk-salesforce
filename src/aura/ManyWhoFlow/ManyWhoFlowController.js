({
    sendMessage : function(component, event, helper) {
        var userAction = component.get("c.getUserInfo");
        
        userAction.setCallback(this, function(response){
            var state = response.getState();
            
            if (state === "SUCCESS") {
                var userInfo = response.getReturnValue();
				var resourceUrl = $A.get('$Resource.manywho_flow');

		        var startInfo = {
		        	tenantId: v.tenantId,
		        	flowId: v.flowId,
		            sessionId: userInfo.sessionId,
		            sessionUrl: userInfo.sessionUrl,
		            resourceUrl: resourceUrl
		        };
		        
		        component.find("ManyWhoFlowApp").message(startInfo);
            }
        });

        $A.enqueueAction(userAction);
    },
    
    handleMessage: function(component, message, helper) {
        var payload = message.payload;
        var name = payload.name;
        
        if (name === "General") {
            var value = payload.value;
            component.set("v.messageReceived", value);
        } else if (name === "Foo") {
            // A different response
        }
    }
})