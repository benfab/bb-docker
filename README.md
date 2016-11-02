# bb-docker
Demo during the Brown Bag session about Docker

### Prerequisites

Docker engine and docker-machine installed

Account on DigitalOcean

## Steps to run the demo

### Clone the repo
`git clone https://github.com/benfab/bb-docker.git`

### Deploy the Swarm cluster
`./create-swarm.sh --driver digitalocean --digitalocean_token <token> --manager 3 --worker 5`

### Check the Swarm cluster

`docker-machine ls`

`eval "$(docker-machine env <node-name>)"`

`docker node ls`

`docker swarm join-token worker`

`docker swarm join-token manager`

### Revoke a node certificate
`docker-machine regenerate-certs <node-name>`

### Deploy dockercoins and check the status

`docker deploy dockercoins`

`docker service ls`

`docker stack ps dockercoins`


### Expose the port 8000

`docker service update dockercoins_webui --publish-add 8000:80`

### Scale-up the dockercoins service and see the hash speed increasing

`docker service scale dockercoins_worker=3`

### Check the network

`docker network ls`

### Deploy a new service called debug  

`docker service create --name  debug --network  dockercoins_default --mode global busybox sleep 1000000`

`docker ps`

`docker exec -it <container-id> sh`

### Resolve the dockercoins_worker service Virtual IP

`nslookup dockercoins_worker`

### Resolve the dockcoins_worker tasks IPs

`nslookup tasks.dockercoins_worker`

### Update the service dockercoins_worker with 2 tasks updates at a time and a delay of 10 seconds between the task updates

`docker service update dockercoins_worker --update-parallelism 2 --update-delay 10s --image benfab/dockercoins_worker:v0.1`

### Drain a node a check if the tasks have been rescheduled 

`docker node ps <node-name>`

`docker node update <node-name> --availability drain`

`docker service ps dockercoins_hasher`







