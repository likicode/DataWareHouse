# Data Warehouse Course Project 
## The final project for Data Warehouse in 2015
### Projects Requirements
- Data Resource
  - http://snap.stanford.edu/data/web-Movies.html
- Data needs to be stored
  - movie ID
  - comment user's ID
  - comment user's Profilename
  - comment user's Helpfulness
  - comment score for each user
  - comment time
  - comment summary
  - comment text
  - movie actors
  - movie show time
  - movie genre
  - movie director
  - movie starring actors 
  - movie version
- Most frequent Research
  - Check for time
    * the number of ovies in XX year, xx month, xx season
    * how much new movies have been shown on Tuesday
  - check by movie name
    * how much versions a movie may possess
  - check by directors/ actors/ genres
  - combines research

### The project implementation Process
##### Step 1. 
  - Process Data on Amazon
    - write scrawl script with python and simple bash
      * get 230 thousand items on Amazon with three servers running multiple threads at one night. 
    - clean data
      * done with help of http://www.crummy.com/software/BeautifulSoup/
      * get the data need to be stored from raw html


##### Step 2.
  - <b>design storing plan</b>
    - the logical storing plan: ERD
    - the physical storing plan : database table design
    

  - <b>Build Hive clusters</b>
    - I bought <b>three servers</b> temporarily from https://www.digitalocean.com/ playing the role of namenode, edgenode and datanode.
      Their configuration informations are as follows:

      ![alt tag](https://github.com/likicode/datawarehouse_course_proj/blob/master/set1.png)
      
      ![alt tag](https://github.com/likicode/datawarehouse_course_proj/blob/master/set2.png)
      
      ![alt tag](https://github.com/likicode/datawarehouse_course_proj/blob/master/set3.png)
      
    - Edgenode can keep watch on the performance of the cluster.
      ![alt tag](https://github.com/likicode/datawarehouse_course_proj/blob/master/monitor.png)
      
    - We need to compare the time consumed by Mysql and HDFS for one complex search.
    
    
##### Step 3.

  - Research by multiple conditions and add condition automatically
  
    ![alt tag](https://github.com/likicode/datawarehouse_course_proj/blob/master/show.png)

  - For example, search for the thrillers in season 1,2015
   
    ![alt tag](https://github.com/likicode/datawarehouse_course_proj/blob/master/show2.png)

  - The result showing in table

    ![alt tag](https://github.com/likicode/datawarehouse_course_proj/blob/master/result1.png)
    
    
  - You can click on any item to have a further search
   
    ![alt tag](https://github.com/likicode/datawarehouse_course_proj/blob/master/result2.png)

  - displayed time consumed comparation between  mysql and HDFS in histogram and pie charts.
   
    ![alt tag](https://github.com/likicode/datawarehouse_course_proj/blob/master/result3.png)


### Development Tools
  - platform : Mac OSX
  - ETL Tool : http://www.pentaho.com/
  - Hive : three servers from  https://www.digitalocean.com/  
           Thanks for https://www.digitalocean.com/community/tutorials/how-to-install-hadoop-on-ubuntu-13-10 and stackoverflow tips!
  - Mysql : configure one on one of the server

### Conclusions
  - skills about scrawling loads of data online
  - ETL skills
  - build Hive clusters
  - display research result, maybe with https://www.joomla.org/


  
