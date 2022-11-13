![AVS MicroHack](/Images/schema/AVSMicroHackPic.png)

# Handling Azure vMware Solution (AVS) network connectivity and migration scenario from on-premises to Azure

## [Scenario](#scenario)

## [Prerequisites](#prerequisites)

## Scenario

In this Microhack, you will :

- be given an overview of the AVS architecture,
- configure HCX and use it to migrate workloads.

This lab is built of :

- 3 vMware vSphere Clusters hosted on-premises along with 3 vCenters,
- 3 AVS solution hosted in Azure regions aligned with the 3 vCenters instances,
- A jumpbox per user deployed in Azure to control a sepcific AVS instance.

![Lab schema](/Images/schema/Whiteboard.png)

Each pair of AVS + on-premises cluster is assigned a unique IP range for the jumpbox. [IP ranges info](docs/Appendix.md)

## AVS MicroHack Workflow for Candidates

![](/Images/schema/AVS-Microhack_Workflow.png)

## AVS Design Concepts Video

[![Azure VMware Solution MicroHack design video](https://res.cloudinary.com/marcomontalbano/image/upload/v1628861760/video_to_markdown/images/youtube--BGw5Nv_Kpiw-c05b58ac6eb4c4700831b2b3070cd403.jpg)](https://youtu.be/BGw5Nv_Kpiw "Azure VMware Solution MicroHack design video")
## Prerequisites

As part of the preparation tasks and to save time during the Microhack day, you are asked to perform the following prior to the Microhack delivery.

### Deploy the prerequisites in your Azure Subscription

We use [BICEP artifacts](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview) to deploy part of the solution.

Those artifacts contain bicep files to deploy :

- An Azure Virtual Network named "adminVnet";
- A VPN Gateway inside the "GatewaySubnet" of this vnet,
- A Windows 10 Virtual Machine used as a jumpbox inside the "JumpboxSubnet"
- A bastion service to connect to the jumpbox

This deployment is connected via VPN to the proctor adminVnet that has the Express Route gateway conected to both on-premises vMware environements and AVS.

The Windows 10 machine is using the DNS server hosted by the proctor to resolve all vMware resources.

