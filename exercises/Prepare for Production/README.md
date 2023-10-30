# Exercise 8 - Prepare for Production

In this exercise we will learn
- How to configure SAP HANA Cloud in your project
- How to configure SAP Authorization and Trust Management service in your project

## Add SAP HANA Cloud

1. In SAP Business Application Studio, go to your **IncidentManagement** dev space.

    > Make sure the **IncidentManagement** dev space is in status **RUNNING**.

2. From the root of the **INCIDENT-MANAGEMENT-xxx** project, choose the burger menu, and then choose **Terminal** &rarr; **New Terminal**.

3. To add an SAP HANA Cloud client to your application, run the following command:

    ```bash
    cds add hana --for production
    ```

    > The **cds add hana** command adds the **@sap/cds-hana** module that allows SAP HANA Cloud to access the **package.json** file and the database configuration **"kind": "hana"** that uses SAP HANA Cloud when the application is started on production.
    >
    > The **cds add hana** command adds to the **package.json** file the highlighted lines and run **npm i** command just to make sure all new packages have been downloaded:

    ```json[5, 11-15]
    {
        "name": "incident-management-xxx",
        "dependencies": {
            ...
            "@sap/cds-hana": "^x"
        },
        ...
        "cds": {
            "requires": {
                ...
                "[production]": {
                    "db": {
                        "kind": "hana"
                    }
                }
            }
        }
    }
    ```
    
    > To learn more, see: 
    >
    > - [Using Databases](https://cap.cloud.sap/docs/guides/databases#get-hana)
    > - [CAP Configuration](https://cap.cloud.sap/docs/node.js/cds-env)
    >
    > By default, these are the available profiles: 
    >
    > - For local testing: **development**
    > - For hybrid testing: **hybrid**
    > - For productive testing: **production** 
    >
    > Deployments are done using the **production** profile automatically. You can inspect the effective production configuration with the **cds env** command:
    > 
    > ```bash
    > cds env requires -4 production
    > ```
    >
    > The output of this command looks like this:
    >
    > ```js
    > {
    >   middlewares: true,
    >   db: { impl: '@sap/cds/libx/_runtime/hana/Service.js', kind: 'hana' },
    >   auth: { strategy: 'JWT', kind: 'jwt-auth', vcap: { label: 'xsuaa' } }
    > }
    > ```

2. Verify that your application still works locally. If you closed it, choose the **Preview Application** option in the **Application Info - incidents-xxx** tab and select the **watch-incidents** npm script.

    > To open the **Application Info - incidents-xxx** tab: 
    >
    >1. Invoke the Command Palette - **View** &rarr; **Command Palette** or <kbd>Command</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> for macOS / <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> for Windows. 
    >2. Choose **Fiori: Open Application Info**.


### Configure the SAP Authorization and Trust Management service

1. Run the following command in the terminal:

    ```bash
    cds add xsuaa --for production
    ```

    > Running **cds add xsuaa** does two things:
    >
    >- Adds the SAP Authorization and Trust Management service to the **package.json** file of the **INCIDENT-MANAGEMENT-xxx** project.
    >- Creates the SAP Authorization and Trust Management service security configuration (that is, the **xs-security.json** file) for the **INCIDENT-MANAGEMENT-xxx** project.

2. Check if the following line has been added to the **package.json** file and run **npm i** command just to make sure all new packages have been downloaded:
    
    ```json[5-6, 14]
    {
      "name": "incident-management-xxx",
      "dependencies": {
          ...
          "@sap/xssec": "^x",
          "passport": "^x"
      },
      ...
      "cds": {
        "requires": {
          ...
          "[production]": {
            "db": "hana",
            "auth": "xsuaa"
          }
        }
      }
    }
    ```

3. Check the content of the **xs-security.json** file.

    You have already added authorization with the **requires** annotations in the CDS service model (that is the **processor-service.cds** file in the **srv** folder).

    ```js
    annotate ProcessorService with @(requires: ['support']);
    ```
    
    This is now translated into scopes and role templates for the SAP Authorization and Trust Management service. Hence, a scope and role template for the **support** role are created in the **xs-security.json** file:

    ```json
    {
      "scopes": [
        {
          "name": "$XSAPPNAME.support",
          "description": "support"
        }
      ],
      "attributes": [],
      "role-templates": [
        {
          "name": "support",
          "description": "generated",
          "scope-references": [
            "$XSAPPNAME.support"
          ],
          "attribute-references": []
        }
      ]
    }
    ```

You can learn more about authorization in CAP in [Authorization and Access Control](https://cap.cloud.sap/docs/guides/authorization).

### Run a test build

To validate everything is prepared as expected, run a test build with the following command:

```bash
cds build --production
```
You should get an output like:

```bash
[cds] - build completed in 511 ms
```