package blogtracker.util;

/*
Author: Adigun Adekunle

*/
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Date;

public class BlogClusteringUtil extends UtilFunctions {

	
// fetches all 
public void GetAllBlogPost(Date startDate, Date endDate,String username, String trackername)
{
Connection conn = getConn();
java.sql.Date sqldate1 = new java.sql.Date(startDate.getTime());
java.sql.Date sqldate2 = new java.sql.Date(endDate.getTime());
Statement st;
String query = "";
try {

	// fetch query from tracker name 
	String queryStr = "select query from trackers where userid=\'"+username+"\' and tracker_name=\'"+trackername+"\'";
	st = conn.createStatement();
	ResultSet rs = st.executeQuery(queryStr);
	rs.next();
	query = rs.getString("query"); 	
	//System.out.println(query);
	
	// fetch title and post content by date
	queryStr  = "select post from blogtrackers.blogposts where date >=\'"+sqldate1+"\' and date<=\'"+sqldate2+"\' and "+query;
	st = conn.createStatement();
	rs = st.executeQuery(queryStr);

	File currentDirectory = new File(new File(".").getAbsolutePath());
	System.out.println(currentDirectory.getCanonicalPath());
	System.out.println(currentDirectory.getAbsolutePath());
	
		try (Writer writer = new BufferedWriter(new OutputStreamWriter(
	              new FileOutputStream("document.txt"), "utf-8"))) {
	   //writer.write("something");
	
	
	while(rs.next())
	{
	//String title = rs.getString("title");
	String post = rs.getString("post");
	System.out.println(post);
	writer.write(post+"\n\n");
	}
	
	writer.close();
	BlogClusteringUtil mytest = new BlogClusteringUtil();
	mytest.testCosineSimilarity();
	}
	catch(IOException e)
	{
		
	}
	
	
	rs.close();
	st.close();
	conn.close();
	
}
catch(SQLException e)
{
e.printStackTrace();	
} catch (IOException e1) {
	// TODO Auto-generated catch block
	e1.printStackTrace();
}



	
}

public void testCosineSimilarity() throws FileNotFoundException, IOException
{
    DocumentParser dp = new DocumentParser();
    dp.parseFiles("D:\\FolderToCalculateCosineSimilarityOf"); // give the location of source file
    dp.tfIdfCalculator(); //calculates tfidf
    dp.getCosineSimilarity(); //calculates cosine similarity   
}

// cosine similarity
//public static double cosineSimilarity(double[] vectorA, double[] vectorB) {
//    double dotProduct = 0.0;
//    double normA = 0.0;
//    double normB = 0.0;
//    for (int i = 0; i < vectorA.length; i++) {
//        dotProduct += vectorA[i] * vectorB[i];
//        normA += Math.pow(vectorA[i], 2);
//        normB += Math.pow(vectorB[i], 2);
//    }   
//    return dotProduct / (Math.sqrt(normA) * Math.sqrt(normB));
//}


/*public void tfIdfCalculator() {
    double tf; //term frequency
    double idf; //inverse document frequency
    double tfidf; //term requency inverse document frequency        
    for (String[] docTermsArray : termsDocsArray) {
        double[] tfidfvectors = new double[allTerms.size()];
        int count = 0;
        for (String terms : allTerms) {
            tf = new TfIdf().tfCalculator(docTermsArray, terms);
            idf = new TfIdf().idfCalculator(termsDocsArray, terms);
            tfidf = tf * idf;
            tfidfvectors[count] = tfidf;
            count++;
        }
        tfidfDocsVector.add(tfidfvectors);  //storing document vectors;            
    }
}*/



}
