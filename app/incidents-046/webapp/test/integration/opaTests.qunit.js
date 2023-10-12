sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns046/incidents046/test/integration/FirstJourney',
		'ns046/incidents046/test/integration/pages/IncidentsList',
		'ns046/incidents046/test/integration/pages/IncidentsObjectPage'
    ],
    function(JourneyRunner, opaJourney, IncidentsList, IncidentsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns046/incidents046') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheIncidentsList: IncidentsList,
					onTheIncidentsObjectPage: IncidentsObjectPage
                }
            },
            opaJourney.run
        );
    }
);