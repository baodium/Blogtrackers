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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.TermFreqVector;

/**
 *
 * @author skumar34
 */
public class WatchListPane extends UtilFunctions
{

    public WatchListPane()
    {
        //empty constructor for flex
    }

    public ArrayList<String> addWatchTerms(String username, String terms)
    {
        try{
        String watchList="";
        Connection conn = getConn();
        Statement stmt = conn.createStatement();
        String QueryStr="Select Watches from User_Watches where UserName='"+username+"'";
        ResultSet rSet=stmt.executeQuery(QueryStr);
        if(rSet.next())
        {
           watchList=rSet.getObject("Watches").toString();
        }
        ArrayList<String> insertTerms = new ArrayList<String>();
        if(terms.indexOf(",")!=-1)
        {
            
            String[] watchTerms = terms.split(",");
            for(int j=0;j<watchTerms.length;j++)
            {
                insertTerms.add(watchTerms[j]);
            }
        }
        else
            insertTerms.add(terms);
        if(!insertTerms.isEmpty())
        {
            for(String curTerm:insertTerms)
            {
                if(watchList.indexOf(":"+curTerm+":") == -1)
                {
                 if(watchList.isEmpty())
                    {
                        watchList=":"+curTerm+":";
                    }
                 else
                    {
                        watchList = watchList+":"+curTerm+":";
                    }
                }
            }
                //System.out.println("shamanth-- text at watchlist= "+txtaddWatch.getText().trim());
                //System.out.println("shamanth-- watchlist now "+watchList.toString());
                 ArrayList<String> watch = new ArrayList<String>();
                if(!watchList.isEmpty())
                {
                    QueryStr="update User_Watches set Watches = \'"+watchList+"\' where UserName = '"+username+"'";
                    stmt.execute(QueryStr);
                    String[] watches = watchList.split("::");
                    for(int i=0;i<watches.length;i++)
                    {
                        if(i==0||i==watches.length-1)
                        {

                            watches[i] = watches[i].replace(":", "");
                            
                            watch.add(watches[i]);
                        }
                        else
                        {
                           
                            watch.add(watches[i]);
                        }
                    }
                    return watch;     
                }
        }
        return null;
        }catch(SQLException e)
        {
            return null;
        }
    }

    public ArrayList<String> getWatches(String username)
    {
        try{
            Connection conn = getConn();
        Statement stmt=conn.createStatement();
        String QueryStr="Select Watches from User_Watches where UserName='"+username+"'";
        ResultSet rSet=stmt.executeQuery(QueryStr);
        String watch="";
        while(rSet.next())
        {
            watch=rSet.getObject("Watches").toString();
            //System.out.println("shamanth-- watchlist"+watchList);
        }
        String[] watchList=watch.split("::");
        if(watchList.length>1)
        {
            
            watchList[0] = watchList[0].substring(1);
            watchList[watchList.length-1] = watchList[watchList.length-1].substring(0,watchList[watchList.length-1].length()-1);
        }
        else
        if(watchList[0].equals("")||watchList.length<1)
        {
            return null;
        }
        else
        if(watchList.length == 1&&!watchList[0].equals(""))
            {
                watchList[0] = watchList[0].substring(1,watchList[0].length()-1);
            }
        ArrayList<String> arr = new ArrayList<String>();
        for(int i=0;i<watchList.length;i++)
        {
            arr.add(watchList[i]);
        }
        return arr;
        }catch(SQLException e)
         {
            e.printStackTrace();
            return null;
         }
    }

    String alertIndexPath;
    String watchFilesPath;


    public boolean updateEmailNotify(boolean Notify,String username)
    {
        try{
            Connection conn = getConn();
            Statement stmt=conn.createStatement();
          
            String querystr = "";
            //System.out.println(Notify+" "+username);
            if(Notify)
              querystr = "update User_Watches set sendEmail = 1 where UserName = '"+username+"'";
            else
               querystr = "update User_Watches set sendEmail = 0 where UserName = '"+username+"'";
            stmt.execute(querystr);
            return true;

        }
        catch(SQLException ex)
        {
            return false;
        }
    }

