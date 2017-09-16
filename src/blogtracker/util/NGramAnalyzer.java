/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.util;

/**
 *
 * @author skumar34
 */
import blogtracker.gui.blogtrackers.tags;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.Term;
import org.apache.lucene.search.Hits;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Searcher;
import org.apache.lucene.search.PhraseQuery;

public class NGramAnalyzer {

  //default N gram size (value of N)
  int NGram_size = 2;

  public NGramAnalyzer(int nvalue)
  {
      NGram_size = nvalue;
  }

  HashMap<String,Integer> stopWords= new HashMap<String,Integer>();
  public void loadStopWords(String filename)
  {
        try {
            BufferedReader bread = new BufferedReader(new FileReader(filename));
            String temp = "";
            try {
                while ((temp = bread.readLine()) != null)
                {
                    if (!temp.isEmpty())
                    {
                        String[] stwords = temp.split(",");
                        for(String t: stwords)
                        {
                            t = t.toLowerCase();
                            if(!stopWords.containsKey(t))
                            {
                                stopWords.put(t,1);
                            }
                        }
                    }
                }
            } catch (IOException ex) {
                Logger.getLogger(NGramAnalyzer.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (FileNotFoundException ex) {
            Logger.getLogger(NGramAnalyzer.class.getName()).log(Level.SEVERE, null, ex);
        }

  }

  
  public String removestopwords(String input)
  {
      input = input.replace(",", "");
      input = input.replace(".", "");
      input = input.replace(":", "");
      input = input.replace(";", "");
      input = input.replace("/", "");
      input = input.replace("]", "");
      input = input.replace("[", "");
      input = input.replace("-", "");
      input = input.toLowerCase();
      Set<String> stopwords = stopWords.keySet();
      for(String temp: stopwords)
      {
          input = input.replace(" "+temp+" ", " ");
      }
      return input;
  }

  public String[] ngramtokenize(String input)
  {
      ArrayList<String> NGrams = new ArrayList<String>();
      String[] tokens = input.split("[ \\t\\n\\r\\f]");
      if(NGram_size == 1)
      {
          NGrams.clear();
        for(int i=0;i<tokens.length-1;i+=1)
        {
              //System.out.println("tokens = "+tokens[i]+" "+tokens[i+1]);
              if(!tokens[i].isEmpty()&&!stopWords.containsKey(tokens[i]))
              {
                NGrams.add(tokens[i]);
              }
        }
      }
      else
      if(NGram_size == 2)
      {
          NGrams.clear();
           for(int i=0;i<tokens.length-1;i+=1)
            {
              if(!tokens[i].isEmpty()&&!tokens[i+1].isEmpty()&&!stopWords.containsKey(tokens[i])&&!stopWords.containsKey(tokens[i+1]))
              {
                  NGrams.add(tokens[i]+" "+tokens[i+1]);
              }
           }
      }
      else
      if(NGram_size==3)
      {
          NGrams.clear();
        for(int i=0;i<tokens.length-1;i+=1)
        {
          //System.out.println("tokens = "+tokens[i]+" "+tokens[i+1]+" "+tokens[i+2]);
          if(!tokens[i].isEmpty()&&!tokens[i+1].isEmpty()&&!tokens[i+2].isEmpty()&&!stopWords.containsKey(tokens[i])&&!stopWords.containsKey(tokens[i+1])&&!stopWords.containsKey(tokens[i+2]))
          {
              NGrams.add(tokens[i]+" "+tokens[i+1]+" "+tokens[i+2]);
          }
        }
      }
      return NGrams.toArray(new String[NGrams.size()]);
  }

  Hashtable NGram_count = new Hashtable();

  public void buildhashmap (String input)
  {
      input = removestopwords(input);
      input = input.replaceAll("&nbsp;", "");
      String[] NGrams = ngramtokenize(input);
      //System.out.println("tokens ready");
      //System.out.println(NGrams.length);
      for(String temp:NGrams)
      {
          if(NGram_count.get(temp)!=null)
          {
              NGram_count.put(temp, (Integer.parseInt(NGram_count.get(temp).toString())+1));

          }
          else
          {
              NGram_count.put(temp, 1);
          }
      }
      //System.out.println("hashmap built");
  }

  public boolean checkAllNumbers(String str)
  {
      boolean flag = true;
      //System.out.println("check all numbers");
      if(str!=null||!str.isEmpty())
      {
          str = str.replaceAll(" ", "");
          if(str.length()>40)
          {
              return true;
          }
          for(int i=0;i<str.length();i++)
          {
              if(!Character.isDigit(str.charAt(i)))
              {
                  flag = false;
                  break;
              }
          }
      }   
      //System.out.println(flag);
      return flag;
  }

  public tags[] getTopNGrams(String input, String stopfname, IndexReader handle)
  {
      input = input.toLowerCase();
      int totaldocs = handle.numDocs();
      loadStopWords(stopfname);
      buildhashmap(input);
      tags[] keys = new tags[NGram_count.size()];
      int count = 0;
       Searcher idfsearch = null;
        try {
             idfsearch= new IndexSearcher(handle.directory());
        } catch (CorruptIndexException ex) {
            Logger.getLogger(NGramAnalyzer.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(NGramAnalyzer.class.getName()).log(Level.SEVERE, null, ex);
        }
      if(idfsearch!=null)
      {
                //System.out.println("inside");
          int ct=0;
          //System.out.println(NGram_count.size());  
          for (Enumeration e = NGram_count.keys(); e.hasMoreElements();)
          {
              //System.out.println("ngram elements");
                    //Lucene Hack: Used the phrase query to search the index for the boolean
                    //query to avoid parsing all the documents using NGram analyzer.
                    //Created efficiency issues. NGram analyzer noticeably slower.
                    String key = e.nextElement().toString();
                    //System.out.println(key+ct++);
                    boolean fl = checkAllNumbers(key);
                    String[] keyterms = key.split(" ");
                    PhraseQuery ph = new PhraseQuery();
                    for(int i=0;i<keyterms.length;i++)
                    {
                        //System.out.println(keyterms[i]);
                        ph.add(new Term("content",keyterms[i]));
                    }
                    //System.out.println("done query");
                    Hits ht = null;
                try {
                     ht = idfsearch.search(ph);
                     //System.out.println("key "+key+" hits"+ht.length());
                } catch (IOException ex) {
                    Logger.getLogger(NGramAnalyzer.class.getName()).log(Level.SEVERE, null, ex);
                }
                    //System.out.println(ht.length());
                    int nodocs = 0;
                    if(ht!=null)
                    {
                        nodocs = ht.length();
                    }
                    double value = Integer.parseInt(NGram_count.get(key).toString());
                    //System.out.println(value);
                    //multiply with the idf factor
                    double idffactor = 0;
                    if(!fl)
                    {
                        if(handle == null)
                        {
                            idffactor = 1;  //reduce the representation to tf if the index is not available.
                        }
                        if(nodocs>0)
                        {
                            idffactor = Math.log10(totaldocs / nodocs);
                        }
                        else
                            idffactor = 0;
                    }
                    value = value * idffactor;
                    //if(value>0)
                   // {
                        keys[count] = new tags(key, value);
                        count++;
                  //  }
               }
          }
         if(keys.length>0)
         {
         Arrays.sort(keys, Collections.reverseOrder());
         tags[] ngrams = new tags[keys.length];
         //restricting the no of
         double max = keys[0].getValue();
         for(int i=0;i<keys.length;i++)
            {
             ngrams[i] = new tags();
             ngrams[i].setKey(keys[i].getKey());
             ngrams[i].setValue((keys[i].getValue()/max)*35);
             //System.out.println(keys[i].getKey()+" value = "+keys[i].getValue());
            }

         return ngrams;
         }
         else
         {
           return null;
         }
  }
}