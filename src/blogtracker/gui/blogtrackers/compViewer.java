/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.gui.blogtrackers;
import blogtracker.util.UtilFunctions;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.index.IndexReader;

/**
 *
 * @author skumar34
 */
public class compViewer extends UtilFunctions
{
    public compViewer()
    {
        //blank constructor for Flex
    }

     public String freqTermIndex;// = "C:\\indices\\index1";
    public String SEARCH_INDEX; //= "C:\\Program Files (x86)\\blazeds\\tomcat\\webapps\\blazeds\\BlogTracker\\blogtrackers-index";
    public String stopwordsLoc;

//    public void loadGlobalConstants()
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
//                SEARCH_INDEX = hm.get("searchIndex");
//                freqTermIndex = hm.get("freqTermIndex");
//                stopwordsLoc = hm.get("stopWords");
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

    public List<BlogSites> getblogsites()
    {
        try {
         
            List<BlogSites> blogsites = new ArrayList<BlogSites>();
            Connection  conn = getConn();
            Statement stmt = conn.createStatement();
            String querystr = "select blogsite_id, blogsite_name, site_type from blogsites order by blogsite_id";
            ResultSet rset = stmt.executeQuery(querystr);
            while (rset.next())
            {
                BlogSites bs = new BlogSites(rset.getString("blogsite_name"), rset.getInt("blogsite_id"), rset.getString("site_type"),false);
                blogsites.add(bs);
            }
            rset.close();
            conn.close();
            return blogsites;
        } catch (SQLException ex) {
           // Logger.getLogger(comparisonmode.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public ArrayList<String> createTagCloud1(Date startDate, int threshold, Date endDate, int selFID)
    {
        SimpleDateFormat sdform = new SimpleDateFormat();
//        System.out.println("inside tag cloud 1");
        sdform.applyPattern("yyyy-MM-dd");
        String sdate = sdform.format(startDate);
        String edate = sdform.format(endDate);
        //System.out.println("inside");
        ArrayList<String> result = new ArrayList<String>();
        int window = 1;
        String tags = formTags(sdate, threshold, edate, selFID, window);
        //System.out.println("Tags"+tags);
        result.add(tags);
        window = 2;
        String ngrams = formTags(sdate, threshold, edate, selFID, window);
        //System.out.println("Ngrams"+ngrams);
        result.add(ngrams);
        return result;
    }

    public ArrayList<String> createTagCloud2(Date startDate, int threshold, Date endDate, int selFID)
    {
        //System.out.println("inside2");
        SimpleDateFormat sdform = new SimpleDateFormat();
//        System.out.println("inside tag cloud 2");
        sdform.applyPattern("yyyy-MM-dd");
        String sdate = sdform.format(startDate);
        String edate = sdform.format(endDate);
    
        ArrayList<String> result = new ArrayList<String>();
        int window = 1;
        String tags = formTags(sdate, threshold, edate, selFID, window);
       //System.out.println("Tags"+tags);
        result.add(tags);
        window = 2;
        String ngrams = formTags(sdate, threshold, edate, selFID, window);
        //System.out.println("Ngrams"+ngrams);
        result.add(ngrams);
        return result;
    }

     public String formTags(String startDate, int threshold, String endDate, int selFID, int window)
    {
       //System.out.println("inside2");
       StringBuffer taghtml = new StringBuffer();
       ArrayList<Integer> selectedsites = new ArrayList<Integer>();
       selectedsites.add(selFID);
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
       //ArrayList<String> retVal = new ArrayList<String>();
       //retVal.add(taghtml.toString());
       //retVal.add(String.valueOf(window));
       //System.out.println(retVal.getTaghtml()+" "+retVal.getWindow());
       return taghtml.toString();
    }

    public tags[] getngrampairs(String startDate, String endDate,ArrayList<Integer> selectedsites,int window,int threshold)
    {
        try {
            loadConstants();
            SEARCH_INDEX = hm.get("searchIndex");
                freqTermIndex = hm.get("freqTermIndex");
                stopwordsLoc = hm.get("stopWords");
            IndexReader idfread = IndexReader.open(SEARCH_INDEX);
            String input = getPostsFromDB(startDate,endDate,selectedsites);
           //System.out.println("input = "+input);
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
        Connection conn = this.getConn();
        String selsitesQuery = this.getSelSitesQuery(selectedsites);
        String queryStr = "select post from blogposts where "+selsitesQuery+" date >='"+startDate+"' and date<='"+endDate+"'";
        //System.out.println("querystr "+queryStr);
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
           // System.out.println(inputStr.toString());
            return inputStr.toString();
        }catch(SQLException ex)
        {
            return null;
        }
    }

}
