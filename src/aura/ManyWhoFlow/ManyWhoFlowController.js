({
    doInit: function(cmp) {
        
        var userAction = cmp.get("c.getUserInfo");
        userAction.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                cmp.set("v.userInfo", response.getReturnValue());
            }
        });
        
        $A.enqueueAction(userAction);
        
     },
    
     afterScriptsLoaded : function(cmp, event, helper) {

        // Initialize the flow as expected
		manywho.initialize();

     }
 })