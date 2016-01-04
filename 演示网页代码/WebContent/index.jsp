<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Amazon movies</title>
    <script src="/Test/js/jquery-2.1.1.min.js"></script>
    <link rel="stylesheet" href="/Test/css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/home.css">
    <script src="/Test/js/bootstrap.min.js"></script>
    <script src="./js/my.js"></script>
</head>
<script>
    var clickNum;
    $(document).ready(function(){
        clickNum = 0;
        $("#searchitem2").hide();
        $("#searchitem3").hide();
        $("#searchitem4").hide();
    })
    function add(){
        clickNum = clickNum+1;
        if(clickNum==1){
            $("#searchitem2").show();
        }else if(clickNum==2){
            $("#searchitem3").show();
        }else if(clickNum==3){
            $("#searchitem4").show();
        }
    }
</script>
<body style="background-image: url(./image/bgpic.jpg); background-repeat:no-repeat;">
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="navbar-header">
        <a class="navbar-brand" href="/Test/index.jsp">Amazon</a>
    </div>
    <div>
        <p class="navbar-text">Movies</p>
    </div>
</nav>
<!--<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">搜索条件</h3>
    </div>
    <div class="panel-body"><!-->
        <div style="padding: 100px 100px 10px;">
            <form class="bs-example bs-example-form" role="form" id="searchForm" action="/Test/SearchServlet" method = "post">
                <div class="row">
                    <div class="col-lg-2">
                        <lanel class="form-control" name="timeoption">
                            <option>Time</option>
                        </label>
                    </div>
                    <div class="col-lg-2">
                        <div class="input-group">
                             <span class="input-group-addon">
                                  <label>Year</label>
                             </span>
                            <input type="text" name = "year" class="form-control">
                        </div><!-- /input-group -->
                    </div>
                    <div class="col-lg-2">
                        <div class="input-group">
                             <span class="input-group-addon">
                                  <label>Month</label>
                             </span>
                            <input type="text" name = "month" class="form-control">
                        </div><!-- /input-group -->
                    </div>
                    <div class="col-lg-2">
                        <div class="input-group">
                             <span class="input-group-addon">
                                  <label>Day</label>
                             </span>
                            <input type="text" name = "day" class="form-control">
                        </div><!-- /input-group -->
                    </div>
                    <div class="col-lg-2">
                        <div class="input-group">
                             <span class="input-group-addon">
                                  <label>Quarter</label>
                             </span>
                            <input type="text" name = "quarter" class="form-control">
                        </div><!-- /input-group -->
                    </div>
                    <div class="col-lg-2">
                        <button type="submit" class="btn btn-primary">
                            	Search
                        </button>
                    </div>

                </div><!-- /.row -->
				<br>   
				<br>            
                <div class="row">
                    <div class="col-lg-2">
                        <select name = "select1" class="form-control">
                            <option>MovieName</option>
                            <option>Director</option>
                            <option>Genre</option>
                            <option>Actor</option>
                        </select>
                    </div>
                    <div class="col-lg-4">
                        <div class="input-group">
                             <span class="input-group-addon">
                                  <input name = "check" type="checkbox">
                             </span>
                            <input type="text" name = "attribute1" class="form-control">
                        </div><!-- /input-group -->
                    </div>
                    <div class="col-lg-2">
                    </div>
                     <div class="col-lg-2">
                    </div>
                    <div class="col-lg-2">
                        <button type="button" class="btn btn-primary" id = "addCondition"onclick="add()">
                          	 Add Condition
                        </button>
                    </div>
                </div><!-- /.row -->
                <br>
                <br>
                <div id = "searchitem2" class="row">
                    <div class="col-lg-2">
                        <select name = "select2" class="form-control">
                            <option>MovieName</option>
                            <option>Director</option>
                            <option>Genre</option>
                            <option>Actor</option>
                        </select>
                    </div>
                    <div class="col-lg-4">
                        <div class="input-group">
                             <span class="input-group-addon">
                                  <input name = "check" type="checkbox">
                             </span>
                            <input type="text" name = "attribute2" class="form-control">
                        </div><!-- /input-group -->
                    </div>

                </div><!-- /.row -->
                <br>
                <br>
                <div id = "searchitem3" class="row">
                    <div class="col-lg-2">
                        <select name = "select3" class="form-control">
                            <option>MovieName</option>
                            <option>Director</option>
                            <option>Genre</option>
                            <option>Actor</option>
                        </select>
                    </div>
                    <div class="col-lg-4">
                        <div class="input-group">
                             <span class="input-group-addon">
                                  <input name = "check" type="checkbox">
                             </span>
                            <input type="text" name = "attribute3" class="form-control">
                        </div><!-- /input-group -->
                    </div>

                </div><!-- /.row -->
                <br>
                <br>
                <div id = "searchitem4" class="row">
                    <div class="col-lg-2">
                        <select name = "select4" class="form-control">
                            <option>MovieName</option>
                            <option>Director</option>
                            <option>Genre</option>
                            <option>Actor</option>
                        </select>
                    </div>
                    <div class="col-lg-4">
                        <div class="input-group">
                             <span class="input-group-addon">
                                  <input name = "check" type="checkbox">
                             </span>
                            <input type="text" name = "attribute4" class="form-control">
                        </div><!-- /input-group -->
                    </div>

                </div><!-- /.row -->
            </form>
        </div>
<!--</div>-->
<!--</div>-->
</body>
</html>