var manywho = {
    cdnUrl: '',
    initialize: function () {

        var queryParameters = manywho.utils.parseQueryString(window.location.search.substring(1));
			
        manywho.settings.initialize({
            adminTenantId: 'da497693-4d02-45db-bc08-8ea16d2ccbdf',
            playerUrl: [ location.protocol, '//', location.host, location.pathname ].join(''),
            joinUrl: [ location.protocol, '//', location.host, location.pathname ].join(''),
            platform: {
                uri: 'https://flow.manywho.com'
            }
        });

        var options = {
            authentication: {
                sessionId: $('#manywho-lightning-settings').data('session-token'),
                sessionUrl: $('#manywho-lightning-settings').data('session-url')
            },
            navigationElementId: $('#manywho-lightning-settings').data('navigation-element-id'),
            mode: $('#manywho-lightning-settings').data('mode'),
            reportingMode: $('#manywho-lightning-settings').data('reporting-mode'),
            trackLocation: false,
            replaceUrl: false,
            collaboration: {
                isEnabled: false
            },
            autoFocusInput: true,
            inputs: null,
            annotations: null,
            navigation: {
                isFixed: false,
                isWizard: false
            },
            callbacks: [],
            collapsible: true,
            history: queryParameters['history'],
            theme: queryParameters['theme'],
            outcomes: 'icons'
        };

        manywho.log.enableAll();
        
        alert(queryParameters['join']);
                
        manywho.engine.initialize(
            '14cef424-ee8c-43ce-a21b-8e4a2f7de36b',
            '4a3980b0-81ba-473f-8bf6-14c54a3cb98d',
            null,
            'main',
            queryParameters['join'],
            queryParameters['authorization'],
            options,
            queryParameters['initialization']
        );

    }
};