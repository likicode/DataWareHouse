package edu.tongji.anna.util;



import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class HiveConnUtil {
	public static Connection getConnection(){
		Connection conn = null;
		try {
			Class.forName("org.apache.hive.jdbc.HiveDriver");
			String url = "jdbc:hive2://edgenode.likicode.com:10000/default";
			conn = DriverManager.getConnection(url,"","");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
	}
	
	public static void closeConnection(Connection conn){
		if(conn !=null){
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
