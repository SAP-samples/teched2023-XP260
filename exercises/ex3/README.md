# Exercise 3 - Add SAP Fiori Elements UIs

In this exercise, we will learn
- How to generate the UI with an SAP Fiori elements template
- How to modify the UI with the SAP Fiori page editor

## Overview

SAP Fiori elements provides designs for UI patterns and predefined floorplans for common application use cases. Application developers can use SAP Fiori elements to create SAP Fiori applications based on OData services and annotations that don't need JavaScript UI coding. The resulting application uses predefined views and controllers that are provided centrally. This means no application-specific view instances are required. SAPUI5 interprets the metadata and the annotations of the underlying OData service and uses the corresponding views for the SAP Fiori application at startup.

By following one of the [SAP Fiori elements floorplans](https://sapui5.hana.ondemand.com/#/topic/797c3239b2a9491fa137e4998fd76aa7.html), you:

- Boost your development productivity
- Get future-proof UX consistency
- Get enterprise readiness

To learn more about each of these points, see [Why Use SAP Fiori Elements?](https://sapui5.hana.ondemand.com/#/topic/0a5377076f4e4ccba055a9072befadbd).

## Generate the UI with an SAP Fiori Elements template

1. In SAP Business Application Studio, go to your **IncidentManagement** dev space.

    > Make sure the **IncidentManagement** dev space is in status **RUNNING**.

2. To invoke the Command Palette, choose the burger menu and then choose **View** &rarr; **Command Palette**.

    > You can also invoke the Command Palette quickly using the following key combination:
    >
    > - For macOS: <kbd>Command</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd>
    > - For Windows: <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd>

3. Type **Fiori: Open Application Generator** in the field and select this entry from the list.

4. In the **Template Selection** step:

    - In the **Template Type** dropdown menu, select **SAP Fiori**. Then, choose the **List Report Page** template tile.

    - Choose **Next**.

       ![V4 Template](./images/vscv4template.png)

5. In the **Data Source and Service Selection** step:

    - In the **Data source** dropdown menu, select **Use a Local CAP Project**.

    - In the **Choose your CAP project** dropdown menu, select the `incident-management-<xxx>` project.

    - In the **OData service** dropdown menu, select the **ProcessorService(Node.js)**.
    
    - Choose **Next**.

        ![CAPpro](./images/datasourceselection.png)

6. In the **Entity Selection** step:

    - In the **Main entity** dropdown menu, select **Incidents**.

    - Leave the **Navigation entity** value as **none**, and then select **Yes** to add table columns automatically.
    
    - Choose **Next**.

        ![Entity selection](./images/entityselection.png)

7. In the **Project Attributes** step:

    - In the **Module name** field, enter `incidents-<xxx>`.

    - In the **Application title** field, enter **Incident-Management**.

    - In the **Application namespace** field, enter `ns<xxx>`.

    
>Use your teched user number for `xxx`. Eg., If your teched user name is XP260-001, use 001 as the `xxx`.
    - Leave the default values for all the other settings and choose **Finish**.

        ![Project names](./images/vscrfeapp.png)

    The application is now generated and in a few seconds you can see the application's **incidents** folder in the **app** folder of your **incident-management** project. It contains a **webapp** folder with a **Component.js** file that is typical for an SAPUI5 application. However, the source code of this application is minimal. It inherits its logic from the **sap/fe/core/AppComponent** class. This class is managed centrally by SAP Fiori elements and provides all the services that are required (routing, edit flow) so that the building blocks and the templates work properly.

### Start the Incident-Management application

Instead of using `cds watch` command in the terminal to start the service, you will use the `watch-incidents` script that has been added to the **package.json** file by the application generator. The script contains an additional `sap-ui-xx-viewCache=false` parameter added to the application's start URL. This parameter ensures that if custom extensions are implemented, changes to the extension artifacts get properly updated when refreshing the UI.

> If the `cds watch` command is already running in a terminal, end it with the <kbd>Ctrl</kbd> + <kbd>C</kbd> key combination. Otherwise the default port 4004 will already be in use by the running CAP server's process.


1. In the **Application Info - incidentsxxx** tab, choose the **Preview Application** option.

    ![Application Info](./images/appInfo.png)

    > If you get an error **SyntaxError: Unexpected token / in JSON at position 4**, open the file **.vscode/launch.json**, delete any comments that you have there, and try again. 

    This opens a dropdown menu at the top offering all scripts maintained in the scripts section of the `package.json` file that are based on the `cds run` and `cds watch` commands.

    > In case the **Application Info - incidentsxxx** tab is closed: 
    >
    >1. Invoke the Command Palette - **View** &rarr; **Command Palette** or <kbd>Command</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> for macOS / <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> for Windows. 
    >2. Choose **Fiori: Open Application Info**.

2. Select the **watch-incidents-xxx** npm script.

    ![Watch script](./images/watchScript.png)

    This script runs the service in an application modeler terminal session and automatically starts the SAP Fiori application in a new browser session.

3. You can now see the application with the generated columns. Choose **Go**.

    ![Application with the generated columns](./images/ls2.png)

## Configure the List View Page

In this section, you'll modify the List View Page of the UI with the SAP Fiori page editor.

#### Add filter fields

1. In the **Application Info - incidentsxxx** tab, choose the **Open Page Map** option.

    ![Page Map](./images/PageMap.png)

    You will see the properties on the right side of the page map. You can edit these properties to update the UI of the application.

    > In case the **Application Info - incidentsxxx** tab is closed: 
    >
    >1. Invoke the Command Palette - **View** &rarr; **Command Palette** or <kbd>Command</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> for macOS / <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> for Windows. 
    >2. Choose **Fiori: Open Application Info**.

2. In the **List Report** tile, choose the pencil icon next to the title.

    ![List Report Page Config](./images/ls3.png)

3. In the **Filter Bar** section, choose **Filter Fields** and then choose the icon to add filter fields.

     ![Add Filter Fields](./images/ls4.png)

4. In the **Add Filter Fields** popup:

    - Select the **status_code** and **urgency_code** checkboxes in the **Filter Field** dropdown menu.
    - Choose **Add**. Your application will be updated to show the new filters.

    ![New Filters Added](./images/ls5.png)

    > This is how you define which properties are exposed as search fields in the header bar above the list.

#### Edit filter fields

The filter labels are text strings. It's a good idea to update them so they are compliant with internationalization standards (i18n).

5. Change the **urgency_code** filter label. In the **Label** field, change the value to **Urgency**. Press <kbd>Enter</kbd> to confirm the change.

6. Choose the **Globe** icon to generate a translatable text key and choose **Apply**.

    ![Generate Translatable Text Key](./images/ls10.png)

7. Choose the **status_code** filter. In the **Label** field, change the value to **Status**. Press <kbd>Enter</kbd> to confirm the change.

8. Choose the **Globe** icon to generate a translatable text key and choose **Apply**.

9. For both the **Urgency** and **Status** filters, in the **Display Type** dropdown menu, select **Value Help**. A popup shows up. 

10. In the **Define Value Help Properties for Urgency/Status** popup: 

    - Choose the dropdown menu in the **Value Description Property** field.
    - Select **descr**.
    - Choose **Apply**.

#### Edit columns

10. Expand the **Columns** section under **Table** and delete the columns **urgency_code** and **status_code**. 

11. In **Table** &rarr; **Columns**, choose the **Plus** icon to add columns. Choose **Add Basic Columns**.

    ![Add Basic Columns](./images/ls6.png)

12. In the **Add Basic Columns** popup, choose the dropdown menu in the **Columns** field and:

    - Select the **status** &rarr; **descr** checkbox.
    - Select the **urgency** &rarr; **descr** checkbox.
    - Select the **customer** &rarr; **name** checkbox and add the columns.

14. Select the **name** column and choose **^** to move the column up just under the **Title** column.

15. Choose the **title** column, choose the **Globe** icon in the **Label** field to generate a translatable text key, and apply the changes.    

    > The filter labels are text strings. It's a good idea to update them so they are compliant with internationalization standards (i18n).

    > Learn more about how internationalization works for the backend part in [Where to Place Text Bundles?](https://cap.cloud.sap/cap/docs/guides/i18n#where-to-place-text-bundles) in the CAP documentation.

5. For each of the **name**, **Description (urgency/descr)**, and **Description (status/descr)** columns:

    - In the **Label** field, change the value to **Customer**, **Urgency**, and **Status**, respectively.
    - Press <kbd>Enter</kbd> to confirm the change.
    - Choose the **Globe** icon in the **Label** field to generate a translatable text key.


#### Configure tables

17. Choose **Table** and in the **Initial Load** dropdown menu, select **Enabled** to load the data automatically.

    ![Enable Data Auto Load](./images/ls8.png)

18. In the **Type** dropdown menu, select **ResponsiveTable** to make the table responsive.
  
19. Navigate to **Table** &rarr; **Columns** &rarr; **Status** and in the **Criticality** dropdown menu, select **status/criticality**.

    ![Add Status Criticality](./images/criticality.png)

#### Check the result

20. The list page of the Incident Management application should look like this:

    ![Incident Management App's List Page](./images/IncidentsUI.png)

21. Navigate back to the page editor and choose **Page Map** in the top left. This takes you back to the overview of the **Incident-Management** application.

### Configure the Incident Object Page

In this section, you'll modify the Incident Object Page of the UI with the SAP Fiori page editor.

#### Edit header

1. Make sure the SAP Fiori page editor is open. If you closed it, choose the **Open Page Map** option in the **Application Info - incidents** tab.

    > To open the **Application Info - incidents** tab: 
    >
    >1. Invoke the Command Palette - **View** &rarr; **Command Palette** or <kbd>Command</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> for macOS / <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> for Windows. 
    >2. Choose **Fiori: Open Application Info**.

2. In the **Incident Object Page** tile, choose the pencil icon next to the title.

3. Choose **Header** and in the **Title** dropdown menu, select **title**.

    ![Select Title](./images/obj1.png)

4. In the **Description Type** dropdown menu, select **Property**. A popup opens.

5. In the **Define Property** popup, choose the dropdown menu in the **Description** field and:

    - Select **customer** &rarr; **name**.
    - Choose **Apply**.

    ![Apply Name](./images/obj2.png)

6. In the **Icon URL** field, enter `sap-icon://alert`.

#### Add Overview section

8. Choose **Sections** and then choose the **Plus** icon to add more sections. Choose **Add Group Section**. 

9. In the **Add Group Section** popup:

    - Enter **Overview** in the **Label** field.
    - Choose the **Globe** icon to generate a translatable text key. 
    - Choose **Add**.

    ![Add Overview Section](./images/obj5.png)

#### Add Details subsection

9. Navigate to **Sections** &rarr; **Overview** &rarr; **Subsections**.

10. Choose the **Plus** icon to add more sections and choose **Add Form Section**.

10. In the **Add Form Section** popup:

    - Enter **Details** in the **Label** field.
    - Choose the **Globe** icon to generate a translatable text key. 
    - Choose **Add**.

#### Configure fields

7. Navigate to **Sections** &rarr; **General Information** &rarr; **Form** &rarr; **Fields** and delete the **urgency_code** and **status_code** fields.

8. Navigate to **Sections**, drag the **General Information** and drop it in the **Overview** &rarr; **Subsections** node.

    ![Add Basic Fields](./images/obj3.png)

10. Navigate to **Sections** &rarr; **Overview** &rarr; **Subsections** &rarr; **Details** &rarr; **Form** &rarr; **Fields**, choose the **Plus** icon to add more fields, and then choose **Add Basic Fields**.

    ![Add Basic Fields](./images/obj6.png)

11. In the **Add Basic Fields** popup

    - From the dropdown menu in the **Fields** field, select **status_code**, **urgency_code**, and **customer_ID**. 
    - Choose **Add**.

5. For each of the **customer_ID**, **urgency_code**, and **status_code** fields:

    - In the **Label** field, change the value to **Customer**, **Urgency**, and **Status**, respectively.
    - Press <kbd>Enter</kbd> to confirm the change.
    - Choose the **Globe** icon in the **Label** field to generate a translatable text key.

14. For the **Status** field, select **status/descr** in the **Text** dropdown menu and then select **Value Help** in the **Display Type** dropdown menu. A popup opens.

13. In the **Define Value Help Properties for Status** popup:

    - Select **Status** in the **Value Source Entity** dropdown menu.
    - Select **code** in the **Value Source Property** dropdown menu.
    - Select **descr** in the **Value Description Property** dropdown menu.
    - Leave the default values for the rest of the properties and choose **Apply**.

16. For the **Urgency** field, select **urgency/descr** in the **Text** dropdown menu and then select **Value Help** in the **Display Type** dropdown menu. A popup opens.

16. In the **Define Value Help Properties for Urgency** popup:

    - Select **Urgency** in the **Value Source Entity** dropdown menu.
    - Select **code** in the **Value Source Property** dropdown menu.
    - Select **descr** in the **Value Description Property** dropdown menu.
    - Leave the rest of the properties with the default values and choose **Apply**.

17. For the **Customer** field, select **customer/name** in the **Text** dropdown menu, select **Text Only** in the **Text Arrangement** dropdown menu, and then select **Value Help** in the **Display Type** dropdown menu. A popup opens.

19. In the **Define Value Help Properties for Customer** popup:

    - Select **Customers** in the **Value Source Entity** dropdown menu.
    - Select **ID** in the **Value Source Property** dropdown menu.
    - Select **name** in the **Value Description Property** dropdown menu.
    - In the **Text Arrangement** dropdown menu, select **Text Only**.
    - Switch off **Display as Dropdown**.
    - In the **Result List** section, add the columns **name** and **email** by choosing **Add Column**.
    - Choose **Apply**.

#### Add Conversations section

19. Navigate to **Sections** and then choose the **Plus** icon to add more sections. 

20. Choose **Add Table Section**. A popup appears.

20. In the **Add Table Section** popup:

    - Enter **Conversations** in the **Label** field.
    - Choose the **Globe** icon to generate a translatable text key. 
    - Select **conversations** in the **Source Value** dropdown menu and choose **Add**.

    ![Add Conversations Label](./images/obj9.png)

#### Configure columns

21. Navigate to **Conversations** &rarr; **Table** &rarr; **Columns** and choose the **Plus** icon to add columns. 

22. Choose **Add Basic Columns**. A popup appears.

23. In the **Add Basic Columns** popup:

    - In the **Columns** dropdown menu, select **author**, **message**, and **timestamp**. 
    - Choose **Add**.

5. For each of the **author**, **message**, and **timestamp** columns:

    - In the **Label** field, change the value to **Author**, **Message**, and **Conversation Date**, respectively.
    - Press <kbd>Enter</kbd> to confirm the change.
    - Choose the **Globe** icon in the **Label** field to generate a translatable text key.

#### Configure table and check the result

22. For **Table**, in the **Type** dropdown menu, select **ResponsiveTable** to make the table responsive.

23. In the **Creation Mode: Name** dropdown menu, select **Inline**.

24. The complete list object page looks like this:

    ![Complete List Object Page](./images/obj11.png)

### Enable draft with `@odata.draft.enabled`

SAP Fiori supports editing business entities with draft states stored on the server, so users can interrupt editing and continue later on, possibly from different places and devices. CAP, as well as SAP Fiori elements, provide out-of-the-box support for drafts. We recommend that you always use draft when your SAP Fiori application needs data input by end users.

>- For more details, see the SAP Fiori Design Guidelines for [Draft Handling](https://experience.sap.com/fiori-design-web/draft-handling/).
>- Read more about [Draft Support](https://cap.cloud.sap/docs/advanced/fiori#draft-support) in the CAP documentation.

Enabling a draft for an entity allows the users to edit the entities. To enable a draft for an entity exposed by a service, follow these steps:

1. Open the **srv/processor-service.cds** file.

2. Annotate the file with `@odata.draft.enabled` like this:

    ```js[5]
    service ProcessorService { 
    ...
    }
    ...
    annotate ProcessorService.Incidents with @odata.draft.enabled; 
    ```

3. Start creating a new incident but leave the **Customer**, **Status**, and **Urgency** fields empty.

    ![Draft incident with empty fields](./images/draft-incident-empty.png)

4. Go back to the list view page without creating the incident. You should be able to see the incident draft there with the empty fields.

    ![List view page with draft incident](./images/draft-incident-list-view-page.png)

5. Try to access it again to continue the creation from where you stopped.

    ![Draft incident, continue editing ](./images/draft-incident-continue.png)
