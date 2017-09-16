/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.gui.blogtrackers;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

import blogtracker.util.InfluentialBlogger;
import blogtracker.util.UtilFunctions;

/**
 *
 * @author skumar34
 */
public class InflMatrix extends UtilFunctions
{

	public InflMatrix()
	{

	}

	public InfluentialBlogger[] getinflbloggers(double commentWeight, double inpLinkWeight, double outLinkWeight, java.util.Date startDate, java.util.Date endDate, ArrayList<Integer> selsites)
	{

//		try
//		{
//			SimpleDateFormat sdform = new java.text.SimpleDateFormat();
//			sdform.applyPattern("yyyy-MM-dd");
//			String selSitesQuery = getSelSitesQuery(selsites);
//			Connection conn = getConn();
//			Statement stmt = conn.createStatement();
//			String sqlStatement = "SELECT blogpost_id, num_comments,num_outlinks,num_inlinks,post_length,blogger  FROM blogposts WHERE "+selSitesQuery+" (date >= '" +sdform.format(startDate) + "' AND date <= '" + sdform.format(endDate) + "') and blogger not like '' ORDER BY date";
//			ResultSet rs = stmt.executeQuery(sqlStatement);
//			ArrayList<InfluentialBlogger> bloggersList=new ArrayList<InfluentialBlogger>();
//			ArrayList<String> names= new ArrayList<>();
//
//			while(rs.next())
//			{
//				//int postID = rs.getInt("blogpost_id");
//				int comments = rs.getInt("num_comments");
//				int numOutLinks = rs.getInt("num_outlinks");
//				int numInLinks = rs.getInt("num_inlinks");
//				int postLength = rs.getInt("post_length");
//				String bloggerName=rs.getString("blogger");
//				names.add(bloggerName);
//				double lengthFactor= 0.0;
//				if(postLength <= 350)
//					lengthFactor = 1.0;
//				if(postLength > 350 && postLength <=1500)
//					lengthFactor = 2.0;
//				if(postLength > 1500)
//					lengthFactor = 3.0;
//				double scalingFactor = lengthFactor;
//				double outLinksNormalized = numOutLinks/lengthFactor;
//
//				double influenceFlow = (commentWeight*comments) + (inpLinkWeight*numInLinks) -(outLinkWeight* outLinksNormalized);
//				double influence = scalingFactor * influenceFlow;
//				boolean flagFound=false;
//
//				for(int i=0;i<bloggersList.size();i++)
//				{
//					if(bloggersList.get(i).getBloggerName().equalsIgnoreCase(bloggerName))
//					{
//						bloggersList.get(i).setInfluenceScore(Math.max(bloggersList.get(i).getInfluenceScore(), influence));
//						flagFound=true;
//						break;
//					}
//				}
//				if(flagFound==false)
//				{
//
//					InfluentialBlogger temp= new InfluentialBlogger(bloggerName,influence);
//					bloggersList.add(temp);
//				}
//
//			}
//
//
////			System.out.println(names);
//			InfluentialBlogger[] finalBloggersList=new InfluentialBlogger[bloggersList.size()];
//			for(int i=0;i<finalBloggersList.length;i++)
//			{
//				finalBloggersList[i] = new InfluentialBlogger(bloggersList.get(i).getBloggerName(),bloggersList.get(i).getInfluenceScore());
//			}
//			Arrays.sort(finalBloggersList, Collections.reverseOrder());         //sort the array of objects on the basis of the frequency value.
//
//			return finalBloggersList;
//		}
//		catch(Exception e)
//		{
//
//			e.printStackTrace();
			return null;
	//	}
	}

	public MatrixVals getActivityMatrix(double commentWeight, double inpLinkWeight, double outLinkWeight, java.util.Date startDate, java.util.Date endDate, int thresholdValue, ArrayList<Integer> selsites)
	{
		//ArrayList<BloggerActivity> bloggerList = new ArrayList<BloggerActivity>();
		InfluentialBlogger[] inflBloggerList = getinflbloggers(commentWeight, inpLinkWeight, outLinkWeight, startDate, endDate,selsites);
		if(inflBloggerList.length<thresholdValue)
		{
			thresholdValue = inflBloggerList.length/2;
		}
		String[] infllist = new String[thresholdValue];
		SimpleDateFormat sdform = new java.text.SimpleDateFormat();
		sdform.applyPattern("yyyy-MM-dd");
		for(int i=0;i<thresholdValue;i++)
		{
			infllist[i] = inflBloggerList[i].getBloggerName();
			System.out.println("infl List"+inflBloggerList[i].getBloggerName()+""+inflBloggerList[i].getInfluenceScore());
		}


		try{
			//System.out.println("active");
			Connection conn = getConn();
			MatrixVals mt = new MatrixVals();
			String selsitesquery = getSelSitesQuery(selsites);
			Statement stmt = conn.createStatement();
			String queryStr = "select count(*) as co, blogger from blogposts where "+selsitesquery+" date >= '" + sdform.format(startDate) + "' AND date <= '" + sdform.format(endDate) + "' group by blogger order by co desc";
			ResultSet rSet = stmt.executeQuery(queryStr);
			String[] activelist = new String[thresholdValue];
			int count =0;
			while(rSet.next())
			{
				if(count>=thresholdValue)
					break;
				// int blogPostCount = rSet.getInt("co");
				String bloggerName = rSet.getString("blogger");
				activelist[count] = bloggerName;
				//System.out.println(activelist[count]);
				count++;
			}

			rSet.close();
			stmt.close();
			conn.close();

			for(int i=0;i<thresholdValue;i++)
			{
				boolean flag = false;
				for(int j=0;j<thresholdValue;j++)
				{
					if(infllist[i].equals(activelist[j]))
					{
						flag = true;
					}
				}
				if(flag)
				{
					mt.inflact.add(infllist[i]);
				}
				else
					mt.inflinact.add(infllist[i]);
			}
			if(thresholdValue<inflBloggerList.length)
			{
				boolean flag = false;
				for(int i=thresholdValue;i<inflBloggerList.length;i++)
				{
					for(int j=0;j<thresholdValue;j++)
					{
						if(activelist[j].equals(inflBloggerList[i].getBloggerName()))
						{
							flag = true;
						}
					}

					if(flag)
					{
						mt.noninflact.add(inflBloggerList[i].getBloggerName());
					}
					else
						mt.noninflinact.add(inflBloggerList[i].getBloggerName());
				}
			}

			return mt;

		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return null;
	}

	public static void main(String[] agrs){
		InflMatrix gb = new InflMatrix();
		try {
			ArrayList<Integer> selsites = new ArrayList<Integer>();
			selsites.add(47);
			selsites.add(8);
			SimpleDateFormat sdm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String sdate = "2013-10-01 00:00:00";
			String edate = "2015-10-14 00:00:00";
			Date startdate = sdm.parse(sdate);
			Date enddate = sdm.parse(edate);
			MatrixVals blgs = gb.getActivityMatrix(0.2, 0.4, 0.1, startdate, enddate, 10,selsites);

		} catch (ParseException ex) {
			Logger.getLogger(getInfluentialBloggers.class.getName()).log(Level.SEVERE, null, ex);
		}
	}
}
