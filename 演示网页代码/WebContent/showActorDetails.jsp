<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, edu.tongji.anna.model.*, edu.tongji.anna.util.*,java.sql.*,java.io.File,java.io.FileWriter
,java.io.BufferedWriter,java.io.IOException"%>
<%!    public static final int PAGESIZE = 10;  //一页放10个
    	int pageCount;  
    	int curPage = 1;  
    	int size;
    	String actor_name;

 %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Result</title>
    <script src="/Test/js/jquery-2.1.1.min.js"></script>
    <link rel="stylesheet" href="/Test/css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/home.css">
    <script src="/Test/js/bootstrap.min.js"></script>
    <script src="/Test/js/highcharts.js"></script>
    <script src="/Test/js/exporting.js"></script>
</head>
<body>
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="navbar-header">
        <a class="navbar-brand" href="/Test/index.jsp">Amazon</a>
    </div>

    <div>
        <p class="navbar-text">Movies</p>
    </div>
</nav>
    <br>
    <br>
    <br>


<div class="panel panel-primary">
    <div class="panel-heading">
        <h3 class="panel-title"><b>Display</b></h3>
    </div>
    <div class="panel-body">
        <div class="panel panel-default">
            <!-- Default panel contents -->
            <div class="panel-heading">Results</div>
            <!-- Table -->
            <table class="table table-bordered">
                <thead>
                <tr class="warning">     
                    <th>Actor</th>
                    <th>Movie</th>
                </tr>
                </thead>
                <tbody>
            <%  
		    try{   
		        Connection conn = MySQLConnUtil.getConnection();   
		        actor_name = request.getParameter("actor_name");
		        String sql = "select actor.actor_name,movie.movie_name "+ 
		        		"from movie natural join act natural join actor " +
		        		"where actor.actor_name = "+"\""+actor_name+"\"";
		        System.out.println(sql);
		        Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql);
		        rs.last();  
		        size = rs.getRow();  
		        pageCount = (size%PAGESIZE==0)?(size/PAGESIZE):(size/PAGESIZE+1);  
		        String tmp = request.getParameter("curPage");  
		        if(tmp==null){  
		            tmp="1";  
		        }  
		        curPage = Integer.parseInt(tmp);  
		        if(curPage>=pageCount) curPage = pageCount;  
		        boolean flag = rs.absolute((curPage-1)*PAGESIZE+1);  
		        out.println("Page #"+curPage);  
		        int count = 0;  
		          
		       do{  
		           if(count>=PAGESIZE)break; 
		            String actor_name = rs.getString(1);
		            String movie_name = rs.getString(2);  
 
		            count++;  
		            %>  
		        <tr>  
		            <td><%=actor_name%></td>  
		            <td><a href = "/Test/showMovieDetails.jsp?movie_name=<%=movie_name%>"><%=movie_name%></a></td>  
		        </tr>  
		            <%  
		      }while(rs.next());  
		        conn.close();  
		    }  
		    catch(Exception e){  
		    	e.printStackTrace();
		    }  
			%>  
            </tbody>
            </table>
            <a href = "showActorDetails.jsp?actor_name=<%=actor_name %>&curPage=1" >Front</a>  
			<a href = "showActorDetails.jsp?actor_name=<%=actor_name %>&curPage=<%=curPage-1%>" >Last</a>  
			<a href = "showActorDetails.jsp?actor_name=<%=actor_name %>&curPage=<%=curPage+1%>" >Next</a>  
			<a href = "showActorDetails.jsp?actor_name=<%=actor_name %>&curPage=<%=pageCount%>" >End</a>  
			#<%=curPage%>/<%=pageCount%> 
        </div>
    </div>
</div>