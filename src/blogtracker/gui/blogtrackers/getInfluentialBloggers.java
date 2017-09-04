/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.gui.blogtrackers;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import blogtracker.util.InfluentialBlogger;
import blogtracker.util.UtilFunctions;


/**
 *
 * @author skumar34
 */
public class getInfluentialBloggers extends UtilFunctions{

	public getInfluentialBloggers() {
		// TODO Auto-generated constructor stub
	}

	//	public List<InfluentialBlogger> getinflbloggers(double commentWeight, double inpLinkWeight, double outLinkWeight, java.util.Date startDate, java.util.Date endDate, ArrayList<Integer> selsites)
	//	{
	//
	//		try
	//		{
	//			SimpleDateFormat sdform = new java.text.SimpleDateFormat();
	//			sdform.applyPattern("yyyy-MM-dd");
	//			String selSitesQuery = getSelSitesQuery(selsites);
	//			Connection conn = getConn();
	//			Statement stmt = conn.createStatement();
	//			String sqlStatement = "SELECT blogpost_id, num_comments,num_outlinks,num_inlinks,post_length,blogger  FROM blogposts WHERE "+selSitesQuery+" (date >= '" +sdform.format(startDate) + "' AND date <= '" + sdform.format(endDate) + "') ORDER BY date";
	//			ResultSet rs = stmt.executeQuery(sqlStatement);
	//			ArrayList<InfluentialBlogger> bloggersList=new ArrayList<InfluentialBlogger>();
	//			ArrayList<InfluentialBlogger> topTenBloggers=new ArrayList<InfluentialBlogger>();
	//
	//			while(rs.next())
	//			{
	//				//int postID = rs.getInt("blogpost_id");
	//				int comments = rs.getInt("num_comments");
	//				int numOutLinks = rs.getInt("num_outlinks");
	//				int numInLinks = rs.getInt("num_inlinks");
	//				int postLength = rs.getInt("post_length");
	//				String bloggerName=rs.getString("blogger");
	//				double lengthFactor= 0.0;
	//				if(postLength <= 350)
	//					lengthFactor = 1.0;
	//				if(postLength > 350 && postLength <=1500)
	//					lengthFactor = 2.0;
	//				if(postLength > 1500)
	//					lengthFactor = 3.0;
	//				double scalingFactor = lengthFactor;
	//				double outLinksNormalized = numOutLinks/lengthFactor;
	//				//System.out.println(outLinksNormalized+" "+comments+" "+numInLinks);
	//				double influenceFlow = (commentWeight*comments) + (inpLinkWeight*numInLinks) -(outLinkWeight* outLinksNormalized);
	//				//System.out.println("influenceFlow = "+influenceFlow);
	//				double influence = scalingFactor * influenceFlow;
	//				if(Double.isNaN(influence)||Double.isInfinite(influence))
	//				{
	//					continue;
	//				}
	//				boolean flagFound=false;
	//				for(int i=0;i<bloggersList.size();i++)
	//				{
	//					if(bloggersList.get(i).getBloggerName().equalsIgnoreCase(bloggerName))//bloggersList[i].getBloggerName().equals(bloggerName))
	//					{
	//						bloggersList.get(i).setInfluenceScore(Math.max(bloggersList.get(i).getInfluenceScore(), influence));
	//						flagFound=true;
	//						break;
	//					}
	//				}
	//				if(flagFound==false)
	//				{
	//					InfluentialBlogger temp= new InfluentialBlogger(bloggerName,influence);
	//					bloggersList.add(temp);
	//				}
	//
	//			}
	//
	//			Collections.sort(bloggersList,Collections.reverseOrder());
	//			topTenBloggers.clear();
	//			for(int k=0;k<5;k++)
	//			{
	//				//finalBloggersList[k].setInfluenceScore(finalBloggersList[k].getInfluenceScore()/maxInfluence);
	//				topTenBloggers.add(bloggersList.get(k));
	//			}
	//			conn.close();
	//			return topTenBloggers;
	//		}
	//		catch(Exception e)
	//		{
	//
	//			e.printStackTrace();
	//			return null;
	//		}
	//	}
	public List<InfluentialBlogger> getinflbloggers(double commentWeight, double inpLinkWeight, double outLinkWeight, java.util.Date startDate, java.util.Date endDate, String selsites)
	{

		try
		{
			SimpleDateFormat sdform = new java.text.SimpleDateFormat();
			sdform.applyPattern("yyyy-MM-dd");
			Connection conn = getConn();
			Statement stmt = conn.createStatement();
			String sqlStatement = "SELECT blogsite_id, num_comments,num_outlinks,num_inlinks,post_length,blogger FROM blogtrackers.blogposts WHERE "+selsites+" and (date >= '" +sdform.format(startDate) + "' AND date <= '" + sdform.format(endDate) + "') ORDER BY date";
			ResultSet rs = stmt.executeQuery(sqlStatement);
			ArrayList<InfluentialBlogger> bloggersList=new ArrayList<InfluentialBlogger>();
			ArrayList<InfluentialBlogger> topFiveBloggers=new ArrayList<InfluentialBlogger>();

			while(rs.next())
			{
				int siteID = rs.getInt("blogsite_id");
				int comments = rs.getInt("num_comments");
				int numOutLinks = rs.getInt("num_outlinks");
				int numInLinks = rs.getInt("num_inlinks");
				int postLength = rs.getInt("post_length");
				String bloggerName=rs.getString("blogger");
				int lengthFactor= 0;
				if(postLength <= 350)
					lengthFactor = 1;
				if(postLength > 350 && postLength <=1500)
					lengthFactor = 2;
				if(postLength > 1500)
					lengthFactor = 3;
				int scalingFactor = lengthFactor;
				int outLinksNormalized = numOutLinks/lengthFactor;
				//System.out.println(outLinksNormalized+" "+comments+" "+numInLinks);
				int influenceFlow =  (int) ((commentWeight*comments) + (inpLinkWeight*numInLinks) -(outLinkWeight* outLinksNormalized));
				//System.out.println("influenceFlow = "+influenceFlow);
				int influence = scalingFactor * influenceFlow;
				if(Double.isNaN(influence)||Double.isInfinite(influence))
				{
					continue;
				}
				boolean flagFound=false;
				for(int i=0;i<bloggersList.size();i++)
				{
					if(bloggersList.get(i).getBloggerName().equalsIgnoreCase(bloggerName))//bloggersList[i].getBloggerName().equals(bloggerName))
					{
						bloggersList.get(i).setInfluenceScore(Math.max(bloggersList.get(i).getInfluenceScore(), influence));
						flagFound=true;
						break;
					}
				}
				if(flagFound==false)
				{
					long a = Math.round(influence);
					InfluentialBlogger temp= new InfluentialBlogger(bloggerName,siteID,influence);
					bloggersList.add(temp);
				}

			}

			Collections.sort(bloggersList,Collections.reverseOrder());
			topFiveBloggers.clear();
			if(bloggersList.size()>0){
				System.out.println("size of blogger list "+bloggersList.size());
				if(bloggersList.size()>0 && bloggersList.size()<10){
					for(int k=0;k<bloggersList.size();k++)
					{
						int siteID=bloggersList.get(k).getBlogSiteID();
						String blogName=getBlogName(siteID);
						bloggersList.get(k).setBlogName(blogName);
						topFiveBloggers.add(bloggersList.get(k));

					}
				}else if(bloggersList.size()>=10){
					for(int k=0;k<10;k++)
					{
						int siteID=bloggersList.get(k).getBlogSiteID();
						String blogName=getBlogName(siteID);
						bloggersList.get(k).setBlogName(blogName);
						topFiveBloggers.add(bloggersList.get(k));

					}
				}
				System.out.println("TopBlogger"+topFiveBloggers);
				conn.close();
			}
			return topFiveBloggers;
		}
		catch(Exception e)
		{

			e.printStackTrace();
			return null;
		}
	}

