var manywho = {
    cdnUrl: 'https://assets.manywho.com',
    customResources: null,
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
            navigationElementId: queryParameters['navigation-element-id'],
            mode: $('#manywho-lightning-settings').data('mode'),
            reportingMode: $('#manywho-lightning-settings').data('reporting-mode'),
            replaceUrl: false,
            collaboration: {
                isEnabled: true
            },
            inputs: null,
            annotations: null,
            navigation: {
                isFixed: false,
                isWizard: false
            },
            callbacks: [],
            collapsible: false
        };

        manywho.engine.initialize(
            $('#manywho-lightning-settings').data('tenant-id'),
            $('#manywho-lightning-settings').data('flow-id'),
            queryParameters['flow-version-id'],
            'main',
            queryParameters['join'],
            queryParameters['authorization'],
            options,
            queryParameters['initialization']
        );

    }
};