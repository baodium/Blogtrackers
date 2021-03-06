/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.util;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import oauth.signpost.OAuthConsumer;
import oauth.signpost.basic.DefaultOAuthConsumer;
import oauth.signpost.exception.OAuthCommunicationException;
import oauth.signpost.exception.OAuthExpectationFailedException;
import oauth.signpost.exception.OAuthMessageSignerException;

/**
 *
 * @author skumar34
 */
public class TwitterAuthenticate
{
    String consumerSecret;
    String consumerKey;
    double pin;
    String accessToken;
    String accessSecret;

    public TwitterAuthenticate()
    {
        setParameters();
    }

    private String TWITTER_SETTINGS_LOC;
    
    public void loadTwitterSettingsLocation()
    {
        BufferedReader br = null;
        try {
            //System.out.println(System.getProperty("user.dir"));
            HashMap<String,String> hm = new HashMap<String,String>();
            br = new BufferedReader(new FileReader("C:/Program Files (x86)/blazeds/tomcat/webapps/ROOT/WEB-INF/classes/authentication/blogtrackers.config"));
            String temp = "";
            while((temp = br.readLine())!=null)
            {
                temp = temp.trim();
                //System.out.println(temp);
                if(temp.isEmpty()||temp.startsWith("//"))
                {
                    continue;
                }
                else
                {
                    String[] arr = temp.split("##");
                    //System.out.println(arr[0]+" "+arr[1]);
                    if(arr.length==2)
                    {
                        hm.put(arr[0].trim(), arr[1].trim());
                    }
                }
            }
            if(!hm.isEmpty())
            {
                TWITTER_SETTINGS_LOC = hm.get("TwitterSettings");
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        }finally {
            try {
                br.close();
            } catch (IOException ex) {
               ex.printStackTrace();
            }

        }


    }

    public void setParameters()
    {
        consumerKey = "7UeRmPEyXG3a4lbIGOHmVQ";
        consumerSecret = "bRM2y6uGcDrfTOpxUS5l8LP1xDrgRVug8yYptCclJT8";
        accessToken = "20627637-21ybx54i0vuwHh8teNJ7STHRGOeo5TfMFnFYQhRKf";
        pin = 3809860;
        accessSecret = "ClkWhMmvGHo8CHFNHbXPOZKdMAKIYLeFVzaOHg74w";
    }

    public String getAccessSecret() {
        return accessSecret;
    }

    public void setAccessSecret(String accessSecret) {
        this.accessSecret = accessSecret;
    }

    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }

    public String getConsumerKey() {
        return consumerKey;
    }

    public void setConsumerKey(String consumerKey) {
        this.consumerKey = consumerKey;
    }

    public String getConsumerSecret() {
        return consumerSecret;
    }

    public void setConsumerSecret(String consumerSecret) {
        this.consumerSecret = consumerSecret;
    }

    public double getPin() {
        return pin;
    }

    public void setPin(double pin) {
        this.pin = pin;
    }

    public HttpURLConnection signRequest(HttpURLConnection huc)
    {
     
        OAuthConsumer consumer = new DefaultOAuthConsumer(getConsumerKey(),getConsumerSecret());
        consumer.setTokenWithSecret(getAccessToken(), getAccessSecret());
        try {
            consumer.sign(huc);
            return huc;
           
        } catch (OAuthMessageSignerException ex) {
            Logger.getLogger(TwitterAuthenticate.class.getName()).log(Level.SEVERE, null, ex);
        } catch (OAuthExpectationFailedException ex) {
            Logger.getLogger(TwitterAuthenticate.class.getName()).log(Level.SEVERE, null, ex);
        } catch (OAuthCommunicationException ex) {
            Logger.getLogger(TwitterAuthenticate.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

}
