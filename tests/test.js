const cds = require("@sap/cds/lib");
    const { default: axios } = require("axios");
    const { GET, POST, DELETE, PATCH, expect } = cds.test(__dirname + '../../','--with-mocks');

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