	/**
	 * @param siteID
	 */
	private String getBlogName(int siteID) {
		String blogName=null;
		try {
			Connection conn = getConn();
			String queryStr="SELECT blogsite_name FROM blogtrackers.blogsites where blogsite_id in ("+siteID+")";
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery(queryStr);
			while (rset.next())
			{
				blogName = rset.getString("blogsite_name");
			}
			rset.close();
			stmt.close();
			conn.close();
			return blogName;
		} 
		catch (SQLException ex) {
			Logger.getLogger(sitesDialog.class.getName()).log(Level.SEVERE, null, ex);
			return blogName;
		}
	}

	//	    public static void main(String[] args)
	//	    {
	//	        getInfluentialBloggers gb = new getInfluentialBloggers();
	//	        try {
	//	            ArrayList<Integer> selsites = new ArrayList<Integer>();
	//	            selsites.add(1);
	//	            selsites.add(2);
	//	            SimpleDateFormat sdm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	//	            String sdate = "2012-09-01 00:00:00";
	//	            String edate = "2014-09-10 00:00:00";
	//	            Date startdate = sdm.parse(sdate);
	//	            Date enddate = sdm.parse(edate);
	//	            List<InfluentialBlogger> blgs = gb.getinflbloggers(0.2, 0.4, 0.1, startdate, enddate, selsites);
	//	            for(InfluentialBlogger ib:blgs)
	//	            {
	//	                System.out.println(ib.getBloggerName()+" "+Math.ceil(ib.getInfluenceScore()));
	//	            }
	//	        } catch (ParseException ex) {
	//	        	 Logger.getLogger(getInfluentialBloggers.class.getName()).log(Level.SEVERE, null, ex);
	//			}
	//	    }

}

