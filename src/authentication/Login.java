/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package authentication;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import blogtracker.util.UtilFunctions;
import blogtracker.util.sysResource;

/**
 *
 * @author skumar34
 * @subauthor msaadghouri
 */

public class Login extends UtilFunctions{
	public sysResource sysres= new sysResource();

	public Login()
	{
		loadConstants();
		setResource();
	}

	public sysResource getSysRes() {
		return sysres;
	}
	HashMap<String,String> hm = new HashMap<String,String>();


	private void setResource()
	{
		sysres.databaseConnectionString=hm.get("dbConnection");//"jdbc:sqlserver://149.169.226.79:1433;instanceName=DMMLSERVER;databaseName=blogtrackers_farsi;SelectMethod=cursor;user=trackerapp;password=number123";//"jdbc:sqlserver://localhost;instanceName=MSSQLSERVER;databaseName=blogtracker;SelectMethod=cursor;user=test;password=test";
		sysres.setPassword(hm.get("dbPassword"));
		sysres.setUsername("dbUserName");
	}

	public void addUser(String iUserName,String iPassword,String iEmail)
	{
		if(isUserExists(iUserName))
		{
			System.out.println("duplicate user");

		}
		else
		{
			String queryStr = "INSERT INTO UserCredentials VALUES(?,?,?)";
			String queryStr1 = "INSERT INTO User_Watches VALUES(?,?,?,?)";
			try{
				Connection conn = getConn();//DriverManager.getConnection(sysres.databaseConnectionString,sysres.getUsername(),sysres.getPassword());
				PreparedStatement stmt = conn.prepareStatement(queryStr);
				stmt.setString(1, iUserName);
				stmt.setString(2, iPassword);
				stmt.setString(3, iEmail);
				stmt.execute();
				stmt = conn.prepareStatement(queryStr1);
				stmt.setString(1, iUserName);
				stmt.setString(2, "");
				stmt.setString(3, iEmail);
				stmt.setInt(4, 0);
				stmt.execute();
				stmt.close();
				conn.close();
			}catch(SQLException e)
			{
				e.printStackTrace();
			}
		}
	}

	public boolean removeUser(String iUserName)
	{
		try{

			String queryStr = "Delete FROM UserCredentials where UserName = ?";
			Connection conn = getConn();//DriverManager.getConnection(sysres.databaseConnectionString,sysres.getUsername(),sysres.getPassword());
			PreparedStatement pstmt = conn.prepareStatement(queryStr);
			pstmt.setString(1, iUserName);

			if(pstmt.execute())
			{
				pstmt.close();
				conn.close();
				return true;
			}
			else
			{
				pstmt.close();
				conn.close();
				return false;
			}

		}catch(SQLException e)
		{

			e.printStackTrace();
			return false;
		}
		//remove a user also cleanup watchlists
	}

	public boolean isUserExists(String iUserName)
	{
		try{

			String queryStr = "SELECT UserName FROM UserCredentials where Username = ?";
			//Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			Connection conn = getConn();//DriverManager.getConnection(sysres.databaseConnectionString,sysres.getUsername(),sysres.getPassword());
			PreparedStatement pstmt = conn.prepareStatement(queryStr);
			pstmt.setString(1, iUserName);
			//stmt = databaseConnection.createStatement();
			ResultSet rs = pstmt.executeQuery();
			if(rs.next())
			{
				rs.close();
				pstmt.close();
				conn.close();
				return true;
			}
			else
			{
				rs.close();
				pstmt.close();
				conn.close();
				return false;
			}
		}catch(SQLException e)
		{
			e.printStackTrace();
			return false;
		}
	}

	public sysResource loginVerify(String iUserName,String iPassword)
	{
		String userNamePass = iUserName + iPassword;
		String mdvalue = md5Funct(userNamePass);

		try {
			String queryStr = "SELECT MessageDigest FROM UserCredentials where MessageDigest = ?";
			Connection conn = getConn();//DriverManager.getConnection(sysres.databaseConnectionString);
			PreparedStatement pstmt = conn.prepareStatement(queryStr);
			pstmt.setString(1, mdvalue);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next())
			{
				if(rs.getObject(1).equals(mdvalue))
				{
					rs.close();
					pstmt.close();
					sysres.verified = true;
					conn.close();
					return sysres;

				}
			}
			rs.close();
			pstmt.close();
			conn.close();

		}
		catch(SQLException e)
		{
			e.printStackTrace();
			return null;
		}

		return null;  //Invalid credentials
	}

	private String md5Funct(String userNamePass) {
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

