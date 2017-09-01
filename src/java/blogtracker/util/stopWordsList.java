/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package blogtracker.util;

import java.io.*;
import java.util.*;

/**
 *
 * @author alan
 */
public class stopWordsList {
    public static String[] stopwords;
    static String fileName;


     public static void loadGlobalConstants()
    {

        BufferedReader br = null;
        try {
            //System.out.println(System.getProperty("user.dir"));
            HashMap<String,String> hm = new HashMap<String,String>();
            br = new BufferedReader(new FileReader("C:/blazeds/tomcat/webapps/ROOT/WEB-INF/classes/authentication/blogtrackers.config"));
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
               fileName = hm.get("stopWords");

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

//    public static void loadGlobalConstants()
//    {
//        try {
//            JFigLocatorIF locator = new blogtracker.util.LocalJFigLocator("config/", "config.xml");
//            JFigIF confInstance = org.igfay.jfig.JFig.getInstance(locator);
//            fileName = confInstance.getValue("stopWords", "loc");
//
//        } catch (JFigException ex) {
//            System.out.println("Configuration file Not found");
//        }
//    }
     
    public static void fillStopWordsList()
    {
        loadGlobalConstants();
        //String fileName="C:\\Program Files (x86)\\blazeds\\tomcat\\webapps\\blazeds\\BlogTracker\\stopwords.txt";
     
     ArrayList<String> strList=new ArrayList<String>();
     boolean flag=true;
     
     try{
     BufferedReader bInput=new BufferedReader(new FileReader(fileName));
     do
     {
      try   
      {
          if(!bInput.ready())
              break;
           String[] wordsList=bInput.readLine().split(",");
           if(wordsList!=null)
            {
                for(String str: wordsList)
                   {
                    if(str.isEmpty())
                        continue;
                    strList.add(str);
                   }
            }
            else
               flag=false;
      }
      catch(Exception e)
      {
         e.printStackTrace(); //do nothing end of file reached.
      }
      
     }while(flag);
         stopwords=new String[strList.size()];
       strList.toArray(stopwords); 
    }
     catch(Exception e)
     {
         e.printStackTrace();
     }
    }
}
