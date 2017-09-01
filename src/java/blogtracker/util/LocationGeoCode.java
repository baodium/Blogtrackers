/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.logging.Level;
import java.util.logging.Logger;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import java.util.List;
import net.sf.json.JSONException;

/**
 * Accepts user location from flex and geocodes(lat,long conversion) the input
 * @author skumar34
 */
public class LocationGeoCode
{

    public LocationGeoCode()
    {
        //empty constructor for Flex instantiation
    }

//    public String readHTML(String URL, boolean authenticate)
//	{
//
//
//            URL url = null;
//            try
//            {
//                url = new URL(URL);
//            }
//            catch ( MalformedURLException e)
//            {
//                e.printStackTrace();
//            }
//            StringBuffer page = new StringBuffer();
//            try
//            {
//                HttpURLConnection huc = (HttpURLConnection) url.openConnection();;
//                if(authenticate)
//                {
//                    TwitterAuthenticate ta = new TwitterAuthenticate();
//                    huc = ta.signRequest(huc);
//                }
//                //huc.setRequestProperty("User-Agent", "Mozilla/4.5");
//                if(huc.getResponseCode()==400||huc.getResponseCode()==404)
//                {
//                     return "404";
//                }
//                huc.connect();
//
//                BufferedReader bRead = new BufferedReader(new InputStreamReader((InputStream) huc.getContent()));
//                String temp=null;
//                 while( (temp= bRead.readLine())!=null)
//                  {
//                     page.append(temp);
//                  }
//                  bRead.close();
//            }
//            catch (IOException e) {
//                e.printStackTrace();
//            }
//            return page.toString();
//	}
//
//    public ArrayList<UserLocation> translatelocations(ArrayList<UserLocation> users)
//     {
//        ArrayList<UserLocation> transusers = new ArrayList<UserLocation>();
//        for(int i=0;i<users.size();i++)
//        {
//            String loc = users.get(i).location;
//            if(loc!=null&&!loc.isEmpty())
//            {
//                UserLocation usr  = new UserLocation();
//                usr.username = users.get(i).username;
//                usr.location = users.get(i).location;
//                usr.tweet = users.get(i).tweet;
//                loc = loc.replaceAll("\\s+", "");
//                //System.out.println(loc);
//                String url = "http://maps.googleapis.com/maps/api/geocode/json?address="+loc+"&sensor=false";
//                String page = readHTML(url,false);
//                if(page!=null&&!page.equals("404"))
//                {
//                    JSONObject json = (JSONObject) JSONSerializer.toJSON(page);
//                    JSONArray results =  json.getJSONArray("results");
//                    if(results.size()>0)
//                    {
//                        JSONObject geometry = results.getJSONObject(0).getJSONObject("geometry");
//                        JSONObject location = geometry.getJSONObject("location");
//                        usr.latitude = location.getDouble("lat");
//                        usr.longitude = location.getDouble("lng");
//                    }
//                    transusers.add(usr);
//                }
//            }
//        }
//        return transusers;
//    }
//
//    public String getProfileLocation(String username)
//    {
//        BufferedReader bRead = null;
//        //System.out.println("processing profile of user = "+username);
//        String url = "http://api.twitter.com/1/users/show.json?screen_name="+username;
////        String encURL = url;
////        try {
////            encURL = URLEncoder.encode(url, "UTF-8");
////        } catch (UnsupportedEncodingException ex) {
////            //Logger.getLogger(LocationGeoCode.class.getName()).log(Level.SEVERE, null, ex);
////        }
//        String page = readHTML(url,true);
//        //System.out.println(page);
//        if(page!=null&&!page.equals("404"))
//        {
//            JSONObject json = (JSONObject) JSONSerializer.toJSON(page);
//            String location =  json.getString("location");
//            return location;
//        }
//        return null;
//    }
//
//    public ArrayList<UserLocation> getProfileLocations(ArrayList<UserLocation> users)
//    {
//        ArrayList<UserLocation> newusers = new ArrayList<UserLocation>();
//        for(int i=0;i<users.size();i++)
//        {
//            //System.out.println(users.get(i).tweet);
//             UserLocation tempuser = new UserLocation();
//             tempuser.location = getProfileLocation(users.get(i).username);
//             tempuser.tweet = users.get(i).tweet;
//             tempuser.username = users.get(i).username;
//             newusers.add(tempuser);
//        }
//        return translatelocations(newusers);
//    }

//    public static void main(String[] args)
//    {
//        LocationGeoCode lc = new LocationGeoCode();
//        ArrayList<UserLocation> ul = new ArrayList<UserLocation>();
//        UserLocation uli = new UserLocation();
//        uli.username = "skumar34";
//        ul.add(uli);
//        uli = new UserLocation();
//        uli.username = "jasoncalacanis";
//        ul.add(uli);
//        uli = new UserLocation();
//        uli.username = "MSF_usa";
//        ul.add(uli);
////        uli = new UserLocation();
////        uli.username = "ClaraJefferey";
//        //ul.add(uli);
//        uli = new UserLocation();
//        uli.username = "trisha2767";
//        ul.add(uli);
//        uli = new UserLocation();
//        uli.username = "Kenold";
//        ul.add(uli);
//        uli = new UserLocation();
//        uli.username = "lajornada";
//        ul.add(uli);
////        uli = new UserLocation();
////        uli.username = "bapliving";
////        ul.add(uli);
//        uli = new UserLocation();
//        uli.username = "Kenold";
//        ul.add(uli);
////        uli = new UserLocation();
////        uli.username = "ClaraJefferey";
////        ul.add(uli);
////        uli = new UserLocation();
////        uli.username = "gailbear25";
////        ul.add(uli);
//        List<UserLocation> temp = lc.getProfileLocations(ul);
//        for(UserLocation usr:temp)
//        {
//            System.out.println(usr.latitude+" "+usr.longitude);
//        }
//    }

