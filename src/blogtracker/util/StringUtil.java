package blogtracker.util;
/*
 * author:shamanth
 * Class that provides functions to clean the html portion of the post
 *
 */
public class StringUtil {
	
	public static long wordcount(String line){
	    long numWords = 0;
	    int index = 0;
	    boolean prevWhiteSpace = true;
	    while(index < line.length()){
	      char c = line.charAt(index++);
	      boolean currWhiteSpace = Character.isWhitespace(c);
	      if(prevWhiteSpace && !currWhiteSpace){
	        numWords++;
	      }
	      prevWhiteSpace = currWhiteSpace;
	    }
	    return numWords;
	  }
	
	
	/**
	 * Given a chunk of text, this method will strip it of all the HTML tags
	 * and returns it
	 * @param anInput
	 * @return
	 */
	public static String stripHTMLTags(String anInput)
	{
		String noHTMLString = anInput.replaceAll("\\<.*?\\>", "");
		noHTMLString = noHTMLString.replaceAll("\\{.*?\\}", "");
		//noHTMLString = noHTMLString.replaceAll("  ", " ");
        noHTMLString = noHTMLString.trim();
		return noHTMLString;
	}
	
        public static String stripAnchortags(String iInputStr)
        {
            String inputStr = iInputStr.replaceAll("<a .*?\\>", "");
            inputStr = inputStr.replaceAll("</a>", " ");
            //noHTMLString = noHTMLString.replaceAll("\\{.*?\\}", "");
            inputStr = inputStr.replaceAll("\n", "");
            inputStr = inputStr.replaceAll("'", "");
	    inputStr = inputStr.replaceAll("  ", " ");
		
            return inputStr;
        }
	
        public static String stripQuotes(String iInputStr)
        {
            String inputStr = iInputStr.replaceAll("'", "");
            return inputStr;
        }
	public static String cleanup(String anInput, int aMinWords)
	{
		String[] poList = anInput.split("\r|\n|\r\n");
		StringBuffer lCleaned = new StringBuffer();
		
		for(int i=0; i<poList.length; i++)
		{
			if( poList[i].indexOf("{") != -1)
				continue;
			if( poList[i].indexOf("}") != -1)
				continue;
			if( poList[i].indexOf("[") != -1)
				continue;
			if( poList[i].indexOf("]") != -1)
				continue;
			if( poList[i].indexOf("|") != -1)
				continue;
			if( poList[i].indexOf(":") != -1)
				continue;
			if( poList[i].indexOf("©") != -1)
				continue;
			if( StringUtil.wordcount(poList[i]) < aMinWords)
				continue;
			
			if( poList[i].toLowerCase().indexOf("ads") != -1 && poList[i].toLowerCase().indexOf("google") != -1)
				continue;
			if( poList[i].toLowerCase().indexOf("headlines") != -1 )
				continue;
			if( poList[i].toLowerCase().indexOf("comment") != -1 )
				continue;
			lCleaned.append(poList[i]+"\n");
		}
		return lCleaned.toString();
	}

}
