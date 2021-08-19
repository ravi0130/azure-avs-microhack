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

![Lab schema](/Images/schema/avs-microhack-lab-schema.png)

Each pair of AVS + on-premises cluster is assigned a unique IP range for the jumpbox. [IP ranges info](docs/Appendix.md)

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

### Task 1 : deploy

Steps:

- Log in to Azure Cloud Shell at [https://shell.azure.com/](https://shell.azure.com/) and select Bash

- Check if the current subscription is the one you want to deploy resources to :

  `az account show`

- If necessary select your target subscription:
  
  `az account set --subscription <Name or ID of subscription>`
  
- Clone the  GitHub repository:
  
  `git clone https://github.com/alexandreweiss/azure-avs-microhack`
  
  - Change directory:
  
  `cd ./azure-avs-microhack/users`

- Now start the deployment:

  `az deployment sub create -n rg-deploy-user -l canadacentral --template-file 0-main.bicep`

- You will be asked to enter the ID of the user you registered to in the excel file so you'll get assigned a unique IP range for your deployment.

Deployment takes approximately 30 minutes.

### Task 2 : Explore and verify

After the BICEP deployment concludes successfully, the following has been deployed into your subscription:

- A resource group named **azure-avs-microhack-user-XX-rg** containing :
  - A VNET with a Gateway subnet, a Jumpbox subnet and an Azure Bastion subnet.
  - In each of those subnets :
    - A VPN gateway connected to proctor gateway,
    - A Windows Server,
    - A Windows 10 desktop,
    - A bastion host.

- **The VM will have an auto-shutdown scheduled at night to save cost in your subscription. REMEMBER TO POWER IT ON THE D DAY !**

Verify these resources are present in the portal.

Credentials are identical for all VMs, as follows:

- Username: admin-avs
- Password: MicroHack/123

You may log on to the jumpbox VM through Bastion to test access is successfull.

After a few minutes once the VPN Gateway has been deployed, you may check on the VPN gateway that :

- the connection toHub is in status "connected"

 ![VPN Connection](/Images/schema/avs-microhack-vpn-connection-1.png)

- routes are received from proctor gateway

![BGP Peers](/Images/schema/avs-microhack-vpn-bgp-1.png)

User deployment finishes here.

## Proctor deployment

This is only deployed per the proctor once per MicroHack

### Task 1: deploy

This must be deployed **only once** per MicroHack and can survive for following MicroHacks.
It must be deployed in a **proctor subscription**.

**By default, gateways are not deployed. Change the 0-main.bicep file "DeployGateway" variable to true to deploy them.**
Once ER circuit are manually connected to the ER Gateway, you should revert the variable back to **false** to avoid ER circuit newly connected to be disconnected as they are not part of the deployment script.

Steps:

- Log in to Azure Cloud Shell at [https://shell.azure.com/](https://shell.azure.com/) and select Bash

- Check if the current subscription is the one you want to deploy resources to :

  `az account show`

- If necessary select your target subscription:
  
  `az account set --subscription <Name or ID of subscription>`
  
- Clone the  GitHub repository:
  
  `git clone https://github.com/alexandreweiss/azure-avs-microhack`
  
  - Change directory:
  
  `cd ./azure-avs-microhack/proctor`

- Now start the deployment:

  `az deployment sub create -n rg-deploy-proctor -l canadacentral --template-file 0-main.bicep`

### Task 2 : Configure the Windows DNS Server on server VM

- Using Bastion, login to the Windows Server VM called "server"
- Add the DNS Role and Remote Management Tools
- Configure the conditional forwarders for the 3 environments :
  - microhack-**one**.zpod.io forwards to 10.96.96.2
  - microhack-**two**.zpod.io forwards to 10.96.93.2
  - microhack-**three**.zpod.io forwards to 10.96.53.2

### Task 3 : update the proctor vnet DNS configuration

  `az deployment sub create -n rg-deploy-user -l canadacentral --template-file 1-update-dns.bicep`

Once done, you should issue an "ipconfig /renew" on each the jumpbox and the server VM to retreive the new DNS server configuration.

You can confirm by running "ipconfig /all" to see the DNS Server transitionned from 168.63.129.16 to the new 10.228.x.x IP.

### Task 4 : Explore and verify

After the BICEP deployment concludes successfully, the following has been deployed into your subscription:

- A resource group named **azure-avs-microhack-proctor-1-rg** containing :
  - A VNET with a Gateway subnet, a Jumpbox subnet and an Azure Bastion subnet.
  - In each of those subnets :
    - A VPN gateway connected to users VPN gateways,
    - An ER gateway,
    - An Azure Route Server to route branch to branch traffic,
    - A Windows Server Jumbox,
    - A bastion host.

- **The VM will have an auto-shutdown scheduled at night to save cost in your subscription. REMEMBER TO POWER IT ON THE D DAY !**

Verify these resources are present in the portal.

Credentials are identical for all VMs, as follows:

- Username: admin-avs
- Password: MicroHack/123

You may log on to the jumpbox VM through Bastion to test access is successfull.

You may check BGP is up:

- between your proctor VPN Gateway (ASN 65013) and all users VPN Gateway (Sample here with user 2, ANS 65002 and 4, ASN 65004)

- betwenn your proctor VPN Gateway (ASN 65013) and the Route Server (ASN 65515)

![BGP Peers](/Images/schema/avs-microhack-vpn-bgp-proctor-1.png)

Route Server is in Public Preview and is accessible only via https://aka.ms/routeserver