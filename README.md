# demodocker
Simple docker with two apps in python and a shared module folder

Its main purpose is to show one way to share single module library between several applications in various dockers

install.sh устанавливает docker-engine и docker-compose
rmdocker.py удаляет все контейнеры и все образы, кроме docker-compose (да, docker-compose тоже выполняется из докера)

pylibs/ демо инсталляция на два приложения и одну общую библиотеку
pylibs/modules/ папка, где лежит общая библиотека (один файл и одна функция)

docker/Dockerfile - файл, в котором строится общий образ для всех модулей
docker/docker-compose.yml - файл, который строит оба приложения с нужными плюшками

docker/build.sh 
  копирует общие библиотеки в каждое приложение
  строит общий контейнер с нужным тэгом
  строит контейнеры для каждого приложения
  сохраняет образы финальных контейнеров и архивирует
  
docker/load.sh
  распаковывает докеры (в теории - на дистанционной машине)

