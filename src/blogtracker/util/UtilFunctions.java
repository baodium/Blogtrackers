/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package blogtracker.util;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
/**
 *
 * @author skumar34
 */
public class UtilFunctions
{
	
	
    protected String getSelSitesQuery(ArrayList<Integer> selsites)
    {
        String selSitesQuery = "";
        Iterator it = selsites.iterator();
        selSitesQuery += "(";
        while(it.hasNext())
        {
            Integer temp = (Integer) it.next();
            selSitesQuery = selSitesQuery +" blogsite_id = '"+ temp.intValue()+"' or";
        }
        if(selSitesQuery.length() != 1)
        {
            selSitesQuery = selSitesQuery.substring(0, selSitesQuery.length()-2);
            selSitesQuery = selSitesQuery+") and";
        }
        return selSitesQuery;
    }
    public String noHTMLString(String htmlpost)
    {
        String noHTMLString = htmlpost.replaceAll("\\<.*?\\>", "");
        noHTMLString = noHTMLString.replaceAll("\\{.*?\\}", "");
        noHTMLString = noHTMLString.replaceAll("\\s+", " ");
        Pattern comment = Pattern.compile("<!--.*?-->");
        Matcher mcomment = comment.matcher(noHTMLString);
        while (mcomment.find())
        {
            noHTMLString = mcomment.replaceAll("");
        }
        Pattern style = Pattern.compile("<style.*?>.*?</style>");
        Matcher mstyle = style.matcher(noHTMLString);
        while (mstyle.find())
        {
            noHTMLString = mstyle.replaceAll("");
        }
        Pattern header = Pattern.compile("<div class=\"post-header-sharing\">.*?</div>");
        Matcher mheader = header.matcher(noHTMLString);
        while (mheader.find())
        {
            noHTMLString = mheader.replaceAll("");
        }
        Pattern metaheader = Pattern.compile("<div class=\"postmeta.*>.*?</div>");
        Matcher mmeta = metaheader.matcher(noHTMLString);
        while (mmeta.find())
        {
            noHTMLString = mmeta.replaceAll("");
        }
        Pattern print = Pattern.compile("<div id=\"print-link\">.*?</div>");
        Matcher mprint = print.matcher(noHTMLString);
        while (mprint.find())
        {
            noHTMLString = mprint.replaceAll("");
        }
        Pattern share = Pattern.compile("<div id=\"sharethis\">.*?</div>");
        Matcher mshare = share.matcher(noHTMLString);
        while (mshare.find())
        {
            noHTMLString = mshare.replaceAll("");
        }
        Pattern footer = Pattern.compile("<div class=\"postfooter postmeta\">.*?</div>");
        Matcher mfooter = footer.matcher(noHTMLString);
        while (mfooter.find())
        {
            noHTMLString = mfooter.replaceAll("");
        }
        noHTMLString.trim();
        return noHTMLString;
    }
    public HashMap<String,String> hm = new HashMap<String,String>();
    public void loadConstants()
    {
        BufferedReader br = null;
        try {
            br = new BufferedReader(new FileReader("C:/blogtrackers.config"));
          
            String temp = "";
            while((temp = br.readLine())!=null)
            {
                temp = temp.trim();
                if(temp.isEmpty()||temp.startsWith("//"))
                {
                    continue;
                }
                else
                {
                    String[] arr = temp.split("##");
                    if(arr.length==2)
                    {
                        hm.put(arr[0].trim(), arr[1].trim());
                    }
                }
            }
          
        } catch (IOException ex) {
            Logger.getLogger(UtilFunctions.class.getName()).log(Level.SEVERE, null, ex);
        }finally {
            try {
                br.close();
            } catch (IOException ex) {
                Logger.getLogger(UtilFunctions.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
     
    }
    protected String fixLinks(String post)
    {
        int start = post.indexOf("<a href=\"");
        while(start!=-1)
        {
            int end = post.indexOf("\"",start+10);
            if(start!=-1&&end!=-1)
            {
                String posthalf1 = post.substring(0,end+1);
                String posthalf2 = post.substring(end+1,post.length());
              
                String  target = " target=\"_blank\" ";
                post = posthalf1+target+posthalf2;
                start = post.indexOf("<a href=\"",end);
            }
        }
        start = post.indexOf("<img src=\"");
        while(start!=-1)
        {
            int end = post.indexOf("\"",start+11);
            if(start!=-1&&end!=-1)
            {
                String posthalf1 = post.substring(0,end+1);
                String posthalf2 = post.substring(end+1,post.length());
                String  target = " target=\"_blank\" ";
                post = posthalf1+target+posthalf2;
                start = post.indexOf("<img src=\"",end);
            }
        }
        return post;
    }
    protected Connection getConn()
    {
        try {

            loadConstants();
            String constr = hm.get("dbConnection");
            String username = hm.get("dbUserName");
            String password = hm.get("dbPassword");
          

            if(constr!=null&&username!=null&&password!=null)
            {
                try {
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                } catch (InstantiationException ex) {
                    ex.printStackTrace();
                } catch (IllegalAccessException ex) {
                    ex.printStackTrace();
                }catch (ClassNotFoundException ex) {
                    ex.printStackTrace();
                }
            }
            Connection conn = DriverManager.getConnection(constr,username,password);
            return conn;
        } catch (SQLException ex) {
            Logger.getLogger(UtilFunctions.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    protected String getBlogPost(int postID)
    {
        try {
            Connection conn = getConn();
            Statement stmt = conn.createStatement();
            String queryStr = "select post from blogposts where blogpost_id = " + postID;
            ResultSet rset = stmt.executeQuery(queryStr);
            String post = "";
            while (rset.next())
            {
                post = rset.getString("post");
            }
            
            post = cleanpost(post);
            post = fixLinks(post);
            conn.close();
            return post;
        } catch (SQLException ex) {
            Logger.getLogger(UtilFunctions.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    public String cleanpost(String post)
    {
        Pattern script = Pattern.compile("<script.*?>.*?</script>");
        Matcher mscript = script.matcher(post);
        while (mscript.find())
        {
            post = mscript.replaceAll("");
        }
        post = post.replaceAll("<a href=h", "<a href=\"h");
        post = post.replaceAll("<div.*?>", "<p>");
        post = post.replaceAll("</div>", "</p>");
        post = post.replaceAll("<span.*?>", "<p>");
        post = post.replaceAll("</span>", "</p>");
        post = post.replaceAll("\\s+", " ");
        Pattern comment = Pattern.compile("<!--.*?-->");
        Matcher mcomment = comment.matcher(post);
        while (mcomment.find())
        {
            post = mcomment.replaceAll("");
        }
        Pattern style = Pattern.compile("<style.*?>.*?</style>");
        Matcher mstyle = style.matcher(post);
        while (mstyle.find())
        {
            post = mstyle.replaceAll("");
        }

        return post;
    }
}