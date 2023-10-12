sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'ns046.incidents046',
            componentId: 'IncidentsObjectPage',
            entitySet: 'Incidents'
        },
        CustomPageDefinitions
    );
});