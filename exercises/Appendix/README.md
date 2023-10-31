## Steps to follow for Cloud Foundry Deployment

This documentation is to be followed when trying to deploy your application on Cloud Foundry through VSCode. Ensure that you have followed all the steps upto **Set Up the MTA for deployment**. You can now proceed to configuring the **Managed Approuter**.

<br>

```
NOTE: 

After adding the UI and when trying to Preview the Application you may receive a warning message on the terminal. 

To fix this, open app/incidents/webapp/manifest.json and in dataSources.mainServices.uri add /odata/v4 as shown below.

    "dataSources": {
        "mainService": {
        "uri": "/odata/v4/processor/",
            . . .
        }
    }
```

<br>


1. After creating the mta.yaml file, you need to configure the Managed Approuter. Paste the following content under the Modules section of the `mta.yaml` file. 

    ```yaml
    modules: 
    ... 

    - name: incident-management-<xxx>-destination-content
      type: com.sap.application.content
      requires:
       - name: incident-management-<xxx>-destination-service
         parameters:
           content-target: true
       - name: incident-management-<xxx>_html_repo_host
         parameters:
           service-key:
             name: incident-management-<xxx>_html_repo_host-key
       - name: incident-management-<xxx>-auth
         parameters:
           service-key:
             name: incident-management-<xxx>-auth-key
       parameters:
         content:
           instance:
             destinations:
             - Name: incidents_<xxx>_incident_management_<xxx>_html_repo_host
               ServiceInstanceName: incident-management-<xxx>-html5-app-host-service
               ServiceKeyName: incident-management-<xxx>_html_repo_host-key
               sap.cloud.service: incidents-<xxx>
             - Authentication: OAuth2UserTokenExchange
               Name: incidents_<xxx>_incident_management_<xxx>_auth
               ServiceInstanceName: incident-management-<xxx>-auth
               ServiceKeyName: incident-management-<xxx>-auth-key
               sap.cloud.service: incidents-<xxx>
             existing_destinations_policy: ignore
       build-parameters:
         no-source: true 
    ```

    Also add the below to the resources section. 

    ```yaml
    resources: 
    ... 

      - name: incident-management-<xxx>-destination-service 
        type: org.cloudfoundry.managed-service 
        parameters: 
          config: 
            HTML5Runtime_enabled: true 
            version: 1.0.0 
          service: destination 
          service-name: incident-management-<xxx>-destination-service 
          service-plan: lite 
      - name: incident-management-<xxx>_html_repo_host 
        type: org.cloudfoundry.managed-service 
        parameters: 
          service: html5-apps-repo 
          service-name: incident-management-<xxx>-html5-app-host-service 
          service-plan: app-host 
    ```

    Replace all &lt;xxx&gt; with your teched user number. 
 

2. The next step would be to add navigation targets for the UI. 

	Open the `app/incidents-<xxx>/webapp/manifest.json` and add the `crossNavigation` object inside the `sap.app` object below `dataSources`.
    ```json
    {
        "_version": "1.58.0",
        "sap.app": {
            . . . 
            "dataSources": {. . . },
            "crossNavigation": { 
              "inbounds": {
                "incidents-<xxx>-display": {
                  "semanticObject": "incidents-<xxx>",
                  "action": "display",
                  "title": "{{flpTitle}}",
                  "signature": {
                    "parameters": {},
                    "additionalParameters": "allowed"
                  }
                }
              }
            }
            . . .
        }
    }

    ```
    Again replace &lt;xxx&gt; with your teched user number.
 

    Open `app/incidents-<xxx>/webapp/i18n/i18n.properties` and add the following: 
    ```
    flpTitle=Incident Management 
    ```

3. In this step you need to add the UI as part of the deployment. Open the `mta.yaml` in the root folder and add the following to the modules section: 

    ```yaml
    modules:
    . . .
    - name: incident-management-<xxx>-app-content
      type: com.sap.application.content
      path: .
      requires:
      - name: incident-management-<xxx>_html_repo_host
        parameters:
          content-target: true
      build-parameters:
        build-result: resources
        requires:
        - artifacts:
          - ns<xxx>incidents<xxx>.zip
          name: ns<xxx>incidents<xxx>
          target-path: resources/
    - name: ns<xxx>incidents<xxx>
      type: html5
      path: app/incidents-<xxx>
      build-parameters:
        build-result: dist
        builder: custom
        commands:
        - npm install
        - npm run build:cf
        supported-platforms: []
    ```

    You now need to configure the destinations. Add the following code to resource `incident-management-destination-service` 

    ```yaml
      - name: incident-management-<xxx>-destination-service
        type: org.cloudfoundry.managed-service
        parameters:
          config:
            HTML5Runtime_enabled: true
            init_data:              
              instance:
                destinations:
                - Authentication: NoAuthentication
                  Name: ui5
                  ProxyType: Internet
                  Type: HTTP
                  URL: https://ui5.sap.com
                - Authentication: NoAuthentication
                  HTML5.DynamicDestination: true
                  HTML5.ForwardAuthToken: true
                  Name: incident-management-<xxx>-srv-api
                  ProxyType: Internet
                  Type: HTTP
                  URL: ~{srv-api/srv-url}
                existing_destinations_policy: update
            version: 1.0.0
          service: destination
          service-name: incident-management-<xxx>-destination-service
          service-plan: lite
        requires:
        - name: srv-api
    ```

    And in the same file to parameters add the following: 

	```yaml
    parameters: 
      deploy_mode: html5-repo 
      enable-parallel-deployments: true 
    ```

    Ensure to modify all the &lt;xxx&gt; with your teched user number.

