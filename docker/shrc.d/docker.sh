docker_cleanup() {
    docker ps -aq | xargs -r docker rm
    docker images -q | grep '^<none>' | awk '{print $3}' | xargs -r docker rmi
}

docker_cleanup_all() {
    docker ps -aq | xargs -r docker rm
    docker images -q | xargs -r docker rmi
}
