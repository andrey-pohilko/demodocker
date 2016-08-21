# check more at https://docs.docker.com/registry/deploying/
docker run -d -p 5000:5000 --restart=always --name registry registry:2
docker tag pylibs-srv1 localhost:5000/pylibs-srv1
docker push localhost:5000/pylibs-srv1

docker tag pylibs-srv2 localhost:5000/pylibs-srv2
docker push localhost:5000/pylibs-srv2
