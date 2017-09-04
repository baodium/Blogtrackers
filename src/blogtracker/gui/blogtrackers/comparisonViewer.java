/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.gui.blogtrackers;

import blogtracker.util.UtilFunctions;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author skumar34
 */
public class comparisonViewer extends UtilFunctions
{
    public comparisonViewer()
    {
        
    }

    public List<BPost> fillblogposts1(java.util.Date istartDate, java.util.Date iendDate, int selFID)
    {
        try {
            SimpleDateFormat dformat = new SimpleDateFormat("yyyy-MM-dd");
            //System.out.println(selFID);
            List<BPost> posts = new ArrayList<BPost>();
            String startDate = dformat.format(istartDate);
            String endDate = dformat.format(iendDate);
            Connection conn = getConn();
            Statement stmt = conn.createStatement();
            String querystr = "select blogpost_id,title from blogposts where blogsite_id =" + selFID + " and (date >= '" + startDate +  "' AND date <= '" + endDate + "') ORDER BY date";
           // System.out.println(querystr);
            ResultSet rset = stmt.executeQuery(querystr);
            while (rset.next()) 
            {
               //System.out.println("in loop");
               BPost bp = new BPost(rset.getInt("blogpost_id"),rset.getString("title"),"","");
               posts.add(bp);

            }
            rset.close();
            conn.close();
           // System.out.println("inside "+posts.size());
            return posts;
        } catch (SQLException ex) {
            //Logger.getLogger(comparisonViewer.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        
    }

    public String fgetPost(int postID)
    {
        //System.out.println(postID);
        String post =  getBlogPost(postID);
        return post;
    }

    public String sgetPost(int postID)
    {
        //System.out.println(postID);
        String post =  getBlogPost(postID);
        return post;
    }

    public List<BPost> fillblogposts2(java.util.Date istartDate, java.util.Date iendDate, int selSID)
    {
        try {
            //System.out.println("second"+selSID);
            SimpleDateFormat dformat = new SimpleDateFormat("yyyy-MM-dd");
            String startDate = dformat.format(istartDate);
            String endDate = dformat.format(iendDate);
            Connection conn = getConn();
            List<BPost> posts = new ArrayList<BPost>();
            String querystr = "select title,blogpost_id from blogposts where blogsite_id =" + selSID + " and date between '" + startDate + "' and '" + endDate + "'";
            Statement stmt = conn.createStatement();
            ResultSet rset = stmt.executeQuery(querystr);
            while (rset.next()) {
                BPost bp = new BPost(rset.getInt("blogpost_id"), rset.getString("title"),"","");
                posts.add(bp);
            }
            rset.close();
            conn.close();
            return posts;
        } catch (SQLException ex) {
            //Logger.getLogger(comparisonViewer.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
      
   }


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
}
