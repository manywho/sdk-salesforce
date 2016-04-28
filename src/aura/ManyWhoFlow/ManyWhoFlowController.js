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
         
         // Get the Url for the page and get out the record identifier
         var pageUrl = window.location.href;
         
         // Check to see if there are any query string parameters
         if (pageUrl.indexOf("?") > 0) {
             pageUrl = pageUrl.substring(0, pageUrl.indexOf("?"));
         }
         
         // Now assume the identifier is the last entry in the url
         var identifier = pageUrl.substring(pageUrl.lastIndexOf("/") + 1);
         
         var caseAction = cmp.get("c.getStateId");
         caseAction.setParams({ id : identifier });
         caseAction.setCallback(this, function(response){
             var stateId = response.getReturnValue();
             
             if (stateId != null &&
                 stateId.trim().length > 0) {
                 cmp.set("v.stateId", stateId);
                 setTimeout(function(){ manywho.initialize(); }, 3000);
             }
         });
         
         $A.enqueueAction(caseAction);
         
     }
 })