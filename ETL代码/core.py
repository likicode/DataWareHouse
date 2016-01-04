import sys
import os
import threading
import subprocess
import time
import MySQLdb
from random import choice
import numpy as np
database_name = 'amazon'
count_200 = 0
count_503 = 0
task_start_time = time.time()
def NameList(path):
	files = open(path)
	namelist_raw = files.readlines()
	files.close()
	namelist = []
	for i in range(len(namelist_raw)):
		namelist.append(namelist_raw[i].strip('\n'))
	return namelist



def curl_page(movie):
	cur_path = os.getcwd()
	for i in range(len(movie)):
		curl_str1 = '/bin/bash '+ str(cur_path) + '/crawler.sh '+ str(movie[i])+' 127.0.0.1:1080'
		curl_str2 = '/bin/bash '+ str(cur_path) + '/crawler.sh '+ str(movie[i])+' 127.0.0.1:1081'
                curl_str3 = '/bin/bash '+ str(cur_path) + '/crawler.sh '+ str(movie[i])+' 127.0.0.1:1082'
		curl_str4 = '/bin/bash '+ str(cur_path) + '/crawler.sh '+ str(movie[i])+' empty'
		curl_str = choice([curl_str1,curl_str2,curl_str3,curl_str4])
		resp = subprocess.Popen([curl_str],shell = True,stdout = subprocess.PIPE)
		screen = resp.stdout.read()
		execute_crawler(movie[i], screen,0)


def build_db():
	try:
		conn=MySQLdb.connect(host='localhost',user='root',passwd='root',port=3306)
		cur = conn.cursor()
		cur.execute('create database if not exists '+database_name)
		conn.select_db(database_name)
		cur.execute('create table movie_name(id varchar(50),info varchar(100))')
		cur.execute('create table 503_err(id varchar(50),err_info varchar(50))')
		cur.execute('create table 404_err(id varchar(50),err_info varchar(50))')
		conn.commit()
		cur.close()
		conn.close()
	except MySQLdb.Error,e:
		print "Mysql Error %d: %s" % (e.args[0], e.args[1])


def execute_db(table_name,values):
	try:
		conn=MySQLdb.connect(host='localhost',user='root',passwd='root',db=database_name,port=3306)
		cur = conn.cursor()
		str = 'insert into '+table_name+' values(%s,%s)'
		cur.execute(str,values)
		conn.commit()
		cur.close()
		conn.close()
	except MySQLdb.Error,e:
        	print "Mysql Error %d: %s" % (e.args[0], e.args[1])

def res_db():
	try:
		conn=MySQLdb.connect(host='localhost',user='root',passwd='root',db=database_name,port=3306)
		cur =conn.cursor()
		cur.execute('select count(distinct info) from movie_name')
		cnt = cur.fetchone()
		conn.commit()
		cur.close()
		conn.close()
		print "===================================================================================================="
		print "There are ",cnt[0]," diffent movies in total! You can view more details in the database"
		print "MySQL user: root passwd: root"
		print "All the movie related data are stored in DATABASE amazon."
		print "TABLE movie_name stores all the name. TABLE 404_err and 503_err restore few invaild id."
		print "===================================================================================================="
	except MySQLdb.Error,e:
		print "Error counting"
		 

def execute_crawler(movie_id,screen,cnt):
	global count_200,count_503,task_start_time
	if screen.find('HTTP/1.1 301 MovedPermanently')!= -1:
		count_200 = count_200+1
		start = screen.find('Location: http://www.amazon.com/')+len('Location: http://www.amazon.com/')
		end = screen.find('/dp/')
		movie_name = screen[start:end]
		execute_db('movie_name',[str(movie_id),movie_name])
	elif screen.find('HTTP/1.1 404 ')!=-1:
		execute_db('404_err',[str(movie_id),'404'])
#	elif screen.find('HTTP/1.1 503 ')!=-1:
	else:
		count_503 = count_503+1
		execute_db('503_err',[str(movie_id),'503'])
	current_time = time.time()
	strs = 'Downloaded: '+str(count_200)+'  spend time:  '+str(current_time-task_start_time)+'\r'
	if(count_200%100==0):
		sys.stdout.write(strs)
		sys.stdout.flush()


def remain_page():
	conn=MySQLdb.connect(host='localhost',user='root',passwd='root',db=database_name,port=3306)
	cur = conn.cursor()
	count=cur.execute('select id from 503_err')
	res_list = []
	for i in range(count):
		res = cur.fetchone()
		res_list.append(res[0])
	cur.execute('truncate table 503_err')
	conn.commit()
	cur.close()
	conn.close()
	return res_list

def parallel(namelist):
	threadpool=[]
	parallel = 140
	small_part = np.array_split(namelist,parallel)
	for i in xrange(parallel):
		k = small_part[i]
		th = threading.Thread(target= curl_page,args= (k,))
		threadpool.append(th)

	
	for th in threadpool:
		th.start()

	for th in threadpool :
		threading.Thread.join( th )


def main():
	build_db()

	nameList = NameList(str(os.getcwd())+'/list')
	parallel(nameList)
	res_list = remain_page()
	while len(res_list)<10:
		parallel(res_list)
		res_list = remain_page()
	res_db()


if __name__ == "__main__":
    main()
