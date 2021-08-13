Challenge 1
"Azure to AVS Connectivity"
---

# Introduction
In this challenge, you will perform the following tasks:

1.	Ensure Azure VNET, Jump Box and the ExpressRoute Gateway for the Microhack are deployed
2.	Connect Azure VNET to AVS thought ExpressRoute
3.	Access AVS vCenter and NSX manager through the Jumpbox

Please carefully follow the instructions provided by your facilitator. Incorrectly deploying the Azure VNET may result in multiple forthcoming steps not operating as expected.

Work with the instructor to ensure your VMware environment has the required permissions to access your AVS vCenter Server and the NSX Manager.


An Azure VMware Solution private cloud requires an Azure Virtual Network. Because Azure VMware Solution doesn't support your on-premises vCenter, extra steps are needed for integration with your on-premises environment. 

It is expected that all candidates would have deployed the script provided by the facilitator to deploy the AVS VNET, Jumphost and ExpressRoute Gateway before coming for the Microhack 

## Connect ExpressRoute to the virtual network gateway

In order to connect the  virtual network gateway, you'll add a connection between the gateway and your Azure VMware Solution private cloud.

## Request an ExpressRoute authorization key:
1.	In the Azure portal, navigate to the Azure VMware Solution private cloud. Select Manage > Connectivity > ExpressRoute and then select + Request an authorization key.

![](/Images/VNET/VNET_image1.png)

2.	Provide a name for it and select Create.
3.	It may take about 30 seconds to create the key. Once created, the new key appears in the list of authorization keys for the private cloud.

4.	Copy the authorization key and ExpressRoute ID. You'll need them to complete the peering. The authorization key disappears after some time, so copy it as soon as it appears.

5.	Navigate to the virtual network gateway you plan to use and select Connections > + Add.

![](/Images/VNET/VNET_image2.png)

On the Add connection page, provide values for the fields, and select OK.

Field | Value
------ | ------
Name     | Enter a name for the connection
Connection type    |   Select ExpressRoute    
Redeem authorization   |   Ensure this box is selected
Virtual network gateway     | Enter a name for the connection   
Authorization key    |   Paste the authorization key you copied earlier   
Peer circuit URI   |   Paste the ExpressRoute ID you copied earlier
 
![](/Images/VNET/VNET_image3.png)

The connection between your ExpressRoute circuit and your Virtual Network is created.

![](/Images/VNET/VNET_image4.png)