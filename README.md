# a quick example of running a habitat package outside of a container using a chef recipe.

# security groups
Habitat utilizes a running supervisor that is used for the gossip ring as well as a zeromq message bus, there is also a restful endpoint for asking questions to the supervisor.

The following rules should be configured beforehand.

* udp 9638 in/eg
* tcp 9638 in/eg
* tcp 9631 in/eg

these are defaults but could be changed by modifying the hab_sup resource to bind to a specific port for gossip/http

# how-to

1. modify the .kitchen.yml to point to your security group/subnet/region/aws key
2. `kitchen converge`
3. `kitchen login node-1`
4. `curl localhost:9631/services/redis/default | jq`
5. `journalctl -u hab-sup-default -f`
6. `kitchen destroy node-3`

# variations of this
* you could also have the chef server acting as a habitat supervisor and predictable peer endpoint, then you'd just modify the hab_sup resource to use `peer Chef::Config[:chef_server_url]`