    public boolean getPreference(String username)
    {
        try{
            Connection conn = getConn();
            Statement stmt=conn.createStatement();
            String querystr = "select sendEmail from User_Watches where UserName = '"+username+"'";
            ResultSet rset = stmt.executeQuery(querystr);
            if(rset.next())
            {
                //System.out.println(rset.getInt("sendEmail"));
                if(rset.getInt("sendEmail")==1)
                {
                    return true;
                }

            }
            return false;
        }
        catch(SQLException ex)
        {
            return false;
        }
    }

    public boolean updateWatchList(String[] WatchTerms, String username)
    {
        try{
            Connection conn = getConn();
            Statement stmt=conn.createStatement();
            String watchlist = "";
            if(WatchTerms.length>1)
            {
                for(String term:WatchTerms)
                {
                    watchlist = watchlist+":"+term+":";
                }
            }
            String querystr = "update User_Watches set Watches = '"+watchlist+"' where UserName = '"+username+"'";
            stmt.execute(querystr);
            return true;
            
        }
        catch(SQLException ex)
        {
            return false;
        }

    }

    public String getEmailAdd(String username)
    {
        try{
            Connection conn = getConn();
            Statement stmt=conn.createStatement();
            String email = "";
            String querystr = "select Email from User_Watches where UserName = '"+username+"'";
            ResultSet rset = stmt.executeQuery(querystr);
            if(rset.next())
            {
                return rset.getString("Email");
            }
            else
                return null;
        }
        catch(SQLException ex)
        {
            return null;
        }
    }

    public boolean updateEmailAdd(String email, String username)
    {
        try{
            Connection conn = getConn();
            Statement stmt=conn.createStatement();
            String querystr = "select Email from User_Watches where UserName = '"+username+"'";
            ResultSet rset =stmt.executeQuery(querystr);
            if(email.charAt(email.length()-1)!=',')
            {
                email = email+",";
            }
            if(rset.next())
            {
                String curemail = rset.getString("Email");
                if(!curemail.isEmpty())
                {
                    String[] emails = curemail.split(",");
                    if(emails.length>=1)
                    {
                        String[] toaddemail = email.split(",");
                        for(int i=0;i<toaddemail.length;i++)
                        {
                            if(toaddemail[i].isEmpty())
                            {
                                continue;

                            }
                            else
                                if(curemail.indexOf(toaddemail[i]+",")!=-1)
                                {
                                    continue;
                                }
                                else
                                    curemail = curemail+toaddemail[i]+",";
                        }
                        querystr = "update User_Watches set Email = '"+curemail+"' where UserName = '"+username+"'";
                        stmt.execute(querystr);

                    }
                }
                else
                if(!email.isEmpty())
                {
                    querystr = "update User_Watches set Email = '"+email+"' where UserName = '"+username+"'";
                    stmt.execute(querystr);
                }
            }
            
            return true;
          
        }
        catch(SQLException ex)
        {
            return false;
        }
    }

    public boolean removeEmailAdd(String email,String username)
    {
        try{
         Connection conn = getConn();
            Statement stmt=conn.createStatement();
            String querystr = "select Email from User_Watches where UserName = '"+username+"'";
            ResultSet rset =stmt.executeQuery(querystr);
            if(email.charAt(email.length()-1)!=',')
            {
                email = email+",";
            }
            if(rset.next())
            {
                String curemail = rset.getString("Email");
                if(!curemail.isEmpty())
                {
                    String[] emails = curemail.split(",");
                    if(emails.length>=1)
                    {
                        String[] torememail = email.split(",");
                        for(int i=0;i<torememail.length;i++)
                        {
                            if(torememail[i].isEmpty())
                            {
                                continue;
                            }
                            else
                                if(curemail.indexOf(torememail[i]+",")==-1)
                                {
                                    continue;
                                }
                                else
                                {
                                    String torem = torememail[i]+",";
                                    int loc = curemail.indexOf(torem);
                                    String part1 = curemail.substring(0,loc);
                                    String part2 = curemail.substring(loc+torem.length(),curemail.length());
                                    curemail = part1+part2;
                                }
                        }
                        querystr = "update User_Watches set Email = '"+curemail+"' where UserName = '"+username+"'";
                        stmt.execute(querystr);
                    }
                }
            }
          return true;

        }
        catch(SQLException ex)
        {
            return false;
        }

    }

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
//                alertIndexPath = hm.get("alertIndex");
//                watchFilesPath = hm.get("watchLoc");
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
//            alertIndexPath = confInstance.getValue("Indices", "alertIndex");
//            watchFilesPath = confInstance.getValue("WatchFilesLoc", "watchLoc");
//
//        } catch (JFigException ex) {
//            System.out.println("Configuration file Not found");
//        }
//    }


