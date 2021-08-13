Challenge 2
"NSX Familiarisation"
---

# Introduction

In this challenge, you will perform the following tasks:

1.	Use NSX-T DHCP server
2.	Add a Network Segment
3.	Configure a DNS forwarder
4.	Attach a Virtual Machine to the Network Segment
5.	Configure a Distributed Firewall using NSX-T

Please carefully follow the instructions provided by your facilitator. 

Work with the instructor to ensure your VMware environment has the required permissions to access your AVS vCenter Server and the NSX Manager.

Applications and workloads running in an Azure VMware Solution private cloud environment require name resolution and DHCP services (optionally) for lookup and IP address assignments. A proper DHCP and DNS infrastructure are required to provide these services. You can configure a virtual machine to provide these services in your private cloud environment.

## Use NSX-T DHCP server
Here you will be using NSX-T to host your DHCP server and you will create a DHCP. Then you'll add a network segment and specify the DHCP IP address range.
### Create a DHCP server
1.	In the Azure VMware Solution portal, go to Workload Networking > DHCP and then select Add.

<img src="/home/ravi/azure-avs-microhack/Images/NSX/NSX_image1.png">

1.	Select DHCP for the Server Type, provide the server name and IP address CIDR, and then select OK.
 
<img src="/home/ravi/azure-avs-microhack/Images/NSX/NSX_image2.png">
 
2.	Once done, the DHCP server will be listed in the DHCP tab 
 
<img src="/home/ravi/azure-avs-microhack/Images/NSX/NSX_image3.png">

### Note
This DHCP server automatically gets connected to the default Tier 1 Gateway

3.	You can now log on to NSX Manager in AVS and verify that the DHCP server is attached to the Tier1 Gateway

## Add a Network Segment
1.	In NSX-T Manager, select Networking > Segments, and then select Add Segment.

<img src="/home/ravi/azure-avs-microhack/Images/NSX/NSX_image4.png">
 
2.	Enter a name for the segment.

3.	Select the Tier-1 Gateway (TNTxx-T1) as the Connected Gateway 

4.	Select the pre-configured overlay Transport Zone (TNTxx-OVERLAY-TZ) and then select Set Subnets in gateway/prefix length format.

<img src="/home/ravi/azure-avs-microhack/Images/NSX/NSX_image5.png">

5.	Select Apply and then Save.

### Note
The IP address needs to be on a non-overlapping RFC1918 address block, which ensures connection to the VMs on the new segment.

## Configure a DNS forwarder

By default, Azure VMware Solution management components such as vCenter can only resolve name records available through Public DNS. However, certain hybrid use cases require Azure VMware Solution management components to resolve name records from privately hosted DNS to properly function, including customer-managed systems such as vCenter and Active Directory.

Private DNS for Azure VMware Solution management components lets you define conditional forwarding rules for the desired domain name to a selected set of private DNS servers through the NSX-T DNS Service.

This capability uses the DNS Forwarder Service in NSX-T. A DNS service and default DNS zone are provided as part of your private cloud. To enable Azure VMware Solution management components to resolve records from your private DNS systems, you must define an FQDN zone and apply it to the NSX-T DNS Service. The DNS Service conditionally forwards DNS queries for each zone based on the external DNS servers defined in that zone.

## Configure DNS forwarder
1.	In your Azure VMware Solution private cloud, under Workload Networking, select DNS > DNS zones. Then select Add.

<img src="/home/ravi/azure-avs-microhack/Images/NSX/NSX_image6.png">

2.	Select default zone

<img src="/home/ravi/azure-avs-microhack/Images/NSX/NSX_image7.png">
 
3.	Provide a name and up to three DNS server IP addresses in the format of 1.1.1.1 and 8.8.8.8. Then select Save.

<img src="/home/ravi/azure-avs-microhack/Images/NSX/NSX_image8.png">

It takes several minutes to complete, and you can follow the progress from Notifications. You’ll see a message in the Notifications when the DNS zone has been created.

4.	Select the DNS service tab and then select Add DNS Service and provide the details of the name, select Tier 1 Gateway, DNS Server IP and Default DNS Done and press Save.

<img src="/home/ravi/azure-avs-microhack/Images/NSX/NSX_image9.png">
 
It takes several minutes to complete and once finished, you'll see the Completed message from Notifications. At this point, management components in your private cloud should be able to resolve DNS entries from the FQDN zone provided to the NSX-T DNS Service.

## Create a Distributed firewall

Ensure the following predeployed VMs are already deployed within the AVS vCenter server 

mhack-tinycore-4
&
mhack-tinycore-5

1.	From your browser, log in with admin privileges to an NSX Manager at https://<nsx-manager-ip-address>.

2.	Go to Inventory > Groups > Add Group 
 
3.	Add a group name as Application1 and then press Set Members

<img src="/home/ravi/azure-avs-microhack/Images/NSX/NSX_image10.png">
 
4.	Add the IP of mhack-tinycore-4  VM IP to this group and the press apply

<img src="/home/ravi/azure-avs-microhack/Images/NSX/NSX_image11.png">
 
5.	Then press save button
 
<img src="/home/ravi/azure-avs-microhack/Images/NSX/NSX_image12.png">

6.	Now create a second Application group and click set members

<img src="/home/ravi/azure-avs-microhack/Images/NSX/NSX_image13.png">
 
7.	Click the IP addresses and then provide the IP address of the AVS mhack-tinycore-5 VM and then press apply

<img src="/home/ravi/azure-avs-microhack/Images/NSX/NSX_image14.png">
 
8.	Select Security > Distributed Firewall from the navigation panel.

9.	Click Add Policy


<img src="/home/ravi/azure-avs-microhack/Images/NSX/NSX_image15.png">
 
10.	Enter a Name for the new policy section.

<img src="/home/ravi/azure-avs-microhack/Images/NSX/NSX_image16.png">
 
11.	Click Add Rule
 
<img src="/home/ravi/azure-avs-microhack/Images/NSX/NSX_image17.png">

12.	Set source for the rule by selecting the first Application group and then press apply

<img src="/home/ravi/azure-avs-microhack/Images/NSX/NSX_image18.png">
 
13.	Set destination for the rule by selecting the first Application group and then press apply

<img src="/home/ravi/azure-avs-microhack/Images/NSX/NSX_image19.png">
 
14.	Keep the action as Allow and then press publish

<img src="/home/ravi/azure-avs-microhack/Images/NSX/NSX_image20.png">

15.	One you firewall rule has been published, ping the mhack-tinycore-5 VM from mhack-tinycore-4 VM. We should notice that the ping is going through

16.	Now come back to the distributed firewall and set the action to reject

17.	Now ping the mhack-tinycore-5 VM from mhack-tinycore-4 VM. We should notice that the ping is blocked

This proves the distributed firewall rule between the 2 application groups

This concludes the NSX familiarisation for AVS!!

