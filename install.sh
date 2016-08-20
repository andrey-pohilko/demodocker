set -e
export DOCKER_USERNAME=andrey

function echo_message {
  echo 
  echo '==========================================='
  echo '[$date]: $1'
  echo 
}

echo_message preparing for installation 

apt-get update
apt-get -y install apt-transport-https ca-certificates
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo deb https://apt.dockerproject.org/repo ubuntu-xenial main > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get purge lxc-docker
apt-cache policy docker-engine

echo_message adding $DOCKER_USERNAME to docker group. Logout and login to apply changes
sudo usermod -aG docker $DOCKER_USERNAME

echo_message installing docker-engine
apt-get -y install linux-image-extra-$(uname -r) linux-image-extra-virtual
apt-get -y install docker-engine
service docker start
docker run hello-world

echo_message installing docker-compose
curl -L https://github.com/docker/compose/releases/download/1.8.0/run.sh > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose version
