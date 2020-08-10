# docker-compose-macvlan
Docker-compose example using macvlan driver.    

This docker-compose file creates a network using macvlan driver and deploys portainer container using the same newly created network.
This gives you the ability to deploy containers with static IP address which is different from the host IP address and all of it without DHCP reservations (Ensure IP address is not used though).
You can reach container with that IP address however you can not reach it from the host machine itself.
For that to work - one needs to add another interface and route the containers used IP address (or range) trough new interface.

## Enable host to container networking

Add new interface (Interface name is dockervlan, and eth0 is host interface):

`ip link add dockervlan link eth0 type macvlan mode bridge`

Then add an IP address to that interface (Interface should have an IP address, I used 192.168.0.249):

`ip addr add 192.168.0.249/32 dev dockervlan`

Bring up that interface:

`ip link set dockervlan up`

And finally define a range which should be routed trough that iterface:

`ip route add 192.168.0.64/26 dev dockervlan`

This is enough to make it work. Portainer now should be accessible from the host machine and all other machines within the same subnet/network.
