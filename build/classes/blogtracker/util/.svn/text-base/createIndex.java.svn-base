/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.util;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
//import org.apache.lucene.analysis.Analyzer;

import org.apache.lucene.index.IndexWriter;
import java.sql.*;
import java.util.Calendar;
import org.apache.lucene.analysis.StopAnalyzer;
import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.store.LockObtainFailedException;
/**
 *
 * @author Shamanth
 */
public class createIndex {
    
private String SEARCH_INDEX; 
private java.sql.Connection conn;
//private String databaseConnectionString;
private IndexWriter totalIndex;
private StopAnalyzer analyzer;
private blogtracker.util.sysResource sysRes;
    
 public void setResource(blogtracker.util.sysResource sysRes) {
        this.sysRes = sysRes;
    }
 
 public createIndex (boolean isNew)
 {
     SEARCH_INDEX = "C:\\Program Files (x86)\\blazeds\\tomcat\\webapps\\blazeds\\BlogTracker\\blogtrackers-index";
     //databaseConnectionString="jdbc:sqlserver://149.169.226.79:1433;instanceName=DMMLASU;databaseName=blogtracker;user=trackerapp;password=number123";
     try{
            //Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            //conn = DriverManager.getConnection(sysRes.databaseConnectionString);
            blogtracker.util.stopWordsList.fillStopWordsList();
            analyzer = new StopAnalyzer(blogtracker.util.stopWordsList.stopwords);
            IndexWriter.MaxFieldLength mfl = new IndexWriter.MaxFieldLength(IndexWriter.DEFAULT_MAX_FIELD_LENGTH); //Default is 10000. new indexwriter call replace existing with this.
            totalIndex = new IndexWriter(SEARCH_INDEX,analyzer,isNew, mfl);
           // System.out.println("shamanth -- index isnew="+isNew);
       }catch(Exception e)
        {
            e.printStackTrace();
        }
 }
 
 public void createAlertIndex()
 {
     try{
            Calendar cal=Calendar.getInstance();
            int endMonth = cal.get(Calendar.MONTH)+1;
            int endYear = cal.get(Calendar.YEAR);
            int startYear = endYear;
            int startMonth = 1;
            //System.out.println("shamanth-- year = "+cal.get(Calendar.YEAR) +cal.get(Calendar.MONTH));
            if(endMonth<=5)
            {
                startYear = endYear-1;
                startMonth = 12 - (6-endMonth);
            }
            else
            {
                startMonth = endMonth - 6;
            }
            String startdate = startMonth+"/01/" + startYear;
            int currentday = cal.get(Calendar.DAY_OF_MONTH);
            String cday = ""+currentday;
            if (currentday<10)
                 cday = "0"+currentday;
            
            String enddate = endMonth+"/"+cday+"/" + endYear;
            String alertIndexPath = "./index3";
            String queryStr = "select tags from blogposts where date between '"+startdate + "' and '"+enddate+"'";
            conn = DriverManager.getConnection(sysRes.databaseConnectionString);
            Statement stmt = conn.createStatement();
            ResultSet rSet = stmt.executeQuery(queryStr);
            blogtracker.util.stopWordsList.fillStopWordsList();
            StopAnalyzer analyzer = new StopAnalyzer(blogtracker.util.stopWordsList.stopwords);
            IndexWriter.MaxFieldLength mfl = new IndexWriter.MaxFieldLength(IndexWriter.DEFAULT_MAX_FIELD_LENGTH); //Default is 10000. new indexwriter call replace existing with this.
            IndexWriter alertIndex = new IndexWriter(alertIndexPath, analyzer, true, mfl);
            Document doc = new Document();
            String allPostContent = "";
            while (rSet.next()) {
                String postText = rSet.getString("tags");
                if(postText!=null)
                {
                    String[] text = postText.split(",");
                    for(int i=0;i<text.length;i++)
                    {
                        allPostContent = allPostContent + text[i]+" ";
                    }
                }
            }
            conn.close();
            Field docField = new Field("content", allPostContent, Field.Store.YES, Field.Index.ANALYZED, Field.TermVector.YES);
            doc.add(docField);
            alertIndex.addDocument(doc);
            alertIndex.optimize();
            alertIndex.close();
        } 
        catch (CorruptIndexException ex) {
            ex.printStackTrace();
        } catch (LockObtainFailedException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
           ex.printStackTrace();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
 }
 
public  void createTotalIndex()
        {
            String queryStr = "SELECT blogpost_id, title, blogger, categories, post, date  " +
                        "FROM blogposts " +
                        "ORDER BY date DESC";
             try{
                conn = DriverManager.getConnection(sysRes.databaseConnectionString);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(queryStr);
                String id=new String();
                String title=new String();
                String blogger=new String();
                String categories=new String();
                String post=new String();
                String date=new String();
                while(rs.next())
                {
                        id=String.valueOf(rs.getObject(1));
                        title=rs.getObject(2).toString();
                        blogger=rs.getObject(3).toString();
                        categories=rs.getObject(4).toString();
                        post=blogtracker.util.StringUtil.stripHTMLTags(rs.getObject(5).toString());
                        date=rs.getObject(6).toString();
                        Document tempDoc=new Document();
                        Field docField=new Field("id",id,Field.Store.YES,Field.Index.NOT_ANALYZED,Field.TermVector.NO);
                        tempDoc.add(docField);
                        docField=new Field("title",title,Field.Store.YES,Field.Index.NOT_ANALYZED,Field.TermVector.NO);
                        tempDoc.add(docField);
                        docField=new Field("blogger",blogger,Field.Store.YES,Field.Index.NOT_ANALYZED,Field.TermVector.NO);
                        tempDoc.add(docField);
                        docField=new Field("categories",categories,Field.Store.YES,Field.Index.NOT_ANALYZED,Field.TermVector.NO);
                        tempDoc.add(docField);
                        docField=new Field("content",post,Field.Store.YES,Field.Index.ANALYZED,Field.TermVector.YES);
                        tempDoc.add(docField);
                        docField=new Field("date",date,Field.Store.YES,Field.Index.NOT_ANALYZED,Field.TermVector.NO);
                        tempDoc.add(docField);
                        totalIndex.addDocument(tempDoc);
                         
                }
                totalIndex.optimize();
                totalIndex.close();
                conn.close();
            } catch (SQLException ex) {
            ex.printStackTrace();
            Logger.getLogger(createIndex.class.getName()).log(Level.SEVERE, null, ex);
        }catch(IOException e)
            {
                e.printStackTrace();
            }
        }

}
