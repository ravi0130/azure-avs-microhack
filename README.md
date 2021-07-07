# Handling Azure vMware Solution (AVS) network connectivity and migration scenario from on-premises to Azure

## [Scenario](#scenario)

## [Prerequisites](#prerequisites)

## Scenario

In this Microhack, you will :

- be given an overview of the AVS architecture,
- configure HCX and use it to migrate workloads.

This lab is built of :

- vMware vSphere Clusters hosted on-premises,
- the AVS solution hosted in Azure regions,
- A jumpbox deployed in Azure to control the overall architecture.

## Prerequisites

As part of the preparation tasks and to save time during the Microhack day, you are asked to perform the following prior to the Microhack delivery.

### Deploy the prerequisites in your Azure Subscription 

We use [BICEP artifacts](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview) to deploy part of the solution.

Those artifacts contain bicep files to deploy :

- An Azure Virtual Network named "adminVnet";
- An Express Route Gateway inside the "GatewaySubnet" of this vnet,
- A Windows 2019 Virtual Machine used as a jumpbox inside the "JumpboxSubnet"

You will connect this piece of the architecture to the AVS deployment in Azure later on.

TBC : Azure Cloud Shell
TBC : Sample command line

### Review material

Please watch the [Azure vMware Solution overview](https://www.site.placeholder) before the Microhack delivery day.
