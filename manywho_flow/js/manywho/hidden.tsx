declare var manywho: any;
declare var sforce: any;

import * as React from 'react';

/*!
 Copyright 2015 ManyWho, Inc.
 Licensed under the ManyWho License, Version 1.0 (the "License"); you may not use this
 file except in compliance with the License.
 You may obtain a copy of the License at: http://manywho.com/sharedsource
 Unless required by applicable law or agreed to in writing, software distributed under
 the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied. See the License for the specific language governing
 permissions and limitations under the License.
 */

class Hidden extends React.Component<any, any> {

    componentDidMount() {

        const model = manywho.model.getComponent(this.props.id, this.props.flowKey);
        const state = manywho.state.getComponent(this.props.id, this.props.flowKey);

        // Determine if the tab should be active
        let active = false;
        if (model.attributes.active && manywho.utils.isEqual(model.attributes.active, 'true', true)) {
            active = true;
        }

        // Determine if the tab should have a label
        let tabLabel = null;
        if (model.attributes.tabLabel && !manywho.utils.isNullOrWhitespace(model.attributes.tabLabel)) {
            tabLabel = model.attributes.tabLabel;
        }

        // Determine if we're opening a sub-tab or primary tab
        if (model.attributes.openSubtab && manywho.utils.isEqual(model.attributes.openSubtab, 'true', true)) {

            const contentValue = state && state.contentValue != null ? state.contentValue : model.contentValue;

            if (!manywho.utils.isNullOrWhitespace(contentValue)) {

                sforce.console.getEnclosingPrimaryTabId(function(result) {
                    if (!result.success) {
                        alert('Subtab cannot be opened: ' + result.error);
                    }

                    sforce.console.openSubtab(result.id, '/' + contentValue, active, tabLabel);
                });

            }

        } else if (
            model.attributes.openPrimaryTab 
            && manywho.utils.isEqual(model.attributes.openPrimaryTab, 'true', true)
        ) {

            const contentValue = state && state.contentValue != null ? state.contentValue : model.contentValue;

            if (!manywho.utils.isNullOrWhitespace(contentValue)) {

                const openSuccess = (result) => {
                    if (!result.success) {
                        alert('Primary tab cannot be opened: ' + result.error);
                    }
                };

                sforce.console.openPrimaryTab(null, '/' + contentValue, active, tabLabel, openSuccess);

            }

        }

    }

    render() {

        manywho.log.info('Rendering Hidden: ' + this.props.id);

        return null;

    }

}

manywho.component.register('hidden', Hidden);

export default Hidden;
