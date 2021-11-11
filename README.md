# docker-compose-macvlan
### Docker-compose example using macvlan driver. **Example using ansible is included! See ansible folder**  
This docker-compose file creates a network using macvlan driver and deploys portainer container (Used just as an example) attaching it to the same newly created network.  
This gives you the ability to **deploy containers with custom static IP address** which is different 
from the host IP address - and all of it without DHCP reservations! **(Ensure defined IP address is not used by another host/device/container though!)**.  
You can reach the container with custom defined IP address from any host on the same LAN,
**however you can not reach it from the host machine itself (Below are instructions how to mitigate this)**.  

## Enable host to container networking:
Check the **Enable-host-to-container-networking.sh** script file or manual steps defined.   
For making container accessible within the same host - one needs to create ethernet interface and route the containers used IP address (or range) trough the new interface:   

* Create new interface (Interface name is *dockerrouteif*, and *eth0* is the host interface):  
`ip link add dockerrouteif link eth0 type macvlan mode bridge`

* Then assign IP address to that interface (Imagine it as a gateway - just like a router works but without NAT). In this example I used 192.168.0.249:  
`ip addr add 192.168.0.249/32 dev dockerrouteif`  
**NOTE: Ensure defined IP address is not used by another host/device/container though!**  
**NOTE: If you check logs i.e. host is using DNS server which is in a container, any requests made from the host will be seen as coming from this IP**  

* Bring up that interface:  
`ip link set dockerrouteif up`

* And finally define a range which should be routed trough that iterface:  
`ip route add 192.168.0.64/26 dev dockerrouteif`

Lastly, bring up the docker compose file:  
`docker-compose up -d`  
Success! Portainer now should be accessible from the host machine and all other machines within the same subnet/network!  
  
### Network used in the example:
Host interface name: `eth0`  
Gateway: `192.168.0.1`  
Subnet: `192.168.0.0/24`  
Host IP: `192.168.0.2`  
Interface name trough which traffic is routed: `dockerrouteif`  
Docker VLAN name: `Dockervlan`
Dockervlan interface IP: `192.168.0.249`  
dockervlan routed IP range: `192.168.0.64/26`  
