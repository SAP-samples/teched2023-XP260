# Exercise 7 - Add Test Cases

In this exercise we will learn
- How to add dependencies
- How to add tests
- How to test the application

## Add dependencies

1. In SAP Business Application Studio, go to your **IncidentManagement** dev space.

    > Make sure the **IncidentManagement** dev space is in status **RUNNING**.

2. From the root of the **INCIDENT-MANAGEMENT-xxx** project, choose the burger menu, and then choose **Terminal** &rarr; **New Terminal**.

3. To add the required dependencies, run the following command:

    ```bash
    npm add -D axios chai chai-as-promised chai-subset jest
    ```

## Add tests

1. Create a folder at the root of the **INCIDENT-MANAGEMENT-xxx** project and name it **tests**.

2. In the **tests** folder, create the **test.js** file.

3. Add the following code to the **test.js** file:

    ```javascript
    const cds = require("@sap/cds/lib");
    const { default: axios } = require("axios");
    const { GET, POST, DELETE, PATCH, expect } = cds.test(__dirname + "../../");

    axios.defaults.auth = {
      username: "incident.support@tester.sap.com",
      password: "initial",
    };

    jest.setTimeout(11111);

    describe("Test the GET Endpoints", () => {
      it("Should check Processor service", async () => {
        const ProcessorService = await cds.connect.to("ProcessorService");
        const { Incidents } = ProcessorService.entities;
        expect(await SELECT.from(Incidents)).to.have.length(4);
      });

      it("Should check Customers", async () => {
        const ProcessorService = await cds.connect.to("ProcessorService");
        const { Customers } = ProcessorService.entities;
        expect(await SELECT.from(Customers)).to.have.length(3);
      });

      it("Test Expand Entity Endpoint", async () => {
        const { data } =
          await GET`/odata/v4/processor/Customers?$select=firstName&$expand=incidents`;
        expect(data).to.be.an("object");
      });
    });

    describe("Draft Choreography APIs", () => {
      let draftId, incidentId;

      it("Create an incident ", async () => {
        const { status, statusText, data } = await POST(
          `/odata/v4/processor/Incidents`,
          {
            title: "Urgent attention required!",
            status_code: "N",
          }
        );
        draftId = data.ID;
        expect(status).to.equal(201);
        expect(statusText).to.equal("Created");
      });

      it("+ Activate the draft and check the Urgency code as H using custom logic", async () => {
        const response = await POST(
          `/odata/v4/processor/Incidents(ID=${draftId},IsActiveEntity=false)/ProcessorService.draftActivate`
        );
        expect(response.status).to.eql(201);
        expect(response.data.urgency_code).to.eql("H");
      });

      it("+ Test the incident status", async () => {
        const {
          status,
          data: { status_code, ID },
        } = await GET(
          `/odata/v4/processor/Incidents(ID=${draftId},IsActiveEntity=true)`
        );
        incidentId = ID;
        expect(status).to.eql(200);
        expect(status_code).to.eql("N");
      });

      describe("Close the incident and open it again to check the custom logic", () => {
        it(`Should close the incident-${draftId}`, async () => {
          const { status } = await POST(
            `/odata/v4/processor/Incidents(ID=${incidentId},IsActiveEntity=true)/ProcessorService.draftEdit`,
            {
              PreserveChanges: true,
            }
          );
          expect(status).to.equal(201);
        });

        it(`Should close the incident-${draftId}`, async () => {
          const { status } = await PATCH(
            `/odata/v4/processor/Incidents(ID=${incidentId},IsActiveEntity=false)`,
            { status_code: "C" }
          );
          expect(status).to.equal(200);
        });
        it("+ Activate the draft and check Status code as C using custom logic", async () => {
          const response = await POST(
            `/odata/v4/processor/Incidents(ID=${incidentId},IsActiveEntity=false)/ProcessorService.draftActivate`
          );
          expect(response.status).to.eql(200);
        });

        it("+ Test the incident status to be closed", async () => {
          const {
            status,
            data: { status_code },
          } = await GET(
            `/odata/v4/processor/Incidents(ID=${incidentId},IsActiveEntity=true)`
          );
          expect(status).to.eql(200);
          expect(status_code).to.eql("C");
        });
        describe("Should fail to reopen closed incident", () => {
          it(`Should open closed incident-${draftId}`, async () => {
            const { status } = await POST(
              `/odata/v4/processor/Incidents(ID=${incidentId},IsActiveEntity=true)/ProcessorService.draftEdit`,
              {
                PreserveChanges: true,
              }
            );
            expect(status).to.equal(201);
          });

          it(`Should reopen the incident-${draftId} but fail`, async () => {
            const { status } = await PATCH(
              `/odata/v4/processor/Incidents(ID=${incidentId},IsActiveEntity=false)`,
              { status_code: "N" }
            );
            expect(status).to.equal(200);
          });
          it("Should fail to activate draft trying to reopen the incident", async () => {
            try {
              const response = await POST(
                `/odata/v4/processor/Incidents(ID=${incidentId},IsActiveEntity=false)/ProcessorService.draftActivate`
              );
            } catch (error) {
              expect(error.response.status).to.eql(500);
              expect(error.response.data.error.message).to.include(
                `Can't modify a closed incident`
              );
            }
          });
        });
      });

      it("- Delete the incident", async () => {
        const response = await DELETE(
          `/odata/v4/processor/Incidents(ID=${draftId},IsActiveEntity=true)`
        );
        expect(response.status).to.eql(204);
      });
    });

    ```

    > With this code, you have added test cases in the application.

## Test the application

1. Open the **package.json** file and add the following line inside the **scripts** section. This adds a command to start the tests.

    ```json[15]
    {
      "name": "incident-management-xxx",
      "version": "1.0.0",
      "description": "A simple CAP project.",
      "repository": "<Add your repository here>",
      "license": "UNLICENSED",
      "private": true,
      "dependencies": {
          ...
      },
      "devDependencies": {
          ...
      },
      "scripts": {
          "test": "jest tests/test.js",
          "start": "cds-serve",
          "watch-incidents": "cds watch --open incidents/webapp/index.html?sap-ui-xx-viewCache=false"
      },
      "cds": {
          ...
        }
      },
      ...
    }
    ```

2. To test the application, run the following command in the terminal:

    ```bash
    npm run test
    ```

3. When all the test cases pass, the output should look like this:

    ```bash
    PASS  tests/test.js
    Test The GET Endpoints
      ✓ Should check Processor Service (8 ms)
      ✓ Should check Customers (2 ms)
      ✓ Test Expand Entity Endpoint (55 ms)
    Draft Choreography APIs
      ✓ Create an incident  (31 ms)
      ✓ + Activate the draft & check Urgency code as H using custom logic (28 ms)
      ✓ + Test the incident status (16 ms)
      ✓ - Delete the incident (12 ms)
      Close incident and open it again to check Custom logic
        ✓ Should Close the incident-undefined (16 ms)
        ✓ Should Close the incident-undefined (13 ms)
        ✓ + Activate the draft & check Status code as C using custom logic (18 ms)
        ✓ + Test the incident status to be closed (9 ms)
        should fail to reopen closed incident
          ✓ Should open closed incident-undefined (14 ms)
          ✓ Should reopen the incident-undefined but fail (10 ms)
          ✓ Should fail to activate draft trying to reopen the incident (21 ms)

        Test Suites: 1 passed, 1 total
        Tests:       14 passed, 14 total
        Snapshots:   0 total
        Time:        2.028 s, estimated 7 s
        Ran all test suites.
    ```
   
    > For a more detailed guide, see [Testing](https://cap.cloud.sap/docs/node.js/cds-test) in the CAP Node.js SDK documentation.

