[![REUSE status](https://api.reuse.software/badge/github.com/SAP-samples/teched2023-XP260)](https://api.reuse.software/info/github.com/SAP-samples/teched2023-XP260)

# XP-260 - Getting Started with Full-Stack Application Development on SAP BTP.

## Description

This repository contains the material for the SAP TechEd 2022 session called XP-260 - Getting Started with Full-Stack Application Development on SAP BTP..  

## Overview

The goal of this handson is to help developers implementing business applications on SAP BTP including the integration with the SAP cloud suite. 
This session introduces attendees to...
    * Building a CAP application with SAP Fiori Elements user interface and a custom logic
    * Adding local launchpad, authorization and tests for local development
    * Deploying the application in a productive account
    * Remote Service Integration to the developed CAP application

## Requirements

The requirements to follow the exercises in this repository are...
- You have an [enterprise global account](https://help.sap.com/docs/btp/sap-business-technology-platform/getting-global-account#loiod61c2819034b48e68145c45c36acba6e) in SAP BTP. To use services for free, you can sign up for a CPEA (Cloud Platform Enterprise Agreement) or a Pay-As-You-Go for SAP BTP global account and make use of the free tier services only. See [Using Free Service Plans](https://help.sap.com/docs/btp/sap-business-technology-platform/using-free-service-plans?version=Cloud).
- You have an S-user or P-user. See [User and Member Management](https://help.sap.com/docs/btp/sap-business-technology-platform/user-and-member-management).
- You are an administrator of the global account in SAP BTP.
- You have a subaccount in SAP BTP to deploy the services and applications.
- You have one of the following browsers that are supported for working in SAP Business Application Studio:
    - Mozilla Firefox
    - Google Chrome
    - Microsoft Edge
- You have configured SAP HANA Cloud and SAP Authorization and Trust Management service in your project in SAP Business Application Studio. See [Prepare for Production](../../prep-for-prod.html)

<!-- Assign Entitlements start -->

### Configure the entitlements

**Prerequisite:** You must have an administrator role for SAP BTP.

To deploy the Incident Management applications, you need the following entitlements:

| Service     |      Plan      |  Quota required |
| ------------- | :-----------: | ----: |
| Cloud Foundry runtime | free (Environment) |   1 |
| SAP Build Work Zone, standard edition    |  free (Application)    |   1 |
| SAP HANA Cloud |   hana-free    |   1 |
| SAP HANA Cloud |   tools (Application)   |   1 |
| SAP HANA Schemas & HDI Containers |   hdi-shared   |   1 |

## Exercises

Provide the exercise content here directly in README.md using [markdown](https://guides.github.com/features/mastering-markdown/) and linking to the specific exercise pages, below is an example.

- [Introduction to Application Development Using CAP](./exercises/Introduction%20to%20Application%20Development%20Using%20CAP/README.md)
- [Build a CAP Application](./exercises/Build%20a%20CAP%20Application/README.md)
- [Add Fiori Elements UIs](./exercises/Add%20Fiori%20Elements%20UIs/README.md)
- [Add Custom Logic](./exercises/Add%20Custom%20Logic/README.md)
- [Use a Local Launch Page](./exercises/Use%20a%20Local%20Launch%20Page/README.md)
- [Add Authorization](./exercises/Add%20Authorization/README.md)
- [Add Test Cases](./exercises/Add%20Test%20Cases/README.md)
- [Prepare for Production](./exercises/Prepare%20for%Production/README.md)
- [Deploy in SAP BTP, Cloud Foundry Runtime](./exercises/Deploy%20in%20SAP%20BTP,%20Cloud%20Foundry%20Runtime/README.md)
- [User Role Assignment](./exercises/User%20Role%20Assignment/README.md)
- [Integrate Your Application with SAP Build Work Zone, Standard Edition](./exercises/Integrate%20Your%20Application%20with%20SAP%20Build%20Work%20Zone,%20Standard%20Edition/README.md)
- [Download EDMX for SAP S/4HANA Business Partner API](./exercises/Download%20EDMX%20for%20SAP%20S4HANA%20Business%20Partner%20API/README.md)
- [Implement Remote Service Connectivity](./exercises/Implement%20Remote%20Service%20Connectivity/README.md)
- [Local Testing of the Incident Management Application](./exercises/Local%20Testing%20of%20the%20Incident%20Management%20Application/README.md)
- [Deploy the application to SAP BTP Cloud Foundry Runtime](./exercises/Deploy%20the%20application%20to%20SAP%20BTP%20Cloud%20Foundry%20Runtime/README.md)
- [Test the end to end flow](./exercises/Test%20the%20end%20to%20end%20flow/README.md)

**IMPORTANT**

Your repo must contain the .reuse and LICENSES folder and the License section below. DO NOT REMOVE the section or folders/files. Also, remove all unused template assets(images, folders, etc) from the exercises folder. 

## Contributing
Please read the [CONTRIBUTING.md](./CONTRIBUTING.md) to understand the contribution guidelines.

## Code of Conduct
Please read the [SAP Open Source Code of Conduct](https://github.com/SAP-samples/.github/blob/main/CODE_OF_CONDUCT.md).

## How to obtain support

Support for the content in this repository is available during the actual time of the online session for which this content has been designed. Otherwise, you may request support via the [Issues](../../issues) tab.

## License
Copyright (c) 2023 SAP SE or an SAP affiliate company. All rights reserved. This project is licensed under the Apache Software License, version 2.0 except as noted otherwise in the [LICENSE](LICENSES/Apache-2.0.txt) file.
