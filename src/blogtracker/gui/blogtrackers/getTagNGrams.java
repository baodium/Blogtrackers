/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.gui.blogtrackers;

import blogtracker.util.UtilFunctions;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.index.IndexReader;

/**
 *
 * @author skumar34
 */
public class getTagNGrams extends UtilFunctions
{

    public getTagNGrams()
    {
        
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
//            br = new BufferedReader(new FileReader("../webapps/ROOT/WEB-INF/classes/authentication/blogtrackers.config"));
//            //br = new BufferedReader(new FileReader("C:/Program Files (x86)/blazeds/tomcat/webapps/ROOT/WEB-INF/classes/authentication/blogtrackers.config"));
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
//    public void loadGlobalConstants()
//    {
//        try {
//            JFigLocatorIF locator = new blogtracker.util.LocalJFigLocator("config/", "config.xml");
//            JFigIF confInstance = org.igfay.jfig.JFig.getInstance(locator);
//            SEARCH_INDEX = confInstance.getValue("Indices", "searchIndex");
//            freqTermIndex = confInstance.getValue("Indices", "freqTermIndex");
//            stopwordsLoc = confInstance.getValue("stopWords","loc");
//        } catch (JFigException ex) {
//            System.out.println("Configuration file Not found");
//        }
//    }

    public TagCollection getngrampairs(String startDate, String endDate,ArrayList<Integer> selectedsites,int window)
    {
        try {
            loadConstants();
            SEARCH_INDEX = hm.get("searchIndex");
            freqTermIndex = hm.get("freqTermIndex");
            stopwordsLoc = hm.get("stopWords");
            IndexReader idfread = IndexReader.open(SEARCH_INDEX);
            String selsitesQuery = this.getSelSitesQuery(selectedsites);
            ArrayList<BlogPost> bposts= getPostsFromDB(startDate,endDate,selsitesQuery);
            if(bposts==null)
            {
                return null;
            }
            String input = MergePosts(bposts);
            blogtracker.util.NGramAnalyzer ng = new blogtracker.util.NGramAnalyzer(window);
            tags[] ngrams = ng.getTopNGrams(input, stopwordsLoc, idfread);
            tags[] ngramphrases = FilterTopTags(ngrams,bposts);
//            idfread.close();
            TagCollection tcoll = new TagCollection();
            tcoll.ngrams = ngramphrases;
            tcoll.posts = bposts;
            return tcoll;
        } catch (CorruptIndexException ex) {
            Logger.getLogger(getTagNGrams.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(getTagNGrams.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
   }

       public String MergePosts(ArrayList<BlogPost> posts)
    {
            StringBuffer inputStr = new StringBuffer();
            for(BlogPost post:posts)
            {
               if(!post.post.isEmpty())
               {
//                   String cleanedPost = post.post.replaceAll("\"|\'|&|#|:|;|,", "");
                   inputStr.append(" "+this.noHTMLString(post.post));
//                   inputStr.append(" "+this.noHTMLString(post.post));
//                   System.out.println(inputStr.toString());
               }
            }
            return inputStr.toString();
    }

    public tags[] FilterTopTags( tags[] ngrams,ArrayList<BlogPost> bposts)
    {
//        Connection conn = this.getConn();
//        int N = 0;
//        String queryStr = "select count(distinct blogger) as bloggercount from blogposts where "+selsitesQuery+" date >='"+startDate+"' and date<='"+endDate+"'";
//        try{
//            Statement stmt = conn.createStatement();
//            ResultSet rset = stmt.executeQuery(queryStr);
//            if(rset.next())
//            {
//                N = rset.getInt("bloggercount");
//            }
//            conn.close();
//        }catch(SQLException ex)
//        {
//            ex.printStackTrace();
//            N =0;
//        }
        int N = BloggerCount(bposts);
        int noofphrases = ngrams.length;
        tags[] ngramphrases = new tags[noofphrases];
        if(N>0)
        {           
//            int noofphrases = size;
//            if(ngrams.length<size)
//            {
//                noofphrases = ngrams.length;
//            }
            for(int i=0;i<noofphrases;i++)
            {
                ngramphrases[i] = new tags();
                int N_i = getNOBKeyword(ngrams[i].getKey(),bposts);
               // System.out.println("n for key "+ngrams[i].getKey()+" is "+N_i);
                ngramphrases[i].setKey(ngrams[i].key);
                if(N_i<=0)
                {
                    ngramphrases[i].setValue(ngrams[i].getValue());
                    ngramphrases[i].setFractionofbloggers(0);
                }
                else
                {
                    ngramphrases[i].setValue(ngrams[i].getValue()*((double)N_i/N));
                    ngramphrases[i].setFractionofbloggers((double)N_i/N);
                }
            }
            Arrays.sort(ngramphrases, Collections.reverseOrder());
            return ngramphrases;
        }
        else
        {
//            int noofphrases = size;
//            if(ngrams.length<size)
//            {
//                noofphrases = ngrams.length;
//            }
//            tags[] ngramphrases = new tags[size];
            for(int i=0;i<noofphrases;i++)
            {
                ngramphrases[i] = new tags();
                ngramphrases[i].setKey(ngrams[i].key);
                ngramphrases[i].setValue(ngrams[i].value);
                ngramphrases[i].setFractionofbloggers(0);
            }
            return ngramphrases;
        }


     }

    public int getNOBKeyword(String keyword,ArrayList<BlogPost> bposts)
    {
        HashSet<String> bloggers = new HashSet<String>();
        for(BlogPost bp:bposts)
        {
            String post = this.noHTMLString(bp.post);
            if(post.indexOf(keyword)!=-1)
            {
                if(!bloggers.contains(bp.blogger))
                {
                    bloggers.add(bp.blogger);
                }
            }
        }
        return bloggers.size();
    }

    //get the number of bloggers who used the keyword in their blog posts in the given time period.
//     public int getNOBKeyword(String keyword,String startDate, String endDate, String selsitesQuery)
//      {
//
//          Connection conn = getConn();
//          String querystr = "select count(distinct blogger) as nobloggers from blogposts where "+selsitesQuery+" post like'%"+keyword+"%' and date >='"+startDate+"' and date<='"+endDate+"'";
//
//        try {
//            Statement stmt = conn.createStatement();
//            ResultSet rset = stmt.executeQuery(querystr);
//            if(rset.next())
//            {
//                int noofbloggers = rset.getInt("nobloggers");
//                return noofbloggers;
//            }
//            stmt.close();
//        } catch (SQLException ex) {
//            Logger.getLogger(getTagNGrams.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        try {
//            conn.close();
//        } catch (SQLException ex) {
//            Logger.getLogger(getTagNGrams.class.getName()).log(Level.SEVERE, null, ex);
//        }
//          return 0;
//
//      }

      //DEBUG only, comment for release
//     public Connection getConn()
//     {
//        String constr = "jdbc:mysql://149.169.226.79:3306/blogtrackers_twitter?useUnicode=true&characterEncoding=utf8";
//        String username = "shamanth";
//        String password = "shamanth123";
//        Connection conn = null;
//        try {
//            try {
//                try {
//                    Class.forName("com.mysql.jdbc.Driver").newInstance();
//                } catch (InstantiationException ex) {
//                    Logger.getLogger(getTagNGrams.class.getName()).log(Level.SEVERE, null, ex);
//                } catch (IllegalAccessException ex) {
//                    Logger.getLogger(getTagNGrams.class.getName()).log(Level.SEVERE, null, ex);
//                }
//            } catch (ClassNotFoundException ex) {
//                Logger.getLogger(getTagNGrams.class.getName()).log(Level.SEVERE, null, ex);
//            }
//            conn = DriverManager.getConnection(constr, username, password);
//
//        } catch (SQLException ex) {
//            Logger.getLogger(getTagNGrams.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return conn;
//     }

     public int BloggerCount(ArrayList<BlogPost> bposts)
    {
        HashSet<String> uniquebloggers = new HashSet<String>();
        for(BlogPost bp:bposts)
        {
            String blogger = bp.getBlogger();
            if(!blogger.isEmpty())
            {
                uniquebloggers.add(blogger);
            }
        }
        return uniquebloggers.size();
    }

    public ArrayList<BlogPost> getPostsFromDB(String startDate,String endDate,String selsitesQuery)
    {
        Connection conn = this.getConn();
        String queryStr = "select blogpost_id,title,date,blogger,post,blogsite_id,num_comments from blogposts where "+selsitesQuery+" date >='"+startDate+"' and date<='"+endDate+"'";
        ArrayList<BlogPost> blogposts = new ArrayList<BlogPost>();
        try{
            Statement stmt = conn.createStatement();
            ResultSet rset = stmt.executeQuery(queryStr);
            StringBuffer inputStr = new StringBuffer();          
            while(rset.next())
            {

               String temp = rset.getString("post");
               if(!temp.isEmpty())
               {
                   long postid = rset.getLong("blogpost_id");
                   String title = rset.getString("title");
                   Date date = rset.getTimestamp("date");
                   String blogger = rset.getString("blogger");
                   int siteid = rset.getInt("blogsite_id");
                   int ncomments = rset.getInt("num_comments");
                   String post = rset.getString("post");
                   post = post.toLowerCase();
                   post = fixLinks(post);
                   BlogPost bp = new BlogPost(title,blogger,"",ncomments,postid,siteid,post,date);
                   blogposts.add(bp);
//                   inputStr.append(" "+this.noHTMLString(temp));
//                   System.out.println(inputStr.toString());
               }
            }
            stmt.close();
            conn.close();
            return blogposts;
        }catch(SQLException ex)
        {
            try {
                conn.close();
            } catch (SQLException ex1) {
                Logger.getLogger(getTagNGrams.class.getName()).log(Level.SEVERE, null, ex1);
            }
            return null;
        }
    }

    //DEBUG only
//    public static void main(String[] args)
//    {
//        getTagNGrams gt = new getTagNGrams();
//        ArrayList<Integer> sites = new ArrayList<Integer>();
//        sites.add(75);
//        sites.add(76);
//        sites.add(78);
//        sites.add(195);
//        sites.add(215);
//        sites.add(205);
//        sites.add(219);
//        //String query = gt.getSelSitesQuery(sites);
//        gt.getngrampairs("2011-06-08", "2011-06-08", sites,1);
//        //gt.getngrampairs("2010-05-01", "2010-07-01",sites,1);
//    }

    //Changed from NGrams to ArrayList because class was unloading at Flex end and causing errors.
    public FlexTagCollection formTags(String startDate,String endDate,int threshold,ArrayList<Integer> selectedsites,int window)
    {
       StringBuffer taghtml = new StringBuffer();
       TagCollection tcoll = getngrampairs(startDate,endDate,selectedsites,window);
       FlexTagCollection ftcoll = new FlexTagCollection();
       ftcoll.posts = tcoll.posts;
       tags[] phrases = tcoll.ngrams;
       int limit = threshold;
       if(phrases.length<threshold)
           limit = phrases.length;
       //System.out.println(limit);
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
          taghtml.append("<a href=\"event:"+phrases[i].key+"::"+phrases[i].getFractionofbloggers()+"\"><font size=\""+phrases[i].value+ "\">"+phrases[i].key+"</font></a> &nbsp; &nbsp; &nbsp; ");
       }
        //System.out.println(taghtml);
       ArrayList<String> retVal = new ArrayList<String>();
       retVal.add(taghtml.toString());
       retVal.add(String.valueOf(window));
       ftcoll.ngrams = retVal;
       //System.out.println(retVal.getTaghtml()+" "+retVal.getWindow());
       return ftcoll;
    }
    
    public class TagCollection
    {
        ArrayList<BlogPost> posts;
        tags[] ngrams;
    }
}

