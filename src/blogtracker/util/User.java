/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.util;


import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author skumar34
 */
public class User extends UtilFunctions
{
    String username;
    String email;
    int sendEmail;
    String watchTerms;

    public int isSendEmail() {
        return sendEmail;
    }

    public void setSendEmail(int sendEmail) {
        this.sendEmail = sendEmail;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getWatchTerms() {
        return watchTerms;
    }

    public void setWatchTerms(String watchTerms) {
        this.watchTerms = watchTerms;
    }

   public User()
    {
        username = "";
        email = "";
        sendEmail = 0;
        watchTerms = "";
    }
   public User(String uname)
    {
        username = uname;
    }

    public User(String uname, String iemail,int isendEmail) {
        username = uname;
        email = iemail;
        sendEmail = isendEmail;
    }

    public User getUser(String username)
    {
        try {
            User newuser = new User();
            Connection conn = getConn();//DriverManager.getConnection(constr);
            String querystr = "select * from User_Watches where username = '"+username+"'";
            Statement stmt = conn.createStatement();
            ResultSet rset = stmt.executeQuery(querystr);
            if(rset.next())
            {
                newuser.username  = username;
                newuser.email=  rset.getString("Email");
                newuser.sendEmail = rset.getInt("sendEmail");
                newuser.watchTerms = rset.getString("Watches");
                return newuser;
            }
            else
            {
                return null;
            }
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }

    }

}
