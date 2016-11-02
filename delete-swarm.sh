#!/bin/bash
# Function to delete a swarm cluster

function delete {
  echo "*** stating deletion ***"
  while read line; do docker-machine rm -f $line; done < <(docker-machine ls -q)
#  docker-machine ls -q | xargs docker-machine rm -f
  echo "*** cluster deleted ***"
}

function main {
   delete
}
main
