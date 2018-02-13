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
import blogtracker.util.UtilFunctions;

import java.sql.SQLException;
import java.sql.Connection;
import java.sql.ResultSet;

/**
/
 *
 * @author OBADIMU Adewale
 */

public class DBConnector extends UtilFunctions {
	public String current_user;
	public String current_user_type;
	
	public  DBConnector(){
	}
	
	public ArrayList query(String query){
		ArrayList result=new ArrayList();  
		java.sql.Statement stmt = null;
		ResultSet rs = null;   
		try{
		Connection	con = getConn();
			stmt = con.prepareStatement(query);
			rs = stmt.executeQuery(query); 
			ResultSetMetaData rsmd = rs.getMetaData();
			int column_size = rsmd.getColumnCount();
			int i=0;
			while(rs.next()){
				ArrayList output=new ArrayList();
				int total=column_size;
			
				for(int j=1;j<=(total); j++ ){
					output.add((j-1), rs.getString(j));
				}
				result.add(i,output);
				i++;
			}
			rs.close();
			stmt.close();
			con.close();

		} catch (SQLException ex) {
			ex.printStackTrace();
			result.add(0, "Err");          
		} 

		return result;
	}

	

	public boolean updateTable(String query){
		Connection con = null;
		java.sql.Statement stmt = null;
		ResultSet rs = null;             
		boolean donee;// =false;
		try {
			con = getConn();//getConection//DriverManager.getConnection(dbURL, username, password);
			stmt = con.prepareStatement(query);
			//stmt = con.prepareStatement(medication_query);
			int done = stmt.executeUpdate(query);
			//rs = stmt.executeQuery(query);
			donee=true;
			//rs.close();
			stmt.close();
			con.close();

		} catch (SQLException ex) {
			donee=false;    
		} 
		return donee;
	}

	
	public ArrayList<?> login(String email, String password){
		String query="SELECT * FROM usercredentials WHERE Email ='"+email+"' AND Password ='"+password+"'"; 
		ArrayList<?> user_info= this.query(query);

		if(user_info.size()>0){     
			user_info=(ArrayList<?>)user_info.get(0);
		}  
		return user_info;
	}
	
	public boolean emailExists(String email){
		String query="SELECT * FROM usercredentials WHERE Email ='"+email+"' "; 
		ArrayList<?> user_info= this.query(query);

		if(user_info.size()>0){     
			return true;
		}  
		return false;
	}
        
        public boolean usernameExists(String username){
		String query="SELECT * FROM usercredentials WHERE UserName ='"+username+"' "; 
		ArrayList<?> user_info= this.query(query);

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
		ArrayList<?> user_info= this.query(query);
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
	
	
	public ArrayList<Integer> getTotal(){
		
		ArrayList<Integer> total =new ArrayList<Integer>();
		Connection con = null;
		
		java.sql.Statement stmt = null;
		ResultSet rs = null;   
		try {
			String query = "select (select count(*) from usercredentials) as users, (select count(*) from trackers) as trackers, (select count(*) from blogposts) as blogposts, (select count(*) from blogsites) as blogsites from dual";
			con = getConn();
			stmt = con.prepareStatement(query);
			rs = stmt.executeQuery(query); 
			
			rs.next();
			int totalusers = rs.getInt("users");
			int trackers = rs.getInt("trackers");
			int blogposts = rs.getInt("blogposts");
			int blogsites = rs.getInt("blogsites");
			
			total.add(0,totalusers);
			total.add(1,trackers);
			total.add(2,blogposts);
			total.add(3,blogsites);
			
			rs.close();
			stmt.close();
			con.close();

		} catch (SQLException ex) {
			ex.printStackTrace();
			total.add(0,0);
			total.add(1,0);
			total.add(2,0);
			total.add(3,0);
		} 

		return total;

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