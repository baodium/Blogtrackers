/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.gui.blogtrackers;

import blogtracker.util.Mailing;
import javax.mail.MessagingException;
/**
 *
 * @author skumar34
 */
public class suggestSite
{

    public suggestSite()
    {
        //empty constructor for Flex
    }

    public boolean sendEmail(String name,String url, String addtlinfo)
    {
        
        StringBuffer message = new StringBuffer();
        message = message.append("Name: "+name+"\n"+"URL: "+url+"\n Info: "+addtlinfo);
        String[] recipient = {"shamanth00@gmail.com"};
        try {
            //System.out.println(message.toString());
            Mailing.postMail(recipient, "New Site Info", message.toString());
            return true;
        } catch (MessagingException ex) {
            ex.printStackTrace();
            return false;
        }

    }

}
