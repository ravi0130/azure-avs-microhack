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
- 3 AVS solution hosted in Azure regions aligned with nested On Prem vCenters instances,
- A jumpbox per user deployed in Azure to control AVS and On Prem instances.

![Lab schema](/Images/schema/Whiteboard.png)

Each pair of AVS + on-premises cluster is assigned a unique IP range for the jumpbox. [IP ranges info](docs/Appendix.md)

## AVS Design Concepts Video

[![Azure VMware Solution MicroHack design video](https://res.cloudinary.com/marcomontalbano/image/upload/v1628861760/video_to_markdown/images/youtube--BGw5Nv_Kpiw-c05b58ac6eb4c4700831b2b3070cd403.jpg)](https://youtu.be/BGw5Nv_Kpiw "Azure VMware Solution MicroHack design video")