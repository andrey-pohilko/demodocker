

src_file = open('docker-compose.yml.source','r')

run_file = open('docker-compose.yml.run','w')
build_file = open('docker-compose.yml','w')

run_file.write("# DO NOT CHANGE THIS FILE! USE docker-compose.yml.source\n")
run_file.write("# and then run putcompose.py\n")

build_file.write("# DO NOT CHANGE THIS FILE! USE docker-compose.yml.source\n")               
build_file.write("# and then run putcompose.py\n")

for line in src_file:
    if line.split(':')[0].strip() == 'build':
        build_file.write(line)
    elif line.split(':')[0].strip() == 'command':
        build_file.write("#  {}".format(line))
        run_file.write(line)
    else:
        build_file.write(line)
        run_file.write(line)

build_file.close()
run_file.close()
src_file.close()
        
