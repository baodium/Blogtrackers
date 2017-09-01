/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.gui.blogtrackers;

import blogtracker.util.UtilFunctions;
import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.Term;
import org.apache.lucene.index.TermFreqVector;

/**
 *
 * @author skumar34
 */
public class getTagKeywords extends UtilFunctions
{
    public getTagKeywords()
    {
        
    }

    String freqTermIndex;// = "C:\\indices\\index1";
    String SEARCH_INDEX;// = "C:\\Program Files (x86)\\blazeds\\tomcat\\webapps\\blazeds\\BlogTracker\\blogtrackers-index";

//     public void loadGlobalConstants()
//    {
//
//        BufferedReader br = null;
//        try {
//            //System.out.println(System.getProperty("user.dir"));
//            HashMap<String,String> hm = new HashMap<String,String>();
//            br = new BufferedReader(new FileReader("..\\webapps\\ROOT\\WEB-INF\\classes\\authentication\\blogtrackers.config"));
//            String temp = "";
//            while((temp = br.readLine())!=null)
//            {
//                temp = temp.trim();
//                //System.out.println(temp);
//                if(temp.isEmpty()||temp.startsWith("//"))
//                {
//                    continue;
//                }
//                else
//                {
//                    String[] arr = temp.split("##");
//                    //System.out.println(arr[0]+" "+arr[1]);
//                    if(arr.length==2)
//                    {
//                        hm.put(arr[0].trim(), arr[1].trim());
//                    }
//                }
//            }
//            if(!hm.isEmpty())
//            {
//                SEARCH_INDEX = hm.get("searchIndex");
//                freqTermIndex = hm.get("freqTermIndex");
//            }
//        } catch (IOException ex) {
//            ex.printStackTrace();
//        }finally {
//            try {
//                br.close();
//            } catch (IOException ex) {
//               ex.printStackTrace();
//            }
//
//        }
//
//    }


     public boolean checkAllNumbers(String str)
  {
      boolean flag = true;
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

      return flag;
  }
    
    public tags[] getTags(int index)
    {
        try {
            loadConstants();
            SEARCH_INDEX = hm.get("searchIndex");
            freqTermIndex = hm.get("freqTermIndex");
            IndexReader idfread = IndexReader.open(SEARCH_INDEX);
            int totaldocs = idfread.numDocs();
            double idffactor = 0;
            if(idfread==null)
            {
                idffactor = 1;
            }
            //System.out.println("inside gettags");
            IndexReader rd = IndexReader.open(freqTermIndex);
            TermFreqVector tfv = (TermFreqVector) rd.getTermFreqVector(index, "content");
            String[] terms = tfv.getTerms();
            int[] freq = tfv.getTermFrequencies();
            tags[] kpoints = new tags[terms.length];
            for(int i=0;i<terms.length;i++)
            {
                if(checkAllNumbers(terms[i]))
                {
                    continue;
                }
                kpoints[i] = new tags();
                kpoints[i].key = terms[i];
                try
                {
                    int nodocs = idfread.docFreq(new Term("content",terms[i]));
                    if(nodocs>0)
                    {
                        idffactor = Math.log10(totaldocs/(nodocs+1));
                    }
                    else
                        idffactor = 0;
                }
                catch(IOException e)
                {
                    idffactor = 1;  //if there is something wrong with the index reduce to tf.
                }
               kpoints[i].value = freq[i]*idffactor;
            }
            rd.close();
            idfread.close();
            Arrays.sort(kpoints,Collections.reverseOrder());
            //System.out.println(kpoints.length);
            return kpoints;
        } catch (CorruptIndexException ex) {
            Logger.getLogger(getTagKeywords.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(getTagKeywords.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    private void shuffleTermFreqs(String[] terms, int[] freqs)
    {
        int index = terms.length;
        for (int i = 0; i < index; i++)
        {
        int r = i + (int) (Math.random() * (index-i));   // between i and N-1
        this.exch(terms, i, r);
        this.exch(freqs, i, r);
        }
    }

    private void exch(int[] a, int i, int j)
    {
            int swap = a[i];
            a[i] = a[j];
            a[j] = swap;
     }

    private void exch(String[] a, int i, int j)
    {
            String swap = a[i];
            a[i] = a[j];
            a[j] = swap;
     }

    public String formTags(int index,int threshold)
    {
       String taghtml = "";
       tags[] phrases = getTags(index);
       int limit = threshold;
       if(phrases.length<threshold)
       {
           limit = phrases.length;
       }
        int size = limit;
        int tier1 = size/3;
        for(int j=0;j<tier1;j++)
        {
            phrases[j].value = 30;
            //System.out.println(phrases[j].key+" "+phrases[j].value);
        }
        for(int j=tier1;j<tier1+tier1;j++)
        {
            phrases[j].value = 20;
            //System.out.println(phrases[j].key+" "+phrases[j].value);
        }
        for(int j=tier1+tier1;j<limit;j++)
        {
            phrases[j].value = 12;
            //System.out.println(phrases[j].key+" "+phrases[j].value);
        }
       for(int i=0;i<limit;i++)
       {
          taghtml = taghtml+ "<a href=\"event:"+phrases[i].key+"\"><font size=\""+phrases[i].value+ "\">"+phrases[i].key+"</font></a> ";
       }
       return taghtml;
    }

}