    public ArrayList<String> getAlerts()
    {

        ArrayList<String> alerts = new ArrayList<String>();
        try {
            loadConstants();
            alertIndexPath = hm.get("alertIndex");
            watchFilesPath = hm.get("watchLoc");
            IndexReader indRead = IndexReader.open(alertIndexPath);
            TermFreqVector tfv = indRead.getTermFreqVector(0, "content");
            String[] terms = tfv.getTerms();
            int[] freqs = tfv.getTermFrequencies();
            if(terms.length == freqs.length)
            {
                tags[] tf = new tags[freqs.length];
                for( int k=0;k<freqs.length;k++)
                {
                    tf[k] = new tags();
                    tf[k].value = freqs[k];
                    tf[k].key = terms[k];
                }
                Arrays.sort(tf, Collections.reverseOrder());

                for(int i=0;i<25;i++)
                {
                    alerts.add(tf[i].key);
                }
                indRead.close();

                //System.out.println("shamanth sorted");

            }
            return alerts;
        } catch (CorruptIndexException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public List<Post> getBlogPosts(String username)
    {
        try {
            loadConstants();
            alertIndexPath = hm.get("alertIndex");
            watchFilesPath = hm.get("watchLoc");
            List<Post> posts = new ArrayList<Post>();
            BufferedReader bRead = new BufferedReader(new FileReader(watchFilesPath + username + ".post"));
            String postDetails = "";
            while ((postDetails = bRead.readLine()) != null)
                {
                    String[] rpost = postDetails.split("##");
                    Post p = new Post();
                    p.blogger = rpost[0];
                    p.title = rpost[1];
                    posts.add(p);
                }
            return posts;
        } catch (IOException ex) {
           ex.printStackTrace();
        }
        return null;
    }

    public boolean deleteWatches(String[] watchterms, String username)
    {

        try{
      
        Connection conn = getConn();
        
        String QueryStr="Select Watches from User_Watches where UserName= ?";
        PreparedStatement pstmt = conn.prepareStatement(QueryStr);
        pstmt.setString(1, username);
        ResultSet rSet=pstmt.executeQuery();
        String finalStr ="";
        if(rSet.next())
        {
           finalStr = rSet.getObject("Watches").toString();
        }


        for(String term: watchterms)
        {
  
            String txtToDelete = ":";
            if(!term.isEmpty())
            {
             txtToDelete += term+":";
             if(finalStr.indexOf(txtToDelete) != -1 && finalStr.indexOf(txtToDelete.substring(1)) != -1)
                {
                    int loc = finalStr.indexOf(txtToDelete);
                    String tempstr = finalStr.substring(0, loc);
                    tempstr = tempstr+finalStr.substring(loc+txtToDelete.length(), finalStr.length());
                    finalStr = tempstr;
                    //System.out.println(finalStr);
                }
            }
       }
        QueryStr = "update User_Watches set Watches='"+finalStr+"' where UserName='"+username+"'";
        pstmt = conn.prepareStatement(QueryStr);
        pstmt.execute();
        return true;
       }catch(SQLException e)
        {
           return false;
        }
    }

    public String getPost(String posttitle, String username)
    {
         try {
            loadConstants();
            alertIndexPath = hm.get("alertIndex");
            watchFilesPath = hm.get("watchLoc");
            BufferedReader bRead = new BufferedReader(new FileReader(watchFilesPath + username + ".post"));
            String postDetails = "";
            while ((postDetails = bRead.readLine()) != null)
                {

                    String[] rpost = postDetails.split("##");
                    if(rpost.length==3)
                    {
                        if(rpost[1].equals(posttitle))
                        {
                            if(!rpost[2].isEmpty())
                            {
                                return cleanpost(rpost[2]);
                            }
                        }

                    }
                }
            return null;
            
        } catch (IOException ex) {
            return null;
        }
        
    }

}