    List<UserLocation> allUsers = Collections.synchronizedList(new ArrayList<UserLocation>());
    List<UserLocation> processedUsers = Collections.synchronizedList(new ArrayList<UserLocation>());
    private int NO_OF_WORKERS = 4;
    public int COUNTER = 0;
    private int WORK_DONE = 0;
    //No of users assigned to each worker
    private int NO_PROCESSING = 15;

    public List<UserLocation> getProfileLocations(ArrayList<UserLocation> users)
    {
        allUsers = users;
        for(int i=0;i<NO_OF_WORKERS;i++)
        {
            new WorkerThread();
        }
        while(!checkDone())
        {
           
        }
        return processedUsers;
    }

    public boolean checkDone()
    {
         if(WORK_DONE==NO_OF_WORKERS)
         {
            return true;
         }
         else
             return false;
    }
    public synchronized void updateDone()
    {
         WORK_DONE++;
    }

    public synchronized void updateCounter(int updateVal)
    {
        COUNTER = COUNTER+updateVal;
    }

    public synchronized UserLocation[] loadUsers()
    {
        if(COUNTER == allUsers.size())
        {
            return null;
        }
        if((allUsers.size()-COUNTER)<=NO_PROCESSING)
        {
            UserLocation[] nextusers = new UserLocation[allUsers.size()-COUNTER];
            int count = 0;
            for(int i=COUNTER;i<allUsers.size();i++)
            {
                UserLocation ul = (UserLocation) allUsers.get(i);
                nextusers[count] = ul;
            }
            updateCounter(nextusers.length);
            return nextusers;
        }
        else
        {
            UserLocation[] nextusers = new UserLocation[NO_PROCESSING];
            int count = 0;
            for(int i=COUNTER;i<COUNTER+NO_PROCESSING;i++)
            {
                UserLocation ul = (UserLocation) allUsers.get(i);
                nextusers[count++] = ul;

            }
            updateCounter(NO_PROCESSING);
            return nextusers;
        }
        
    }

    public synchronized void UpdateUsers(ArrayList<UserLocation> users)
    {
        for(UserLocation user:users)
        {
            //System.out.println("username"+user.username);
            processedUsers.add(user);
        }
    }

class WorkerThread implements Runnable
    {
        UserLocation[] users;
        Thread t;
        WorkerThread()
        {
            t = new Thread(this);
            t.start();

        }

        public void run()
        {
            while(true)
            {
                users = loadUsers();
                if(users==null)
                {
                    updateDone();
                    break;
                }
                else
                {
                    ArrayList<UserLocation> processingUsers = new ArrayList<UserLocation>();
                    for(int i=0;i<users.length;i++)
                    {
                        if(users[i]==null)
                        {
                            continue;
                        }
                       UserLocation tempuser = new UserLocation();
                       String loc = getProfileLocation(users[i].username);
                       if(loc==null)
                       {
                           continue;
                       }
                       tempuser.location = loc;
                       tempuser.tweet = users[i].tweet;
                       tempuser.username = users[i].username;
                       processingUsers.add(tempuser);
                    }
                    //System.out.println(processingUsers.size());
                    UpdateUsers(translatelocations(processingUsers));
                }
            }
        }

