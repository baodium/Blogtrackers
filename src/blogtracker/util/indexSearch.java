/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.util;

import org.apache.lucene.analysis.StopAnalyzer;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.Hits;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.Searcher;

/**
 * to search an index for term/(s)
 * 
 * @author Shamanth
 */
public class indexSearch{
    private StopAnalyzer analyzer;
    //private String INDEX_PATH3 = "Z:/Projects/[c]_blogtrackers/blogtrackers-index";

    public Hits search(String searchTerm, String indexPath)                      
        {
            blogtracker.util.stopWordsList.fillStopWordsList();
            analyzer = new StopAnalyzer(blogtracker.util.stopWordsList.stopwords);
            try             
            {
                Searcher newSearch= new IndexSearcher(indexPath);
                QueryParser searchParser;
                searchParser=new QueryParser("content",analyzer);
                Query searchQuery=searchParser.parse(searchTerm);
                Hits searchHits=newSearch.search(searchQuery);
                return searchHits;
            }
            catch(Exception e)
            {
                e.printStackTrace();
                return null;
            }
            
        }
    
}