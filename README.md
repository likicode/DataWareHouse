# Data Warehouse Course Project 
## The final project for Data Warehouse in 2015
### Projects Requirements
- Data Resource
http://snap.stanford.edu/data/web-Movies.html
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
- Step 1. 
  - Process Data on Amazon
    - write scrawl script with python and simple bash
      * get 230 thousand items on Amazon with three servers running multiple threads
    - clean data
      * done with help of http://www.crummy.com/software/BeautifulSoup/
      * get the data need to be stored from raw html
- Step 2.
  - design storing plan
    -the logical storing plan: ERD
    -the physical storing plan : database table design
- Step 3.
  - Build Hive clusters.
    -I bought three servers temporarily from https://www.digitalocean.com/ playing the role of namenode, edgenode and datanode.
    -Edgenode can keep watch on the performance of the cluster.
  
