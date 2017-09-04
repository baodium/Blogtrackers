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
import java.util.Date;
import java.util.List;

/**
 *
 * @author skumar34
 */
public class getBlogBrowserData extends UtilFunctions{

    public String getPost(int postID)
    {
        //System.out.println(postID);
        String post =  getBlogPost(postID);
        return post;
    }

    public getBlogBrowserData()
    {
        //empty constructor for Flex
    }

    public List<BlogPost> getBlogPosts(Date startDate, Date endDate, ArrayList<Integer> selSites)
    {
   
        List<BlogPost> posts = new ArrayList<BlogPost>();
        String selSitesQuery = getSelSitesQuery(selSites);
        Date sDate = startDate;
        Date eDate = endDate;
        //System.out.println(sDate);
        //uSystem.out.println(eDate);
        try{
             SimpleDateFormat sdform = new java.text.SimpleDateFormat();
             sdform.applyPattern("yyyy-MM-dd");
             String queryStr = "SELECT date, title, blogger, blogsite_id, categories, num_comments as '#comments', blogpost_id AS id " +
                "FROM blogposts " +
                "WHERE "+selSitesQuery+" (date >= '" + sdform.format(sDate) + "' AND date <= '" + sdform.format(eDate) + "') ORDER BY date";
             Connection conn = getConn();
             Statement stmt = conn.createStatement();
             ResultSet rset = stmt.executeQuery(queryStr);
             while(rset.next())
             {
                 String title = rset.getString("title");
                 String blogger = rset.getString("blogger");
                 String categories = rset.getString("categories");
                 int nocomments = rset.getInt("#comments");
                 int id = rset.getInt("id");
                 int blogsiteid = rset.getInt("blogsite_id");
                 BlogPost post = new BlogPost(title,blogger,categories,nocomments, id,blogsiteid,"",new Date());
                 posts.add(post);
             }
             conn.close();
             return posts;
         }catch(SQLException e)
         {
             e.printStackTrace();
             
         }
         return null;
    }

    /*
     * Translating text using Google Translate
     *
     */
//    public String getTransText(String text)
//    {
//
//            URL url = null;
//            String enctext = encodeURL(text);
//            try {
//                url = new URL("http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q="+enctext+"&langpair=%7Cen");
//            } catch (MalformedURLException ex) {
//                ex.printStackTrace();
//            }
//            URLConnection connection = null;
//            if (url != null) {
//                try {
//                    connection = url.openConnection();
//                    connection.addRequestProperty("Referer", "http://blogtrackers.fulton.asu.edu");
//                } catch (IOException ex) {
//                    ex.printStackTrace();
//                }
//            }
//            String line;
//            StringBuilder builder = new StringBuilder();
//            BufferedReader reader = null;
//            if (connection != null) {
//                try {
//                    reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
//                } catch (IOException ex) {
//                    ex.printStackTrace();
//                }
//            }
//            if(reader!=null)
//            {
//                try{
//
//                    while ((line = reader.readLine()) != null)
//                    {
//                        builder.append(line);
//                    }
//                    JSONObject json = new JSONObject(builder.toString());
//                    JSONObject response = json.getJSONObject("responseData");
//                    String transText = response.getString("translatedText");
//                    return transText;
//                }catch(IOException ex)
//                {
//                    Logger.getLogger(getBlogBrowserData.class.getName()).log(Level.SEVERE, null, ex);
//                }catch (JSONException ex) {
//                    ex.printStackTrace();
//                }
//            }
//            return "";
//    }
//
//    public String encodeURL(String text)
//    {
//        String tempText="";
//        try {
//            tempText = java.net.URLEncoder.encode(text, "UTF-8");
//        } catch (UnsupportedEncodingException ex) {
//            Logger.getLogger(getBlogBrowserData.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return tempText;
//    }


//    public static void main(String[] args)
//    {
//        getBlogBrowserData br= new getBlogBrowserData();
//        System.out.println(br.getTransText("this  place!2#$' \" ' ? / % "));
//    }

}
