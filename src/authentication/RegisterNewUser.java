/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package authentication;

import java.io.File;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import blogtracker.util.UtilFunctions;

/**
 *
 * @author skumar34
 */
public class RegisterNewUser extends UtilFunctions {


	private String dbConStr;
	private String watchFilesPath;
	private Connection databaseConnection;
	private String dbusername;
	private String dbpassword;

	HashMap<String,String> hm = new HashMap<String,String>();
	public RegisterNewUser() {
		loadConstants();
		setResource();

	}

	private void setResource()
	{
		//"jdbc:sqlserver://149.169.226.79:1433;instanceName=DMMLSERVER;databaseName=blogtrackers_farsi;SelectMethod=cursor;user=trackerapp;password=number123";//"jdbc:sqlserver://localhost;instanceName=MSSQLSERVER;databaseName=blogtracker;SelectMethod=cursor;user=test;password=test";
		if(hm.isEmpty())
		{
			dbConStr = null;
		}
		else
		{
			dbConStr = hm.get("dbConnection");
			dbusername = hm.get("dbUserName");
			dbpassword = hm.get("dbPassword");
			watchFilesPath = hm.get("watchLoc");
		}

		try{
			//Class.forName("com.mysql.jdbc.Driver").newInstance();
			databaseConnection = getConn();//DriverManager.getConnection(dbConStr,dbusername,dbpassword);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}

	private boolean initializeUser(String userName)
	{

		File ufile = new File(watchFilesPath+userName+".post");        //Offline watch file for new user.

		if(!ufile.exists())
		{

			try {
				return ufile.createNewFile();
			} catch (IOException ex) {
				//Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
				return false;
			}
		}
		return false;

	}


	public boolean checkDuplicateUser(String iUserName)
	{
		try{
			if(databaseConnection!=null)
			{
				String queryStr = "SELECT UserName FROM UserCredentials WHERE Username = ?";
				PreparedStatement pstmt = databaseConnection.prepareStatement(queryStr);
				pstmt.setString(1, iUserName);
				ResultSet rSet=pstmt.executeQuery();
				// System.out.println(rSet.getString("UserName"));
				if(rSet.next())
				{
					//System.out.println("found");
					rSet.close();
					pstmt.close();
					return true;
				}
				else
				{
					//System.out.println("not found");
					rSet.close();
					pstmt.close();
					return false;        //not a duplicate user
				}
			}
			else
				return true;
		}catch(SQLException e)
		{
			//System.out.println("not found 2");
			return false; //this exception is not a problem  .. this means there was no duplicate user.
		}

	}

	public boolean addUser(String iUserName,String iPassword,String iEmail)
	{
		//System.out.println(iUserName+" "+iPassword+" "+iEmail);

		String userNamePass = iUserName + iPassword;
		String mdvalue = md5Funct(userNamePass);

		if(databaseConnection!=null)
		{
			if(checkDuplicateUser(iUserName))
			{
				//System.out.println("duplicate user");
				return false;
			}
			else
			{
				//System.out.println("adding");
				String queryStr = "INSERT INTO UserCredentials VALUES(?,?,?,?)";
				String queryStr1 = "INSERT INTO User_Watches VALUES(?,?,?,?)";
				try{
					//databaseConnection = DriverManager.getConnection(dbConStr);
					PreparedStatement pstmt = databaseConnection.prepareStatement(queryStr);
					pstmt.setString(1, iUserName);
					pstmt.setString(2, iPassword);
					pstmt.setString(3, iEmail);
					pstmt.setString(4, mdvalue);
					pstmt.execute();
					pstmt.clearParameters();
					pstmt = databaseConnection.prepareStatement(queryStr1);
					pstmt.setString(1, iUserName);
					pstmt.setString(2, "");
					pstmt.setString(3, iEmail);
					pstmt.setInt(4, 1);
					pstmt.execute();
					pstmt.close();
					boolean fcreate = initializeUser(iUserName);
					return true;
				}catch(SQLException e)
				{
					e.printStackTrace();
					return false;
				}
			}
		}
		else
			return true;
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