4. Now you’ll have to add some scripts to execute the deployment. Open the `package.json` file in the root folder and add the following to the scripts section: 

    ```json
        "scripts": { 
            . . .
            "undeploy": "cf undeploy incident-management-<xxx> --delete-services --delete-service-keys --delete-service-brokers",
            "build": "rimraf resources mta_archives && mbt build --mtar archive",
            "deploy": "cf deploy mta_archives/archive.mtar --retries 1"
        }
    ```

    To run the build script, you’ll need to add the following to the devDependencies section in the same `package.json` file. 

    ```json
        "devDependencies": { 
            . . . 
            "rimraf": "^3.0.2" 
        }, 
    ```

5. Next make the following changes to the `app/incidents-<xxx>/package.json` file 
    ```json
    {
        . . .
        "scripts": {
            . . .
            "build:cf": "ui5 build preload --clean-dest --config ui5-deploy.yaml --include-task=generateCachebusterInfo"
        },
        "devDependencies": {
            "@sap/ui5-builder-webide-extension": "^1.1.8",
            "ui5-task-zipper": "^0.5.0",
            "mbt": "^1.2.18",
            "@ui5/cli": "^2.14.10"
        },
        "ui5": {
            "dependencies": [
                "@sap/ui5-builder-webide-extension",
                "ui5-task-zipper",
                "mbt"
            ]
        }
    }
    ```

6. You now must create a file named `ui5-deploy.yaml` inside `app/incidents-<xxx>`. To it add the following: 

    ```yaml
        #yaml-language-server: $schema=https://sap.github.io/ui5-tooling/schema/ui5.yaml.json
        specVersion: '2.4'
        metadata:
          name: ns<xxx>.incidents<xxx>
        type: application
        resources:
          configuration:
            propertiesFileSourceEncoding: UTF-8
        builder:
          resources:
            excludes:
              - "/test/**"
              - "/localService/**"
          customTasks:
          - name: webide-extension-task-updateManifestJson
            afterTask: replaceVersion
            configuration:
              appFolder: webapp
              destDir: dist
          - name: ui5-task-zipper
            afterTask: generateCachebusterInfo
            configuration:
              archiveName: ns<xxx>incidents<xxx>
              additionalFiles:
              - xs-app.json
    ```
    Modify with your teched user number accordingly.

7. Your application also needs some routes defined for proper navigation. For this create a file called `xs-app.json` in `app/incidents-<xxx>` and paste the following: 

	```json
        {
            "welcomeFile": "/index.html",
            "authenticationMethod": "route",
            "routes": [
                {
                "source": "^/odata/(.*)$",
                "target": "/odata/$1",
                "destination": "incident-management-<xxx>-srv-api",
                "authenticationType": "xsuaa",
                "csrfProtection": false
                },
                {
                "source": "^/resources/(.*)$",
                "target": "/resources/$1",
                "authenticationType": "none",
                "destination": "ui5"
                },
                {
                "source": "^/test-resources/(.*)$",
                "target": "/test-resources/$1",
                "authenticationType": "none",
                "destination": "ui5"
                },
                {
                "source": "^(.*)$",
                "target": "$1",
                "service": "html5-apps-repo-rt",
                "authenticationType": "xsuaa"
                }
            ]
        }
    ```
    Modify the first route's `destination` with your teched user number.

8. Finally, the `sap.cloud` object must be added to the `manifest.json` file inside `app/incidents-<xxx>`. 
    ```json
        {
            "_version": "1.58.0",
            "sap.app": {. . . },
            "sap.ui": {. . .},
            "sap.ui5": {. . .},
            "sap.fiori": {. . .},
            "sap.cloud": {
                "public": true,
                "service": "incidents-<xxx>"
            }
        }
    ```
    Do not forget to replace &lt;xxx&gt; with your teched user number.
 

 Now you can continue with the deployment from the **Assemble with the Cloud MTA Build Tool** step. 
 