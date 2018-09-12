!function(e){var t={};function n(o){if(t[o])return t[o].exports;var r=t[o]={i:o,l:!1,exports:{}};return e[o].call(r.exports,r,r.exports,n),r.l=!0,r.exports}n.m=e,n.c=t,n.d=function(e,t,o){n.o(e,t)||Object.defineProperty(e,t,{enumerable:!0,get:o})},n.r=function(e){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},n.t=function(e,t){if(1&t&&(e=n(e)),8&t)return e;if(4&t&&"object"==typeof e&&e&&e.__esModule)return e;var o=Object.create(null);if(n.r(o),Object.defineProperty(o,"default",{enumerable:!0,value:e}),2&t&&"string"!=typeof e)for(var r in e)n.d(o,r,function(t){return e[t]}.bind(null,r));return o},n.n=function(e){var t=e&&e.__esModule?function(){return e.default}:function(){return e};return n.d(t,"a",t),t},n.o=function(e,t){return Object.prototype.hasOwnProperty.call(e,t)},n.p="",n(n.s=2)}([function(e,t){e.exports=React},function(e,t,n){"use strict";var o=this&&this.__extends||function(){var e=Object.setPrototypeOf||{__proto__:[]}instanceof Array&&function(e,t){e.__proto__=t}||function(e,t){for(var n in t)t.hasOwnProperty(n)&&(e[n]=t[n])};return function(t,n){function o(){this.constructor=t}e(t,n),t.prototype=null===n?Object.create(n):(o.prototype=n.prototype,new o)}}();Object.defineProperty(t,"__esModule",{value:!0});var r=n(0),i=function(e){function t(t){var n=e.call(this,t)||this;return n.container=null,n.onSelect=n.onSelect.bind(n),n.onOutcome=n.onOutcome.bind(n),n.onNext=n.onNext.bind(n),n.onPrev=n.onPrev.bind(n),n.renderItem=n.renderItem.bind(n),n.onSearch=n.onSearch.bind(n),n.container=r.createRef(),n}return o(t,e),t.prototype.onSelect=function(e){this.props.select(e.currentTarget.id)},t.prototype.onOutcome=function(e){this.props.onOutcome(e.currentTarget.parentElement.parentElement.id,e.currentTarget.id)},t.prototype.onPrev=function(){var e=this;this.props.onPrev(),setTimeout(function(){return e.container.current.scrollIntoView(!0)})},t.prototype.onNext=function(){var e=this;this.props.onNext(),setTimeout(function(){return e.container.current.scrollIntoView(!0)})},t.prototype.onSearch=function(e,t){this.props.onSearch(e,t)},t.prototype.renderItem=function(e,t,n,o){if("next"===e.type)return r.createElement("div",{className:"mw-tiles-next",onClick:this.onNext},r.createElement("span",{className:"glyphicon glyphicon-arrow-right"}));if("prev"===e.type)return r.createElement("div",{className:"mw-tiles-prev",onClick:this.onPrev},r.createElement("span",{className:"glyphicon glyphicon-arrow-left"}));var i="mw-tiles-item";e.isSelected&&(i+=" bg-info");var s=e.properties.find(function(e){return e.typeElementPropertyId===t[0].typeElementPropertyId}).contentValue,l=null;o&&(l=r.createElement(manywho.component.getByName("outcome"),{id:o.id,flowKey:this.props.flowKey,onClick:this.onOutcome,size:"sm"}));var a=null;t.length>1&&(a=e.properties.find(function(e){return e.typeElementPropertyId===t[1].typeElementPropertyId}).contentValue);var c=null;return t.length>2&&(c=t.map(function(t,n){if(n>1){var o=e.properties.find(function(e){return e.typeElementPropertyId===t.typeElementPropertyId});return r.createElement("li",null,r.createElement("strong",null,o.developerName),": ",o.contentValue)}})),r.createElement("div",{className:i,onClick:this.onSelect,id:e.externalId},r.createElement("div",{className:"mw-tiles-item-header"},r.createElement("h4",{title:s},s),l),r.createElement("div",{className:"mw-tiles-item-content"},a),r.createElement("ul",{className:"mw-tiles-item-footer list-unstyled"},c),r.createElement("div",{className:"mw-tiles-item-outcomes"},n))},t.prototype.render=function(){var e=this;if(manywho.log.info("Rendering Tiles: "+this.props.id),this.props.isDesignTime)return null;var t=manywho.model.getComponent(this.props.id,this.props.flowKey),n=this.props.isDesignTime?{error:null,loading:!1}:manywho.state.getComponent(this.props.id,this.props.flowKey)||{},o=manywho.model.getOutcomes(this.props.id,this.props.flowKey),i=manywho.component.getDisplayColumns(t.columns)||[],s=manywho.styling.getClasses(this.props.parentId,this.props.id,"tiles",this.props.flowKey).join(" ");!1===t.isVisible&&(s+=" hidden");var l=null;manywho.utils.isNullOrWhitespace(t.label)||(l=r.createElement("label",null,t.label));var a=r.createElement(manywho.component.getByName("mw-items-header"),{flowKey:this.props.flowKey,isSearchable:t.isSearchable,isRefreshable:t.objectDataRequest||t.fileDataRequest,onSearch:this.onSearch,outcomes:manywho.model.getOutcomes(this.props.id,this.props.flowKey),refresh:this.props.refresh}),c=o&&o.filter(function(e){return!manywho.utils.isEqual(e.pageActionType,"Delete",!0)&&!e.isBulkAction}).map(function(t){return r.createElement(manywho.component.getByName("outcome"),{id:t.id,flowKey:e.props.flowKey,onClick:e.onOutcome,size:"default"})}),p=o&&o.filter(function(e){return manywho.utils.isEqual(e.pageActionType,"Delete",!0)&&!e.isBulkAction})[0],u=null,m=[];return this.props.objectData&&!manywho.utils.isPlaceholderObjectData(this.props.objectData)&&(m=this.props.objectData.map(function(e){return e}),this.props.page>1&&m.unshift({type:"prev"}),!0===this.props.hasMoreResults&&(m=m.concat([{type:"next"}]))),u=this.props.contentElement?this.props.contentElement:r.createElement("div",{className:"mw-tiles-items"},m.map(function(t,n){var o=e.props.page.toString()+"-"+n;return r.createElement("div",{className:"mw-tiles-item-container",key:o},r.createElement(ReactMotion.Motion,{defaultStyle:{rotate:0},style:{rotate:ReactMotion.spring(180,{stiffness:65,damping:9.5})}},function(n){var o="rotateY("+n.rotate+"deg)",s="rotateY("+(180-n.rotate)+"deg)";return r.createElement("div",null,r.createElement("div",{className:"front",style:{transform:o}}),r.createElement("div",{className:"back",style:{transform:s}},e.renderItem(t,i,c,p)))}))})),r.createElement("div",{className:s,id:this.props.id,ref:this.container},l,a,u,r.createElement(manywho.component.getByName("wait"),{isVisible:n.loading,message:n.loading&&n.loading.message},null))},t}(r.Component);manywho.component.registerItems("panels",i),t.default=i},function(e,t,n){"use strict";Object.defineProperty(t,"__esModule",{value:!0}),function(e){for(var n in e)t.hasOwnProperty(n)||(t[n]=e[n])}(n(1))}]);