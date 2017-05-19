docker_cleanup() {
    docker ps -a | tail -n +2 | awk '{print $1}' | xargs -r docker rm
    docker images | tail -n +2 | grep '^<none>' | awk '{print $3}' | xargs -r docker rmi
}
