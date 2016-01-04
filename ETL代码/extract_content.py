#from BeautifulSoup import BeautifulSoup
from bs4 import BeautifulSoup
import re
import sys
import os
reload(sys)
sys.setdefaultencoding('utf-8')

def extract(dirname):
        processed_content = []
        with open("/home/liki/old/warehouse/complete_info") as f:
            lines = f.readlines()
        for i in range(0,len(lines)):
            processed_content.append(lines[i].split('\t')[0])
    	f.close()
        os.chdir(dirname)	
#	target = open("/home/liki/old/warehouse/complete_info",'a+')
#	html = BeautifulSoup(open(filename))
	for filename in os.listdir("."):
		print filename
                if filename in processed_content:
                    continue;
                else:
                    html = BeautifulSoup(open(filename))
                    target = open("/home/liki/old/warehouse/complete_info",'a+')
                    if len(html.find_all(attrs={"class": "dv-meta-info size-small"}))!=0:
                    #tabular html page
                            table = html.find("table")
                            row = table.findAll('tr')
                            #movie_name
                            movie_name = html.h1.contents[0].strip()
                            #Starring info
                            #	if html.find_all(attrs={"class": "dv-meta-info size-small"})[0].dt.string == "Starring:" :
                            #	starring = html.find_all(attrs={"class": "dv-meta-info size-small"})[0].dd.string.strip()
                            #else:
                            #	starring = "NULL_STARRING"
                            #include format/genre/releasetime
                            header = []
                            content = []
                            for chld in row:
                                    header.extend(chld.findAll('th'))
                                    content.extend(chld.findAll('td'))
                            for i in range(0,len(header)):
                                    header[i] = (''.join(x for x in (header[i].findAll(text = True)))).split(',')
                                    content[i] = (''.join(x for x in (content[i].findAll(text = True)))).split(',')
                                    for k in range(len(header[i])):
                                            header[i][k] = (header[i][k].strip('\n')).strip()
                                    for k in range(len(content[i])):
                                            content[i][k]  = (re.sub(r'\n','',content[i][k].strip('\n'))).strip()
                            tmp=[]
                            for elem in header:
                                    tmp.append(elem[0])
                            header = tmp

                            if ("Genres" in header):
                                    i = header.index("Genres")
                                    genres = ','.join(content[i])
                            else:
                                    genres = "NULL_GENRE"
                            if ("Director" in header):
                                    i = header.index("Director")
                                    director = ','.join(content[i])
                            else:
                                    director = "NULL_DIRECTOR"
                            if ("Starring" in header):
                                    i = header.index("Starring")
                                    starring = ','.join(content[i])
                            else:
                                    starring = "NULL_STARRING"
                            if ("Supporting actors" in header):
                                    i = header.index("Supporting actors")
                                    actor = ','.join(content[i])
                            else:
                                    actor = "NULL_actor"
                            if ("Format" in header):
                                    i = header.index("Format")
                                    movie_format = ','.join(content[i])
                            else:
                                    movie_format = "NULL_FORMAT"
                            if ("time" in header):
                                    time = ','.join(content[i])
                            else:
                                    time = "NULL_SHOWTIME"
            #	target.write(filename+'\t'+movie_name+'\t'+genres+'\t'+director+'\t'+starring+'\t'+actor+'\t'+movie_format+'\t'+time)
            #        target.write('\n')
            #	target.close()
            #	return header,content	
                    else:
                    ##normal kind of page
                            #movie name 
                            if len(html.div(id = "titleSection")) > 0:
                                    movie_name = html.div(id = "titleSection")[0].find(id = "productTitle").string
                                    #Format Info
                                    if len(html.div(id = "byline")) > 0 :
                                            index = len(html.div(id = "byline")[0].find_all("span"))-1
                                            if index > 0:
                                                    movie_format = html.div(id = "byline")[0].find_all("span")[index].string or u""
                                                    #lead actor
                                                    if len(html.div(id = "byline")[0].find_all("span")[0]("span")) > 0:
                                                            if ("Actor" in  html.div(id = "byline")[0].find_all("span")[0]("span")[1].string):
                                                                    starring = html.div(id = "byline")[0].find_all("span")[0].a.string or u"NULL_STARRING"
                                                            else:
                                                                    starring = "NULL_STARRING"
                                                    else:
                                                            starring = "NULL_STARRING"
                                            else:
                                                    movie_format = "NULL_FORMAT"
                                                    starring = "NULL_STARRING"
                                    else:
                                            movie_format = "NULL_FORMAT"
                                            starring = "NULL_STARRING"
                            else:        #other info
                                    movie_name = "NULL_MOVIENAMW"
                                    movie_format = "NULL_FORMAT"
                                    starring = "NULL_STARRING"
                            if html.find("div",{"id":"detail-bullets"}) != None:
                                    tag = html.find("div",{"id":"detail-bullets"}).findAll('li')
                                    header = []
                                    for elem in tag:
                                            header.append(elem.b.string)
                                    
                                    if "Actors:" in header:
                                            i = header.index("Actors:")
                                            tmp_1=tag[i].find_all("a")
                                            tmp = [elem.string for elem in tmp_1]
                                            actor = ",".join(tmp) or u"NULL_actor"
                                    else:
                                            actor = "NULL_actor"
                                    if "Directors:" in header:
                                            i = header.index("Directors:")
                                            tmp_1=tag[i].find_all("a")
                                            tmp = [elem.string for elem in tmp_1]
                                            if tmp != [None]:
                                                director = ",".join(tmp)
                                            else:
                                                director = "NULL_DIRECTOR"
                                    else:
                                            director = "NULL_DIRECTOR"
                                            #	for x in tag[i].find_all("a"):
                                            #		director = director + x.string + ","
                                    #tag[i].a.string 
                                    if ("DVD Release Date:" in header) or ("VHS Release Date:" in header):
                                            if ("DVD Release Date:" in header):
                                                i = header.index("DVD Release Date:")
                                            else:
                                                i = header.index("VHS Release Date:")
                                            tmp_1=str(tag[i])
                                            mm=re.compile('>(.*?)<',re.S)
                                            tmp = mm.findall(tmp_1)
                                            time = (tmp[len(tmp)-1]).strip() or u"NULL_SHOWTIME"
                                    else:
                                            time = "NULL_SHOWTIME"
                                    #if "VHS Release Date:" in header:
                                     #       i = header.index("VHS Release Date:")
                                      #      tmp_1=str(tag[i])
                                       #     mm=re.compile('>(.*?)<',re.S)
                                        #    tmp = mm.findall(tmp_1)
                                         #   time = (tmp[len(tmp)-1]).strip() or u"NULL_SHOWTIME"
                                    #else:
                                    #        time = "NULL_SHOWTIME"
                            else:
                                    actor = "NULL_actor"
                                    director = "NULL_DIRECTOR"
                                    time = "NULL_SHOWTIME"
                            #else:
                            #        movie_name = "NULL_MOVIENAMW"
                            #        movie_format = "NULL_FORMAT"
                            #        actor = "NULL_actor"
                            #        director = "NULL_DIRECTOR"
                            #        time = "NULL_SHOWTIME"
                            #        starring = "NULL_STARRING"
                            #        time = "NULL_SHOWTIME"
                            genres = "NULL_GENRE"
                    target.write(filename+'\t'+movie_name+'\t'+genres+'\t'+director+'\t'+starring+'\t'+actor+'\t'+movie_format+'\t'+time)
                    target.write('\n')
		target.close()

def main():
	extract("/home/liki/old/warehouse/amazon_data/data")
       # extract("/home/liki/old/warehouse/test")
if __name__ == "__main__":
	main()	
