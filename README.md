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

To make the most of your time on this MircoHack, the green elements in the diagram above are deployed and configured for you through BICEP.

### Task 1: deploy

Steps:

- Log in to Azure Cloud Shell at [https://shell.azure.com/](https://shell.azure.com/) and select Bash
- Ensure Azure CLI and extensions are up to date:
  
  `az upgrade --yes`
  
- If necessary select your target subscription:
  
  `az account set --subscription <Name or ID of subscription>`
  
- Clone the  GitHub repository:
  
  `git clone https://github.com/alexandreweiss/azure-avs-microhack`
  
  - Change directory:
  
  `cd ./azure-avs-microhack`

- Now start the deployment (when prompted, confirm with **yes** to start the deployment):

  `az deployment group create -n rg-deploy -g azure-avs-microhack-rg --template-file 0-main.bicep`

Deployment takes approximately 30 minutes.

## Task 2: Explore and verify

After the BICEP deployment concludes successfully, the following has been deployed into your subscription:

- A resource group named **azure-avs-microhack-rg** containing :
  - A VNET with a Gateway subnet, a Jumpbox subnet and an Azure Bastion subnet.
  - In each of those subnets :
    - An Express Route gateway,
    - A Windows Server Jumbox,
    - A bastion host.

Verify these resources are present in the portal.

Credentials are identical for all VMs, as follows:

- Username: admin-avs
- Password: MicroHack/123

You may log on to the jumpbox VM through Bastion to test access is successfull.

### Review material

Please watch the [Azure vMware Solution overview](https://www.site.placeholder) before the Microhack delivery day.
