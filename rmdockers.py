#!/usr/bin/python

import subprocess
from subprocess import Popen

images_excludes = ['REPOSITORY', 'docker/compose', 'alpine']

def RemoveContainers():
  p1 = Popen(['docker','ps','-qa'], stdout=subprocess.PIPE)
  for line in p1.stdout:
    x = line[:12]  
    if x != "CONTAINER ID":
      Popen(['docker','rm',x])

def RemoveImages():
  p1 = Popen(['docker','images'], stdout=subprocess.PIPE)
  for line in p1.stdout:
    x = line.split()
    if x[0] not in images_excludes:
      print "To be removed: {} {}".format(x[0], x[2])
      Popen(['docker','rmi','-f', x[2]])

RemoveContainers()
RemoveImages()
