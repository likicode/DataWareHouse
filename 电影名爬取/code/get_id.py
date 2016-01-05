import os
import sys
import getopt
opts, args = getopt.getopt(sys.argv[1:], "hi:")
 
for op, value in opts:
	if op == '-h':
		print  'Usage: python [script name] [action] [targets]'
		print  '-i','\t','path to movie.txt','\t','\t','example:/tmp/movie.txt'
		sys.exit()
	elif op == '-i':
		path = value



files = open(path)
output = open(str(os.getcwd())+'/list','a+')
id_info = []
for line in files:
    status = line.find('product/productId')
    if status == 0:
        id_info.append(line[line.find(' ')+1:len(line)])
sums = set(id_info)
print 'The total number of id is',len(sums)
id_sum = list(sums)
for i in range(len(id_sum)):
    output.write(id_sum[i])
output.close()
os.system('scp -r '+str(os.getcwd())+' root@dirichlet.space:~/')
os.system('ssh root@dirichlet.space')
