sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'ns046.incidents046',
            componentId: 'IncidentsList',
            entitySet: 'Incidents'
        },
        CustomPageDefinitions
    );
});