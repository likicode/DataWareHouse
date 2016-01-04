<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, edu.tongji.anna.model.*, edu.tongji.anna.util.*,java.sql.*,java.io.File,java.io.FileWriter
,java.io.BufferedWriter,java.io.IOException"%>
<%!    public static final int PAGESIZE = 10;  //一页放10个
    	int pageCount;  
    	int curPage = 1;  
    	int size;
    	long startTime;
    	long endTime;
    	long interval = 0;
    	List<String> actorName = new ArrayList<String>();
    	List<String> movieNum = new ArrayList<String>(); 
    	long hiveInterval = 0;

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
                    <th>MovieName</th>
                    <th>ProductId</th>
                    <th>Version</th>
       
                </tr>
                </thead>
                <tbody>
            <%  
		    try{   
		        Connection con = MySQLConnUtil.getConnection();  
		        String sql = (String)session.getAttribute("sql");  
		        //hiveInterval = (long)session.getAttribute("intervalTime");

		        PreparedStatement stat = con.prepareStatement(sql,ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_READ_ONLY);  
		        startTime = System.currentTimeMillis();
		        ResultSet rs = stat.executeQuery();  
		        endTime = System.currentTimeMillis();
		        interval = endTime-startTime;
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
		            String movie_name = rs.getString(1);  
		            String product_id = rs.getString(2);  
		            String version = rs.getString(3); 
		            count++;  
		            %>  
		        <tr>  
		            <td><a href = "/Test/showMovieDetails.jsp?movie_name=<%=movie_name%>"><%=movie_name%></a></td>  
		            <td><%=product_id%></td>  
		            <td><%=version%></td> 
		          
		         
		        </tr>  
		            <%  
		      }while(rs.next());  
		       
		        /*String sql1 = "select actor_name,act_num from actor order by act_num limit 0,10";
		        Statement stmt = con.createStatement();
		        ResultSet resultSet = stmt.executeQuery(sql1);
		    	while(resultSet.next()){
					actorName.add(resultSet.getString(1));
					movieNum.add(resultSet.getInt(1)+"");
				}*/
		        con.close();  
		    }  
		    catch(Exception e){  
		    	e.printStackTrace();
		    }  
			%>  
            </tbody>
            </table>
            <a href = "result.jsp?curPage=1" >Front</a>  
			<a href = "result.jsp?curPage=<%=curPage-1%>" >Last</a>  
			<a href = "result.jsp?curPage=<%=curPage+1%>" >Next</a>  
			<a href = "result.jsp?curPage=<%=pageCount%>" >End</a>  
			#<%=curPage%>/<%=pageCount%> 
        </div>
    </div>
</div>
<div class="row">
<div class="col-lg-6">
	<div class="row">
	    <div class="col-lg-4">
	    	<lanel class="form-control" name="timeoption">
	        	<option>Time</option>
	        </label>
	    </div>
	    <div class="col-lg-4">
	    	<lanel class="form-control" name="timeoption">
	        	<option name = "timeArea"> <%=interval%></option>
	        </label>
	   	</div>	
	</div>
<br>

<div class="row">
    <div class="col-lg-4">
    	<lanel class="form-control" name="timeoption">
        	<option>Num</option>
        </label>
    </div>
    <div class="col-lg-4">
    	<lanel class="form-control" name="timeoption">
        	<option > <%=size %></option>
        </label>
    </div>
</div>
</div>

<div class="col-lg-6">
<div class="row">
    <div class="col-lg-4">
    	<lanel class="form-control" name="timeoption">
        	<option>Time</option>
        </label>
    </div>
    <div class="col-lg-4">
    	<lanel class="form-control" name="timeoption">
        	<option ><%=hiveInterval %></option>
        </label>
    </div>
</div>

<br>

<div class="row">

</div>
</div>
</div>
<br>
<div class="row">
    <div class="col-lg-6">
<div id="container1" style="width:450px;height:400px "></div>
    </div>
        <div class="col-lg-6">
<div id="container2" style="width:450px;height:400px "></div>
    </div>
</div>
</body>
<script>
$(function () { 
	var interval = <%=interval%>;
	var hiveInterval = <%=hiveInterval%>;
	var data1 = [];
	data1.push(interval);
	var data2 = [];
	data2.push(hiveInterval);
	console.log(interval);
    $('#container1').highcharts({                   //图表展示容器，与div的id保持一致
        chart: {
            type: 'column'                         //指定图表的类型，默认是折线图（line）
        },
        title: {
            text: 'Time comparison'      //指定图表标题
        },
        xAxis: {
            categories: ['']   //指定x轴分组
        },
        yAxis: {
            title: {
                text: 'Time(ms)'                  //指定y轴的标题
            }
        },
        series: [{                                 //指定数据列
            name: 'MySQL',                          //数据列名
            data: data1                       //数据
        }, {
            name: 'Hive',
            data: data2
        }]
    });
});
$(function () {
	var interval = <%=interval%>;
	var hiveInterval = <%=hiveInterval%>;
    $('#container2').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: 'Time Comparison'
        },
        tooltip: {
    	    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    color: '#000000',
                    connectorColor: '#000000',
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                }
            }
        },
        series: [{
            type: 'pie',
            name: 'Time Share',
            data: [
                   ['MySQL',interval],
                   ['Hive',hiveInterval]
            ]
        }]
    });
});				

</script>
</html>

