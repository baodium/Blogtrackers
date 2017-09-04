package blogtracker.util;

import java.util.ArrayList;
import java.util.LinkedHashMap;
/**
 * author mukti
 */
public class Sentiments_result {

	public Integer possenti; 
	public Integer negsenti;
	public String date;
	public ArrayList<ArrayList<String>> titles = new ArrayList<ArrayList<String>>();
	public LinkedHashMap<String,LinkedHashMap<String,ArrayList<Integer>>> emo = new LinkedHashMap<String,LinkedHashMap<String,ArrayList<Integer>>>();
//	public ArrayList<String> trendpos = new ArrayList<String>();
//	public ArrayList<String> trendneg = new ArrayList<String>();

}