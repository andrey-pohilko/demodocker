# demodocker
Simple docker with two apps in python and a shared module folder

Its main purpose is to show one way to share single module library between several applications in various dockers

install.sh ������������� docker-engine � docker-compose
rmdocker.py ������� ��� ���������� � ��� ������, ����� docker-compose (��, docker-compose ���� ����������� �� ������)

pylibs/ ���� ����������� �� ��� ���������� � ���� ����� ����������
pylibs/modules/ �����, ��� ����� ����� ���������� (���� ���� � ���� �������)

docker/Dockerfile - ����, � ������� �������� ����� ����� ��� ���� �������
docker/docker-compose.yml - ����, ������� ������ ��� ���������� � ������� ��������

docker/build.sh 
  �������� ����� ���������� � ������ ����������
  ������ ����� ��������� � ������ �����
  ������ ���������� ��� ������� ����������
  ��������� ������ ��������� ����������� � ����������
  
docker/load.sh
  ������������� ������ (� ������ - �� ������������� ������)

