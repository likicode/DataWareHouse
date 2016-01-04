def actor_num():
    out_file = open("/home/saliency/data_warehouse/actor_num",'a+')
    with open('complete_info') as f:
        lines = f.readlines()
    actor = []
    star = []
    for i in range(0,len(lines)):
        if (len(lines[i].split("\t"))==8):
            cont_actor = lines[i].split("\t")[5].split(",")
            cont_star = lines[i].split("\t")[4].split(",")
            for k in range(0,len(cont_actor)):
                actor.append(cont_actor[k])
            for k in range(0,len(cont_star)):
                star.append(cont_star[k])
    uni_actor = list(set(actor))
    uni_actor.sort()
    for i in range(0,len(uni_actor)):
        actnum = actor.count(uni_actor[i])
        starnum = star.count(uni_actor[i])
        out_file.write(uni_actor[i]+'\t'+str(actnum)+'\t'+str(starnum)+'\t')
        out_file.write('\n')
    out_file.close()

def director_num():
    out_file = open("/home/saliency/data_warehouse/director_num",'a+')
    with open('complete_info') as f:
        lines = f.readlines()

    director = []
    for i in range(0,len(lines)):
        if (len(lines[i].split("\t"))==8):
            cont_director = lines[i].split("\t")[3].split(",")
            for k in range(0,len(cont_director)):
                director.append(cont_director[k])

    uni_director = list(set(director))
    uni_director.sort()
    for i in range(0,len(uni_director)):
        directnum = director.count(uni_director[i])
        out_file.write(uni_director[i]+'\t'+str(directnum))
        out_file.write('\n')
    out_file.close()


def process_mname():
    with open('complete_info') as f:
        lines = f.readlines()
    for i in range(0,len(lines)):
        if (len(lines[i].split("\t"))==8):
            re.sub('\[(.*?)\]|\((.*?)\)','',lines[i].split("\t")[1])



def cleanfile():
    target = open("/home/saliency/data_warehouse/clean_complete_info",'a+')
    with open('complete_info') as f:
        lines = f.readlines()
    for i in range(0,len(lines)):
        lines[i] = re.sub('\[(.*?)\]|\((.*?)\)','',lines[i])
        target.write(lines[i])
    target.close()


def movie_name():
    target = open("/home/saliency/data_warehouse/movie",'a+')
    mm =[]
    with open('clean_complete_info') as f:
        lines = f.readlines()
    lines = [elem.strip('\n').split('\t') for elem in lines]
    for elem in lines:
        if (len(elem)==8):
            mm.append(elem[1])
    nn = set(mm)
    mm = list(nn)
    mm.sort()
    for i in range(0,len(mm)):
        target.write(mm[i]+'\n')
    target.close()
    return mm

def date():
    target = open("/home/saliency/data_warehouse/release_time",'a+')
    with open('complete_info') as f:
        lines = f.readlines()
    date = []
    for i in range(0,len(lines)):
        if (len(lines[i].split("\t"))==8):
            date.append(lines[i].split("\t")[7])
    date = list(set(date))
    date.sort()
    for i in range(0,len(date)):
        print date[i]
        if (date[i].strip('\n') == 'NULL_SHOWTIME'):
            year = "NULL"
            month = "NULL"
            day = "NULL"
            quarter = "NULL"
        else:
            year = date[i].strip('\n').split(',')[1].strip(' ')
            month = date[i].split(' ')[0]
            day = date[i].split(' ')[1].strip(',')
            if (month == 'January' or month == 'February' or month =='March'):
                quarter = "1"
            if (month == 'April' or month == 'May' or month =='June'):
                quarter = "2"
            if (month == 'July' or month == 'August' or month =='September'):
                quarter = '3'
            if (month == "October" or month == 'November' or month =='December'):
                quarter = '4'
        target.write(year+'\t'+month+'\t'+day+'\t'+quarter)
        target.write('\n')
    target.close()

