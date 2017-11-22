/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package authentication;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

import blogtracker.util.UtilFunctions;

import java.sql.SQLException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
/
 *
 * @author OBADIMU Adewale
 */

public class DBConnector {
	public Connection dbCon ; 
	public String current_user;
	public String current_user_type;
	
	//"jdbc:mysql://144.167.112.118:3306/blogtrackers"
	//"jdbc:mysql://localhost:3306/blogtrackers"
	public  DBConnector(){
		String dbURL =  "jdbc:mysql://144.167.112.118:3306/blogtrackers"; //144.167.112.118 ukraine_super, summer2014
        String username ="ukraine_super";
	    String password = "summer2014";      
		//Statement stmt = null;
		//ResultSet rs = null;
		try{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			dbCon = DriverManager.getConnection(dbURL, username, password);
			//System.out.println(dbCon);
		}catch(Exception ex){
			//System.out.println(ex);
			System.out.println("Unable to connect!");
		}
	}

	public Connection getConnection(){
		return dbCon;  
	}
	


	public ArrayList query(String query){
		ArrayList result=new ArrayList();  
		Connection con = null;
		//System.out.println(query);
		java.sql.Statement stmt = null;
		ResultSet rs = null;   
		try {
			con = getConnection();//getConn();//Connection();//getConection//DriverManager.getConnection(dbURL, username, password);
			stmt = con.prepareStatement(query);
			rs = stmt.executeQuery(query); 
			ResultSetMetaData rsmd = rs.getMetaData();
			int column_size = rsmd.getColumnCount();
			int i=0;
			while(rs.next()){
				ArrayList output=new ArrayList();
				int total=column_size;//rs.getFetchSize();
				//rs.
				for(int j=1;j<=(total); j++ ){
					output.add((j-1), rs.getString(j));
				}
				result.add(i,output);
				i++;
			}

		} catch (SQLException ex) {
			result.add(0,"Err");          
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) { /* ignored */}
			}
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) { /* ignored */}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) { /* ignored */}
			}
		}

		return result;
	}

	

	public boolean updateTable(String query){
		Connection con = null;
		java.sql.Statement stmt = null;
		ResultSet rs = null;             
		boolean donee;// =false;
		try {
			con = getConnection();//getConection//DriverManager.getConnection(dbURL, username, password);
			stmt = con.prepareStatement(query);
			//stmt = con.prepareStatement(medication_query);
			int done = stmt.executeUpdate(query);
			donee=true;

		} catch (SQLException ex) {
			donee=false;    
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) { /* ignored */}
			}
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) { /* ignored */}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) { /* ignored */}
			}
		} 
		return donee;
	}

	
	public ArrayList login(String email, String password){
		String query="SELECT * FROM usercredentials WHERE Email ='"+email+"' AND Password ='"+password+"'"; 
		ArrayList<?> user_info= this.query(query);

		if(user_info.size()>0){     
			user_info=(ArrayList)user_info.get(0);
		}  
		return user_info;
	}
	
	public boolean emailExists(String email){
		String query="SELECT * FROM usercredentials WHERE Email ='"+email+"' "; 
		ArrayList user_info= this.query(query);

		if(user_info.size()>0){     
			return true;
		}  
		return false;
	}
        
        public boolean usernameExists(String username){
		String query="SELECT * FROM usercredentials WHERE UserName ='"+username+"' "; 
		ArrayList user_info= this.query(query);

		if(user_info.size()>0){     
			return true;
		}  
		return false;
	}

	public  void setCurrentUser(String user_id){
		current_user=user_id;    
	}

	public boolean trackerExists(String userName, String trackerName){
		String query="SELECT * FROM blogtrackers.trackers where userid='"+userName+"' and tracker_name='"+trackerName+"'"; 
		ArrayList user_info= this.query(query);
		if(user_info.size()>0){     
			return true;
		}  
		return false;
	}

        // Make sure other fields are allowed to take null
	public boolean register(String name, String email,String password, String usertype){
		boolean inserted=false;
		String digest =this.md5Funct(password);
		String query_string ="insert into usercredentials (UserName, Email, Password, MessageDigest, user_type,first_name,last_name,phone_number,address,profile_picture,last_updated,added_by,date_added ) VALUES ('"+name+"','"+email+"','"+password+"','"+digest+"','"+usertype+"','','','','','','','','')";
		inserted=this.updateTable(query_string);  
		return inserted;
	}

	
        public String md5Funct(String userNamePass) {
		try {

			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(userNamePass.getBytes());
			byte byteData[] = md.digest();
			StringBuilder hexString = new StringBuilder();
			for (int i = 0; i < byteData.length; i++) {
				String hex = Integer.toHexString(0xff & byteData[i]);
				if (hex.length() == 1)
					hexString.append('0');
				hexString.append(hex);
			}
			return hexString.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return null;
	}
}