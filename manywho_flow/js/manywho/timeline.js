function getClassForElement(elementType) {
    if (elementType != null) {
        elementType = elementType.toLowerCase();

        if (elementType == 'input') {
            return 'page-element';
        } else if (elementType == 'database_save') {
            return 'database-save-element';
        } else if (elementType == 'database_load') {
            return 'database-load-element';
        } else if (elementType == 'start') {
            return 'start-element';
        } else if (elementType == 'decision') {
            return 'decision-element';
        } else if (elementType == 'operator') {
            return 'operator-element';
        } else if (elementType == 'message') {
            return 'message-element';
        } else if (elementType == 'step') {
            return 'step-element';
        }
    }

    return null;
}


function getGlyphiconForElement(elementType) {
    if (elementType != null) {
        elementType = elementType.toLowerCase();

        if (elementType == 'input') {
            return 'glyphicon glyphicon-th';
        } else if (elementType == 'database_save') {
            return 'glyphicon glyphicon-download';
        } else if (elementType == 'database_load') {
            return 'glyphicon glyphicon-upload';
        } else if (elementType == 'start') {
            return 'glyphicon glyphicon-star';
        } else if (elementType == 'decision') {
            return 'glyphicon glyphicon-ok-circle';
        } else if (elementType == 'operator') {
            return 'glyphicon glyphicon-cog';
        } else if (elementType == 'message') {
            return 'glyphicon glyphicon glyphicon-time';
        } else if (elementType == 'step') {
            return 'glyphicon glyphicon-map-marker';
        }
    }

    return null;
}

function getStringAttribute(attributes, name) {

    if (attributes != null &&
        attributes[name] != null) {
        return attributes[name];
    }

    return null;

}

function getNumberAttribute(attributes, name) {

    if (getStringAttribute(attributes, name) != null) {

        return parseInt(getStringAttribute(attributes, name));

    }

    return 0;

}

function grabStateId() {
    var stateId = null;

    if ('{!stateId}'.trim().length > 0) {
        stateId = '{!stateId}';
    }

    return stateId;
}

function findMapElement(mapElementId) {

    if (flow != null &&
        flow.mapElements != null &&
        flow.mapElements.length > 0) {

        for (var i = 0; i < flow.mapElements.length; i++) {

            if (flow.mapElements[i].id == mapElementId) {

                return flow.mapElements[i];

            }

        }

    }

    return null;

}

function updateTimeline(stateId) {
    ManyWhoFlowController.sayHello(stateId, function(result, event) {
        if(event.status) {
            moment.locale('en');

            var replaceQuote = '&' + 'quot;';
            var state = null;

            if (result != null) {
                result = result.split(replaceQuote).join('"');
                state = JSON.parse(result);
            }

            var html = '';
            var isRight = true;
            var className = null;

            if (state != null && state.precommitStateEntry != null) {

                if (state.precommitStateEntry != null) {
                    var currentMapElement = findMapElement(state.precommitStateEntry.mapElementId);

                    html += '<div class="panel panel-default">';
                    html +=   '<div class="panel-body">';
                    html +=     '<h2>Current: ' + currentMapElement.developerName + '</h2>';
                    html +=     '<p><small class="text-muted"><span class="glyphicon glyphicon-dashboard" aria-hidden="true"></span> ' + moment(state.dateModified).format('Do MMM YYYY, h:mm:ss a') + '</small></p>';
                    html +=   '</div>';
                    html += '</div>';
                }

            }

            if (state != null &&
                state.stateEntries != null &&
                state.stateEntries.length > 0) {
                html += '<ul class="timeline">';

                for (var i = (state.stateEntries.length -1); i >= 0; i--) {
                    if (isRight) {
                        className = '';
                        isRight = false;
                    } else {
                        className = 'timeline-inverted';
                        isRight = true;
                    }

                    var mapElement = findMapElement(state.stateEntries[i].mapElementId);

                    if (mapElement != null) {
                        html += '<li class="' + className + '">';
                        html +=   '<div class="timeline-badge ' + getClassForElement(mapElement.elementType) + '"><i class="' + getGlyphiconForElement(mapElement.elementType) + '"></i></div>';
                        html +=   '<div class="timeline-panel">';
                        html +=     '<div class="timeline-heading">';
                        html +=       '<h4 class="timeline-title">' + mapElement.developerName + '</h4>';
                        html +=       '<p><small class="text-muted"><span class="glyphicon glyphicon-dashboard" aria-hidden="true"></span> ' + moment(state.stateEntries[i].dateCommitted).format('Do MMM YYYY, h:mm:ss a') + '</small></p>';
                        html +=     '</div>';
                        html +=   '</div>';
                        html += '</li>';
                    }
                }

                html += '</ul>';
            }

            $('#timeline').html(html);
        }
    });
}