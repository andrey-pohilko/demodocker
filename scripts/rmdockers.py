#!/usr/bin/python

import subprocess
from subprocess import Popen
images_excludes = ['REPOSITORY', 'docker/compose']

p1 = Popen(['docker','ps','-q','--filter=status=exited','--filter=status=created'], stdout=subprocess.PIPE)
for line in p1.stdout:
  x = line[:12]  
  if x != "CONTAINER ID":
    Popen(['docker','rm',x])

p1 = Popen(['docker','images','-a','--filter=dangling=true'], stdout=subprocess.PIPE)
for line in p1.stdout:
  x = line.split()
  if x[0] not in images_excludes:
    print "To be removed: {} {}".format(x[0], x[2])
    Popen(['docker','rmi','-f', x[2]])