        public ArrayList<UserLocation> translatelocations(ArrayList<UserLocation> users)
        {
        ArrayList<UserLocation> transusers = new ArrayList<UserLocation>();
        for(int i=0;i<users.size();i++)
        {
            String loc = users.get(i).location;
            if(loc!=null&&!loc.isEmpty())
            {
                UserLocation usr  = new UserLocation();
                usr.username = users.get(i).username;
                usr.location = loc;
                usr.tweet = users.get(i).tweet;
                String encodedLoc="";
                try {
                     encodedLoc = URLEncoder.encode(loc, "UTF-8");
                } catch (UnsupportedEncodingException ex) {
                    Logger.getLogger(LocationGeoCode.class.getName()).log(Level.SEVERE, null, ex);
                }
                 
                //loc = loc.replaceAll("\\s+", "");
                //System.out.println(loc);
                //String url = "http://maps.googleapis.com/maps/api/geocode/json?address="+loc+"&sensor=false";
                String url = "http://nominatim.openstreetmap.org/search?q="+encodedLoc+"&format=json";
                String page = readHTML(url,false);
                if(page!=null&&!page.equals("404"))
                {
                    //JSONObject json = (JSONObject) JSONSerializer.toJSON(page);
                    //JSONArray results =  json.getJSONArray("results");
                    try{
                        JSONArray results = (JSONArray) JSONSerializer.toJSON(page);
                        //JSONObject results =  json.getJSONObject(0);
                        if(results.size()>0)
                        {
                            //JSONObject geometry = results.getJSONObject(0).getJSONObject("geometry");
                            //JSONObject location = geometry.getJSONObject("location");
                            usr.latitude = results.getJSONObject(0).getDouble("lat");
                            //usr.longitude = results.getJSONObject(0).getDouble("lng");
                            usr.longitude = results.getJSONObject(0).getDouble("lon");
                        }
                        transusers.add(usr);
                    }catch(JSONException ex)
                    {
                        
                    }
                }
            }
        }
        return transusers;
        }

        public synchronized String readHTML(String URL, boolean authenticate)
	{
            URL url = null;
            try
            {
               
                url = new URL(URL);

            }
            catch ( MalformedURLException e)
            {
                e.printStackTrace();
            }
            StringBuffer page = new StringBuffer();
            try
            {
                HttpURLConnection huc = (HttpURLConnection) url.openConnection();;
                if(authenticate)
                {
                    TwitterAuthenticate ta = new TwitterAuthenticate();
                    huc = ta.signRequest(huc);
                }
                huc.setRequestProperty("User-Agent", "Mozilla/4.5");
//                if(huc.getResponseCode()==200)
//                {
//                    System.out.println("200");
//                }
                if(huc.getResponseCode()==400||huc.getResponseCode()==404)
                {
                     return "404";
                }
                huc.connect();

                BufferedReader bRead = new BufferedReader(new InputStreamReader((InputStream) huc.getContent()));
                String temp=null;
                 while( (temp= bRead.readLine())!=null)
                  {
                     page.append(temp);
                  }
                  bRead.close();
            }
            catch (IOException e) {
                e.printStackTrace();
            }
            return page.toString();
	}

        
         public String getProfileLocation(String username)
        {
            BufferedReader bRead = null;
            //System.out.println("processing profile of user = "+username);
             String encodeduname="";
                try {
                     encodeduname = URLEncoder.encode(username, "UTF-8");
                } catch (UnsupportedEncodingException ex) {
                    Logger.getLogger(LocationGeoCode.class.getName()).log(Level.SEVERE, null, ex);
                }
            String url = "http://api.twitter.com/1/users/show.json?screen_name="+encodeduname;
    //        String encURL = url;
    //        try {
    //            encURL = URLEncoder.encode(url, "UTF-8");
    //        } catch (UnsupportedEncodingException ex) {
    //            //Logger.getLogger(LocationGeoCode.class.getName()).log(Level.SEVERE, null, ex);
    //        }
            String page = readHTML(url,true);
            //System.out.println(page);
            try{
            if(page!=null&&!page.equals("404"))
            {
                JSONObject json = (JSONObject) JSONSerializer.toJSON(page);
                String location =  json.getString("location");
                return location;
            }
            }catch(JSONException ex)
            {
                
            }
            return null;
        }
    }
}