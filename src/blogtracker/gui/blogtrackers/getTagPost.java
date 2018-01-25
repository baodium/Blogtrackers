/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.gui.blogtrackers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.index.IndexReader;

import blogtracker.util.UtilFunctions;

/**
 *
 * @author skumar34
 */
public class getTagPost extends UtilFunctions
{

	public getTagPost()
	{

	}
	public String freqTermIndex;
	public String SEARCH_INDEX;
	public String stopwordsLoc;
	public String bloggerPostIndex;// = "C:\\indices\\index2";
	//     public void loadGlobalConstants()
	//    {
	//
	//        BufferedReader br = null;
	//        try {
	//            //System.out.println(System.getProperty("user.dir"));
	//            HashMap<String,String> hm = new HashMap<String,String>();
	//            br = new BufferedReader(new FileReader("..\\webapps\\ROOT\\WEB-INF\\classes\\authentication\\blogtrackers.config"));
	//            String temp = "";
	//            while((temp = br.readLine())!=null)
	//            {
	//                temp = temp.trim();
	//                //System.out.println(temp);
	//                if(temp.isEmpty()||temp.startsWith("//"))
	//                {
	//                    continue;
	//                }
	//                else
	//                {
	//                    String[] arr = temp.split("##");
	//                    //System.out.println(arr[0]+" "+arr[1]);
	//                    if(arr.length==2)
	//                    {
	//                        hm.put(arr[0].trim(), arr[1].trim());
	//                    }
	//                }
	//            }
	//            if(!hm.isEmpty())
	//            {
	//
	//                bloggerPostIndex = hm.get("bloggerPostIndex");
	//
	//            }
	//        } catch (IOException ex) {
	//            ex.printStackTrace();
	//        }finally {
	//            try {
	//                br.close();
	//            } catch (IOException ex) {
	//               ex.printStackTrace();
	//            }
	//
	//        }
	//
	//    }
	//    public void loadGlobalConstants()
	//    {
	//        try {
	//            JFigLocatorIF locator = new blogtracker.util.LocalJFigLocator("config/", "config.xml");
	//            JFigIF confInstance = org.igfay.jfig.JFig.getInstance(locator);
	//            bloggerPostIndex = confInstance.getValue("Indices", "bloggerPostIndex");
	//
	//        } catch (JFigException ex) {
	//            System.out.println("Configuration file Not found");
	//        }
	//    }


	public String getPost(int postID)
	{
		//System.out.println(postID);
		String post =  getBlogPost(postID);
		return post;
	}

	//	public List<BPost> fillblogposts(String searchText,String startDate,String endDate,ArrayList<Integer> selectedsites)
	//	{
	//		try {
	//			loadConstants();
	//			bloggerPostIndex = hm.get("bloggerPostIndex");
	//			SimpleDateFormat sdm = new SimpleDateFormat();
	//			sdm.applyPattern("MM-dd-yyyy");
	//			//            String startdate = sdm.format(startDate);
	//			//            String enddate = sdm.format(endDate);
	//			Connection conn = getConn();
	//			Statement stmt = conn.createStatement();
	//			String selsitesQuery = getSelSitesQuery(selectedsites);
	//			//System.out.println("search text = "+searchText);
	//			String querystr = "select blogpost_id,date,title,blogger from blogposts where "+selsitesQuery+" date>='"+startDate+"' and date<='"+endDate+"' and post like '%"+searchText+"%'";
	//			//System.out.println(querystr);
	//			//            blogtracker.util.indexSearch ind = new blogtracker.util.indexSearch();
	//			//            Hits searchHits=ind.search(searchText,bloggerPostIndex);
	//			List<BPost> posts = new ArrayList<BPost>();
	//			//           for(int i=0;i<searchHits.length();i++)
	//			//            {
	//			ResultSet rset = stmt.executeQuery(querystr);
	//			while(rset.next())
	//			{   
	//				long id = rset.getInt("blogpost_id");
	//				String title = rset.getString("title");
	//				String blogger = rset.getString("blogger");
	//				java.sql.Date date = rset.getDate("date");
	//				String pubDate = sdm.format(date);
	//				BPost post = new BPost(id, title,pubDate,blogger);
	//				posts.add(post);
	//			}
	//			//System.out.println("====================== "+posts);
	//			conn.close();
	//			return posts;
	//		} catch (SQLException ex) {
	//			Logger.getLogger(getTagPost.class.getName()).log(Level.SEVERE, null, ex);
	//		}
	//		return null;
	//
	//	}
	public List<BPost> fillblogpost(String startDate,String endDate,ArrayList<Integer> selectedsites)
	{
		System.out.println("Inside fillblog post Method");
		try {
			loadConstants();
			bloggerPostIndex = hm.get("bloggerPostIndex");
			String selsitesQuery = getSelSitesQuery(selectedsites);
			java.text.SimpleDateFormat sdFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
			String querystr = "select blogpost_id,date,title,blogger from blogposts where "+selsitesQuery+" date>='"+startDate+"' and date<='"+endDate+"'";

			Connection conn = getConn();
			ArrayList<BPost> posts = new ArrayList<BPost>();
			Statement stmt = conn.createStatement();

			//System.out.println("Fillblog post query "+querystr);

			ResultSet rset = stmt.executeQuery(querystr);
			while(rset.next())
			{   

				int id = rset.getInt("blogpost_id");
				String title = rset.getString("title");
//				System.out.println("Title"+title);
				posts.add(new BPost(id,title,"",""));
			}
			//System.out.println("Posts ================ "+posts);
			conn.close();
			return posts;
		} catch (SQLException ex) {
			Logger.getLogger(getTagPost.class.getName()).log(Level.SEVERE, null, ex);
		}
		return null;

	}

