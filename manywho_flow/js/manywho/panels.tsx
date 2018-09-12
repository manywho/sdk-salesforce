declare var manywho: any;
declare var ReactMotion: any;

import * as React from 'react';

class Panels extends React.Component<any, any> {

    container = null;

    constructor(props) {
        super(props);

        this.onSelect = this.onSelect.bind(this);
        this.onOutcome = this.onOutcome.bind(this);
        this.onNext = this.onNext.bind(this);
        this.onPrev = this.onPrev.bind(this);
        this.renderItem = this.renderItem.bind(this);
        this.onSearch = this.onSearch.bind(this);

        this.container = React.createRef();
    }

    onSelect(e) {
        this.props.select(e.currentTarget.id);
    }

    onOutcome(e) {
        this.props.onOutcome(e.currentTarget.parentElement.parentElement.id, e.currentTarget.id);
    }

    onPrev() {
        this.props.onPrev();
        setTimeout(() => (this.container.current as HTMLElement).scrollIntoView(true));
    }

    onNext() {
        this.props.onNext();
        setTimeout(() => (this.container.current as HTMLElement).scrollIntoView(true));
    }

    onSearch(search: string, clearSelection: boolean) {
        this.props.onSearch(search, clearSelection);
    }

    renderItem(item: any, columns: any[], outcomes: any[], deleteOutcome: any): JSX.Element {
        if (item.type === 'next') {
            return (
                <div className="mw-tiles-next" onClick={this.onNext}>
                    <span className="glyphicon glyphicon-arrow-right"/>
                </div>
            );
        }

        if (item.type === 'prev') {
            return (
                <div className="mw-tiles-prev" onClick={this.onPrev}>
                    <span className="glyphicon glyphicon-arrow-left"/>
                </div>
            );
        }

        let className = 'mw-tiles-item';
        if (item.isSelected) {
            className += ' bg-info';
        }

        const header: string = item.properties.find(
            (property) => property.typeElementPropertyId === columns[0].typeElementPropertyId,
        ).contentValue;

        let deleteOutcomeElement = null;
        if (deleteOutcome) {
            deleteOutcomeElement = React.createElement(
                manywho.component.getByName('outcome'), 
                { id: deleteOutcome.id, flowKey: this.props.flowKey, onClick: this.onOutcome, size: 'sm' },
            );
        }

        let content: string = null;
        if (columns.length > 1) {
            content = item.properties.find(
                (property) => property.typeElementPropertyId === columns[1].typeElementPropertyId,
            ).contentValue;
        }

        let footer = null;
        if (columns.length > 2) {
            footer = columns.map((column, index) => {
                if (index > 1) {
                    const property = item.properties.find(
                        (propertyToCheck) => propertyToCheck.typeElementPropertyId === column.typeElementPropertyId,
                    );
                    return <li><strong>{property.developerName}</strong>: {property.contentValue}</li>;
                }
            });
        }

        return (
            <div className={className} onClick={this.onSelect} id={item.externalId}>
                <div className="mw-tiles-item-header">
                    <h4 title={header}>{header}</h4>
                    {deleteOutcomeElement}
                </div>
                <div className="mw-tiles-item-content">{content}</div>
                <ul className="mw-tiles-item-footer list-unstyled">{footer}</ul>
                <div className="mw-tiles-item-outcomes">{outcomes}</div>
            </div>
        );
    }

    render() {
        manywho.log.info('Rendering Tiles: ' + this.props.id);

        if (this.props.isDesignTime) {
            return null;
        }

        const model = manywho.model.getComponent(this.props.id, this.props.flowKey);
        const state = this.props.isDesignTime 
            ? { error: null, loading: false } 
            : manywho.state.getComponent(this.props.id, this.props.flowKey) || {};
        const outcomes = manywho.model.getOutcomes(this.props.id, this.props.flowKey);
        const columns = manywho.component.getDisplayColumns(model.columns) || [];

        let className = manywho.styling.getClasses(
            this.props.parentId, 
            this.props.id, 
            'tiles', 
            this.props.flowKey,
        ).join(' ');

        if (model.isVisible === false) {
            className += ' hidden';
        }

        let labelElement = null;
        if (!manywho.utils.isNullOrWhitespace(model.label)) {
            labelElement = <label>{model.label}</label>;
        }

        const headerElement = React.createElement(manywho.component.getByName('mw-items-header'), {
            flowKey: this.props.flowKey,
            isSearchable: model.isSearchable,
            isRefreshable: (model.objectDataRequest || model.fileDataRequest),
            onSearch: this.onSearch,
            outcomes: manywho.model.getOutcomes(this.props.id, this.props.flowKey),
            refresh: this.props.refresh,
        });

        const footerOutcomes = outcomes && outcomes
                .filter(
                    (outcome) => !manywho.utils.isEqual(outcome.pageActionType, 'Delete', true) 
                        && !outcome.isBulkAction,
                )
                .map(
                    (outcome) => React.createElement(
                        manywho.component.getByName('outcome'), 
                        { id: outcome.id, flowKey: this.props.flowKey, onClick: this.onOutcome, size: 'default' },
                    ),
                );

        const deleteOutcome = outcomes && outcomes
            .filter(
                (outcome) => manywho.utils.isEqual(outcome.pageActionType, 'Delete', true) && !outcome.isBulkAction,
            )[0];

        let contentElement = null;
        let items = [];

        if (this.props.objectData && !manywho.utils.isPlaceholderObjectData(this.props.objectData)) {
            items = this.props.objectData.map((item) => item);

            if (this.props.page > 1) {
                items.unshift({ type: 'prev' });
            }

            if (this.props.hasMoreResults === true) {
                items = items.concat([{ type: 'next' }]);
            }
        }

        if (this.props.contentElement) {
            contentElement = this.props.contentElement;
        } else {
            contentElement = (
                <div className="mw-tiles-items">
                    {
                        items.map((item, index) => {
                            const key: string = `${this.props.page.toString()}-${index}`;

                            return (
                                <div className="mw-tiles-item-container" key={key}>
                                    <ReactMotion.Motion 
                                        defaultStyle={{ rotate: 0}} 
                                        style={{ 
                                            rotate: ReactMotion.spring(180, { stiffness: 65, damping: 9.5 }),
                                        }}
                                    >
                                        {
                                            (interpolatingStyle) => {
                                                const frontTransform = `rotateY(${interpolatingStyle.rotate}deg)`;
                                                const backTransform = `rotateY(${180 - interpolatingStyle.rotate}deg)`;

                                                return (
                                                    <div>
                                                        <div className="front" style={{ transform: frontTransform }} />
                                                        <div className="back" style={{ transform: backTransform }}>
                                                            {
                                                                this.renderItem(
                                                                    item, 
                                                                    columns, 
                                                                    footerOutcomes,
                                                                    deleteOutcome,
                                                                )
                                                            }
                                                        </div>
                                                    </div>
                                                );
                                            }
                                        }
                                    </ReactMotion.Motion>
                                </div>
                            );
                        })
                    }
                </div>
            );
        }

        return (
            <div className={className} id={this.props.id} ref={this.container}>
                {labelElement}
                {headerElement}
                {contentElement}
                {
                    React.createElement(
                        manywho.component.getByName('wait'), 
                        { isVisible: state.loading, message: state.loading && state.loading.message }, 
                        null,
                    )
                }
            </div>
        );
    }

}

manywho.component.registerItems('panels', Panels);

export default Panels;
