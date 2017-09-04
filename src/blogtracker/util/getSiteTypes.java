/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author skumar34
 */
public class getSiteTypes extends UtilFunctions
{
    public getSiteTypes()
    {
        
    }

    public ArrayList<SiteType> getsitetypes()
    {
        ArrayList<SiteType> sitetypes = new ArrayList<SiteType>();
        try {

            Connection conn = getConn();
            //System.out.println("site types retrieving");
            Statement stmt = conn.createStatement();
            SiteType st = new SiteType();
            st.setId(0);
            st.setType("Select a category below");
            sitetypes.add(st);
            String queryStr = "select SiteType_ID,Type_name from sitetypes";
            ResultSet rset = stmt.executeQuery(queryStr);
            while(rset.next())
            {

                String sitename = rset.getString("Type_name");
                int sitetype = rset.getInt("SiteType_ID");
                //System.out.println(sitename);
                st = new SiteType();
                st.setId(sitetype);
                st.setType(sitename);
                sitetypes.add(st);
            }
            conn.close();
            st = new SiteType();
            st.setId(9999);
            st.setType("All blogs");
            sitetypes.add(st);
            st = new SiteType();
            st.setId(9998);
            st.setType("All tweets");
            sitetypes.add(st);
            //System.out.println(sitetypes.size());
            return sitetypes;
        } catch (SQLException ex) {
            ex.printStackTrace();
            //Logger.getLogger(getSiteTypes.class.getName()).log(Level.SEVERE, null, ex);
            return new ArrayList<SiteType>();
        }
    }

    public boolean AddNewSiteType(String stypename,ArrayList<Integer> selectedsites)
    {
        Connection conn = null;
        try{
            System.out.println(stypename);
            System.out.println(selectedsites.get(0));
            System.out.println(selectedsites.get(1));
            conn = getConn();
            Statement stmt = conn.createStatement();
            String querystr = "select Type_name from sitetypes where Type_name = '"+stypename+"'";
            ResultSet rset = stmt.executeQuery(querystr);
            if(rset.next())
            {
                return false;
            }
            //category name is not duplicate so proceed.
            stmt.close();
            Statement sitetypestmt = conn.createStatement();
            querystr = "insert into sitetypes(Type_name,Type_label) values('"+stypename+"','"+stypename+"')";
            sitetypestmt.execute(querystr);
            sitetypestmt.close();
            stmt = conn.createStatement();
            querystr = "select SiteType_ID from sitetypes where Type_name = '"+stypename+"'";
            rset = stmt.executeQuery(querystr);
            if(rset.next())
            {
                int sitetype = rset.getInt("SiteType_ID");

                Statement sitestmt = conn.createStatement();
                //update the blogsite type of all the selected sites
                for(int i=0;i<selectedsites.size();i++)
                {
                    String newquery  = "select site_type from blogsites where blogsite_id = "+selectedsites.get(i);
                    ResultSet siterset = sitestmt.executeQuery(newquery);
                    if(siterset.next())
                    {
                        String bssitetype = siterset.getString("site_type");
                        if(bssitetype.indexOf(":"+sitetype+":")==-1)
                        {
                            bssitetype = bssitetype+":"+sitetype+":";
                            newquery = "update blogsites set site_type = '"+bssitetype+"' where blogsite_id = "+selectedsites.get(i);
                            Statement updatestmt = conn.createStatement();
                            updatestmt.execute(newquery);
                            updatestmt.close();
                        }
                        
                    }
                }

                
            }
            stmt.close();
            conn.close();
            //new sitetype added and all the related sites modified.
            return true;
        }catch(SQLException ex)
        {
            ex.printStackTrace();
            try {
                conn.close();
            } catch (SQLException ex1) {
                Logger.getLogger(getSiteTypes.class.getName()).log(Level.SEVERE, null, ex1);
            }
            return false;
        }
    }


    /***
     *
     * DEBUG purposes only, comment for release version
     *
     * @param args
     */
//    public static void main(String[] args)
//    {
//        getSiteTypes gst = new getSiteTypes();
//        ArrayList<Integer> site = new ArrayList<Integer>();
//        site.add(68);
//        site.add(101);
//        gst.AddNewSiteType("Female Tunisian Blogger", site);
//    }
}

