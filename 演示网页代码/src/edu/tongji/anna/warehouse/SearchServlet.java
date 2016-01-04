package edu.tongji.anna.warehouse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import edu.tongji.anna.model.MovieResult;
import edu.tongji.anna.util.HiveConnUtil;
import edu.tongji.anna.util.MySQLConnUtil;

/**
 * Servlet implementation class SearchServlet
 */
@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private long startTime;
	private long endTime;
	private long intervalTime;
	ResultSet rs;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
	private String generateSQL(List<String> option,List<String> attr,List<String> time){
		String sql = "select movie.movie_name, product.product_id,product.version from movie natural join product";
		List<String> tableName = new ArrayList<String>();
		for(int i=0;i<option.size();i++){
			switch (option.get(i)){
			case "MovieName":
				tableName.add("");
				break;
			case "Director":
				tableName.add(" natural join direct natural join director");
//				tableName.add("");
				break;
			case "Genre":
				tableName.add(" natural join movie_genre");
//				tableName.add("");
				break;
			case "Actor":
				tableName.add(" natural join act natural join actor");
//				tableName.add("");
				break;
				default:
					break;
			}
		}
		for (int i=0;i<attr.size();i++){
			if(attr.get(i).length()!=0){
				sql = sql + tableName.get(i);
			}
		}
		for(int i=0;i<time.size();i++){
			if(time.get(i).length()!=0){
				sql = sql + " natural join releasetime";
				break;
			}
		}

		int conditionNum = 0;
		sql = sql + " where";
		for (int i=0;i<attr.size();i++){
			
			if(attr.get(i).length()!=0){
				conditionNum = conditionNum+1;
				switch (option.get(i)){
				case "MovieName":
				{
					if(conditionNum==1)
						sql = sql + " movie_name = " + "\""+ attr.get(i) + "\"";
					else
						sql = sql + " and movie_name = " + "\"" + attr.get(i)+ "\"";
					break;
				}
				case "Director":
				{
					if(conditionNum==1)
						sql = sql + " director_name = " + "\"" + attr.get(i) + "\"";
					else
						sql = sql + " and director_name = " + "\"" + attr.get(i) + "\"";
					break;
				}
				case "Genre":
				{
					if(conditionNum==1)
						sql = sql + " genre = " + "\"" + attr.get(i) + "\"";
					else 
						sql = sql + " and genre = " + "\"" + attr.get(i) + "\"";
					break;
				}
				case "Actor":
				{
					if(conditionNum==1){
						sql = sql + " actor_name = " + "\"" + attr.get(i) + "\"";
						//if(check.get(i))
							//sql = sql + " and isstaring= " + "\"" + "1" + "\"";
					}	
					else{
						sql = sql + " and actor_name = " + "\"" + attr.get(i) + "\"";
//						if(check.get(i).equals("On"))
//							sql = sql + " and isstaring= " + "\"" + "1" + "\"";
		
					}
						
					break;
				}
					default:
						break;
				}
			}
		}
		
		for(int i=0;i<time.size();i++){
			if(time.get(i).length()!=0){
				conditionNum++;
				if(i==0){
					if(conditionNum==1)
						sql = sql + " year = " + "\"" + time.get(i) + "\"";
					else
						sql = sql + " and year = " + "\"" + time.get(i) + "\"";
				}else if(i==1){
					if(conditionNum==1)
						sql = sql + " month = " + "\"" + time.get(i) + "\"";
					else
						sql = sql + " and month = " + "\"" + time.get(i) + "\"";
				}else if(i==2){
					if(conditionNum==1)
						sql = sql + " day = " + "\"" + time.get(i) + "\"";
					else
						sql = sql + " and day = " + "\"" + time.get(i) + "\"";
				}else if(i==3){
					if(conditionNum==1)
						sql = sql + " quarter = " + "\"" + time.get(i) + "\"";
					else
						sql = sql + " and quarter = " + "\"" + time.get(i) + "\"";
				}
			}
		}
		

		System.out.println(sql);
		return sql;
	}
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		String year = new String(request.getParameter("year").getBytes("ISO-8859-1"),"utf-8");
		String month = new String(request.getParameter("month").getBytes("ISO-8859-1"),"utf-8");
		String day = new String(request.getParameter("day").getBytes("ISO-8859-1"),"utf-8");
		String quarter = new String(request.getParameter("quarter").getBytes("ISO-8859-1"),"utf-8");
		List<String> time = new ArrayList<String>();
		time.add(year);
		time.add(month);
		time.add(day);
		time.add(quarter);
		String attribute1 = new String(request.getParameter("attribute1").getBytes("ISO-8859-1"),"utf-8");
		String attribute2 = new String(request.getParameter("attribute2").getBytes("ISO-8859-1"),"utf-8");
		String attribute3 = new String(request.getParameter("attribute3").getBytes("ISO-8859-1"),"utf-8");
		String attribute4 = new String(request.getParameter("attribute4").getBytes("ISO-8859-1"),"utf-8");

		String option1 = new String(request.getParameter("select1").getBytes("ISO-8859-1"),"utf-8");
		String option2 = new String(request.getParameter("select2").getBytes("ISO-8859-1"),"utf-8");
		String option3 = new String(request.getParameter("select3").getBytes("ISO-8859-1"),"utf-8");
		String option4 = new String(request.getParameter("select4").getBytes("ISO-8859-1"),"utf-8");
		
//		String check1 = request.getParameter("check1");
//		String check2 = request.getParameter("check2");
//		String check3 = request.getParameter("check3");
//		String check4 = request.getParameter("check4");
		/*if(select1.equals("µçÓ°Ãû"))
			System.out.println(select1);
		System.out.println(select2);
		System.out.println(select3);
		System.out.println(select4);
		System.out.println(attribute1);*/
		List<String> option = new ArrayList<String>();
		List<String> attr = new ArrayList<String>();
		List<String> check = new ArrayList<String>();
		
		option.add(option1);
		option.add(option2);
		option.add(option3);
		option.add(option4);
		
		attr.add(attribute1);
		attr.add(attribute2);
		attr.add(attribute3);
		attr.add(attribute4);
		/*
		check.add(check1);
		check.add(check2);
		check.add(check3);
		check.add(check4);
		*/
		for(int i=0;i<option.size();i++){
			System.out.println(option.get(i));
		}
		for(int i=0;i<attr.size();i++){
			System.out.println(attr.get(i));
		}
		
		
		String sql = generateSQL(option,attr,time);
//		String sql = "select* from employee";
		/*List<MovieResult> movieList = new ArrayList();
		Connection conn = HiveConnUtil.getConnection();
		try {
			Statement stmt = conn.createStatement();
			startTime = System.currentTimeMillis();
			rs = stmt.executeQuery(sql);
			endTime = System.currentTimeMillis();
			intervalTime = endTime - startTime;
			while(rs.next()){
				movieList.add(new MovieResult(rs.getString(1),rs.getString(2),rs.getString(3)));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		HiveConnUtil.closeConnection(conn);
		
		for(int i=0;i<movieList.size();i++){
			System.out.println(movieList.get(i));
		}
		HttpSession session = request.getSession();
		long num = movieList.size();
		session.setAttribute("intervalTime", intervalTime);
		session.setAttribute("num", num);
		*/
		HttpSession session = request.getSession();
		
		//session.setAttribute("intervalTime", intervalTime);
		session.setAttribute("sql", sql);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/result.jsp?");
		dispatcher.forward(request, response);
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	

	}
	/**
	 * @throws SQLException 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