	public ArrayList<String> newstepsfortag(String startDate, int threshold, String endDate, ArrayList<Integer> selectedsites)
	{

//		System.out.println("inside newStepsForTags");
		ArrayList<String> result = new ArrayList<String>();
		int window = 1;
		String tags = formTags(startDate, threshold, endDate, selectedsites, window);
//		System.out.println("Tags"+tags);
		result.add(tags);
		window = 2;
		String ngrams = formTags(startDate, threshold, endDate, selectedsites, window);
//		System.out.println("Ngrams"+ngrams);
		result.add(ngrams);
		return result;
	}
	public String formTags(String startDate, int threshold, String endDate, ArrayList<Integer> selectedsites, int window)
	{
//		System.out.println("inside form tags");
		StringBuffer taghtml = new StringBuffer();
		tags[] phrases = getngrampairs(startDate,endDate,selectedsites,window,threshold);
		int limit = threshold;
		if(phrases.length<threshold)
			limit = phrases.length;
		//System.out.println("limit = "+limit);
		int size = limit;
		int tier1 = size/4;
		for(int j=0;j<tier1;j++)
		{
			phrases[j].value = 30;
			//System.out.println(phrases[j].key+" "+phrases[j].value);
		}
		for(int j=tier1;j<tier1+tier1;j++)
		{
			phrases[j].value = 20;
			//System.out.println(phrases[j].key+" "+phrases[j].value);
		}
		for(int j=tier1+tier1;j<tier1+tier1+tier1;j++)
		{
			phrases[j].value = 15;
			//System.out.println(phrases[j].key+" "+phrases[j].value);
		}
		for(int j=tier1+tier1+tier1;j<limit;j++)
		{
			phrases[j].value = 10;
			//System.out.println(phrases[j].key+" "+phrases[j].value);
		}

		for(int i=0;i<limit;i++)
		{
			taghtml.append("<a href=\"event:"+phrases[i].key+"\"><font size=\""+phrases[i].value+ "\">"+phrases[i].key+"</font></a> ");
		}
		//System.out.println(taghtml);
		//System.out.println(taghtml.toString());
		//		ArrayList<String> retVal = new ArrayList<String>();
		//		retVal.add(taghtml.toString());
		//		retVal.add(String.valueOf(window));
		//		System.out.println(retVal.getTaghtml()+" "+retVal.getWindow());
		return taghtml.toString();
	}
		public static void main(String[] args)
		{
			getTagPost gp =  new getTagPost();
			ArrayList<Integer> aa =new ArrayList<Integer>();
			aa.add(8);
			aa.add(47);
			aa.add(80);
	//		ArrayList<String> dp = gp.newstepsfortag("2010-01-01", 50, "2011-06-01", aa);
			List<BPost> bp= gp.fillblogpost("2010-01-01", "2011-06-01", aa);
//			System.out.println(bp);
	
		}
	public tags[] getngrampairs(String startDate, String endDate,ArrayList<Integer> selectedsites,int window,int threshold)
	{
//		System.out.println("Inside Ngram pairs");
		try {
			loadConstants();
			SEARCH_INDEX = hm.get("searchIndex");
			freqTermIndex = hm.get("freqTermIndex");
			stopwordsLoc = hm.get("stopWords");
			IndexReader idfread = IndexReader.open(SEARCH_INDEX);
			String input = getPostsFromDB(startDate,endDate,selectedsites);
			//			System.out.println("input = "+input);
			if(input==null)
			{
				return null;
			}

			blogtracker.util.NGramAnalyzer ng = new blogtracker.util.NGramAnalyzer(window);
			tags[] ngrams = ng.getTopNGrams(input, stopwordsLoc, idfread);
			//System.out.println(ngrams[0].key+" "+ngrams[0].value);
			idfread.close();
			return ngrams;
		} catch (CorruptIndexException ex) {
			Logger.getLogger(getTagNGrams.class.getName()).log(Level.SEVERE, null, ex);
		} catch (IOException ex) {
			Logger.getLogger(getTagNGrams.class.getName()).log(Level.SEVERE, null, ex);
		}
		return null;
	}

	public String getPostsFromDB(String startDate,String endDate,ArrayList<Integer> selectedsites)
	{
//		System.out.println("Inside Get Post from DB");
		Connection conn = this.getConn();
		String selsitesQuery = getSelSitesQuery(selectedsites);
		String queryStr = "select post from blogposts where "+selsitesQuery+" date >='"+startDate+"' and date<='"+endDate+"'";
		try{
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery(queryStr);
			StringBuffer inputStr = new StringBuffer();
			while(rset.next())
			{
				String temp = rset.getString("post");
				if(!temp.isEmpty())
				{
					inputStr.append(" "+this.noHTMLString(temp));
				}
			}
			conn.close();
			//System.out.println(inputStr.toString());
			return inputStr.toString();
		}catch(SQLException ex)
		{
			return null;
		}
	}

}
