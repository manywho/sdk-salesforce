var manywho = {
    cdnUrl: 'https://assets.manywho.com',
    customResources: null,
    initialize: function () {
		console.log("provide-session-info: "+$('#manywho-lightning-settings').data('provide-session-info'));
		console.log("session-token: "+$('#manywho-lightning-settings').data('session-token'));
		console.log("session-url: "+$('#manywho-lightning-settings').data('session-url'));
		
        var queryParameters = manywho.utils.parseQueryString(window.location.search.substring(1));
		
        manywho.settings.initialize({
            adminTenantId: 'da497693-4d02-45db-bc08-8ea16d2ccbdf',
            playerUrl: [ location.protocol, '//', location.host, location.pathname ].join(''),
            joinUrl: [ location.protocol, '//', location.host, location.pathname ].join(''),
            platform: {
                uri: 'https://flow.manywho.com'
            }
        });

        // Pass input values into the page if they have been provided
        var inputValues = null;
        
        if ($('#manywho-lightning-settings').data('object-id') != null &&
            $('#manywho-lightning-settings').data('object-id').trim().length > 0) {
            inputValues = [];
            inputValues.push({
                'developerName': 'SalesforceNotificationRecordId',
                'contentType': 'ContentString',
                'contentValue': $('#manywho-lightning-settings').data('object-id'),
            });
        }
        
        if ($('#manywho-lightning-settings').data('object-name') != null &&
            $('#manywho-lightning-settings').data('object-name').trim().length > 0) {
            if (inputValues == null) {
                inputValues = [];
            }
            inputValues.push({
                'developerName': 'SalesforceNotificationObjectName',
                'contentType': 'ContentString',
                'contentValue': $('#manywho-lightning-settings').data('object-name'),
            });
        }
        
        var salesforceSessionId = null;
        var salesforceSessionUrl = null;
        
        // Only send the session information if configured to do so
		//console.log($('#manywho-lightning-settings').data('provide-session-info'));
        
		//if (manywho.utils.isEqual('true', $('#manywho-lightning-settings').data('provide-session-info').toString(), true)) {
        	salesforceSessionId = $('#manywho-lightning-settings').data('session-token');
        	salesforceSessionUrl = $('#manywho-lightning-settings').data('session-url');
        //}
        
        var options = {
            authentication: {
                sessionId: salesforceSessionId,
                sessionUrl: salesforceSessionUrl
            },
            navigationElementId: $('#manywho-lightning-settings').data('navigation-element-id'),
            mode: $('#manywho-lightning-settings').data('mode'),
            reportingMode: $('#manywho-lightning-settings').data('reporting-mode'),
            replaceUrl: false,
            collaboration: {
                isEnabled: manywho.utils.isEqual('true', $('#manywho-lightning-settings').data('collaboration-is-enabled'), true)
            },
            inputs: inputValues,
            annotations: null,
            navigation: {
                isFixed: manywho.utils.isEqual('true', $('#manywho-lightning-settings').data('navigation-is-fixed'), true),
                isWizard: manywho.utils.isEqual('true', $('#manywho-lightning-settings').data('navigation-is-wizard'), true)
            },
            callbacks: [],
            collapsible: manywho.utils.isEqual('true', $('#manywho-lightning-settings').data('collapsible'), true)
        };

		console.log("tenant-id" + $('#manywho-lightning-settings').data('tenant-id'));
		console.log("tenant-id" + $('#manywho-lightning-settings').data('flow-id'));
		console.log("tenant-id" + $('#manywho-lightning-settings').data('flow-version-id'));
        
		manywho.engine.initialize(
            $('#manywho-lightning-settings').data('tenant-id'),
            $('#manywho-lightning-settings').data('flow-id'),
            $('#manywho-lightning-settings').data('flow-version-id'),
            'main',
            $('#manywho-lightning-settings').data('join'),
            queryParameters['authorization'],
            options,
            queryParameters['initialization']
        );

    }
};