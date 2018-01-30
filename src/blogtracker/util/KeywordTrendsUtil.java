package blogtracker.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import blogtracker.gui.blogtrackers.KeywordTrends;

public class KeywordTrendsUtil extends UtilFunctions{
	public ArrayList<KeywordResult> getkwyearly(Date startdate,Date enddate,String selectedSites,String key)
	{
		ArrayList<KeywordResult> keywordres = new ArrayList<KeywordResult>();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");		
		Date sd= new Date();
		Date ed=new Date();
		Calendar c = Calendar.getInstance();
		c.setTime(startdate);
		sd.setTime(c.getTime().getTime());



		int d = c.get(Calendar.YEAR);
		String dd = d+"-12-31";
		try {
			Date edate = df.parse(dd);	     
			c.setTime(edate);
			ed.setTime(c.getTime().getTime());
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		ArrayList<Sentiments_result> sentires = new ArrayList<Sentiments_result>(); //for the result set
		while(ed.before(enddate))
		{

			KeywordResult kr = new KeywordResult();
			KeywordTrends k = new KeywordTrends();
			try {
				kr = k.getchartpoints(sd,ed,selectedSites,key);
				keywordres.add(kr);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			};

			Calendar c1 = Calendar.getInstance();
			Calendar c2 = Calendar.getInstance();

			c1.setTime(ed);
			sd.setTime(c1.getTime().getTime());
			c2.setTime(sd);
			c2.add(Calendar.DATE, +1);
			c1.add(Calendar.DATE, +365);
			sd.setTime(c2.getTime().getTime());
			ed.setTime(c1.getTime().getTime());

		}
		if(!ed.before(enddate))
		{
			KeywordResult kr = new KeywordResult();
			KeywordTrends k = new KeywordTrends();
			try {
				kr = k.getchartpoints(sd,enddate,selectedSites,key);
				keywordres.add(kr);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}		
		return keywordres;
	}


	public ArrayList<KeywordResult> getkwmonthly(Date startdate,Date enddate,String selectedSites,String key)
	{
		ArrayList<KeywordResult> keywordres = new ArrayList<KeywordResult>();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");		
		Date sd= new Date();
		Date ed=new Date();
		Calendar c = Calendar.getInstance();
		c.setTime(startdate);
		sd.setTime(c.getTime().getTime());

		YearMonth yearMonth1 = YearMonth.of( c.get(Calendar.YEAR) , c.get(Calendar.MONTH)+1  );
		LocalDate endOfMonth1 = yearMonth1.atEndOfMonth();
		try {
			Date edate = df.parse(endOfMonth1.toString());	     
			c.setTime(edate);
			ed.setTime(c.getTime().getTime());
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		while(ed.before(enddate))
		{

			KeywordResult kr = new KeywordResult();
			KeywordTrends k = new KeywordTrends();
			try {
				kr = k.getchartpoints(sd,ed,selectedSites,key);
				keywordres.add(kr);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			};

			Calendar c1 = Calendar.getInstance();
			Calendar c2 = Calendar.getInstance();
			c1.setTime(ed);
			sd.setTime(c1.getTime().getTime());
			c2.setTime(sd);

			c2.add(Calendar.DATE, +1);
			sd.setTime(c2.getTime().getTime());
			c1.setTime(sd);

			YearMonth yearMonth = YearMonth.of( c2.get(Calendar.YEAR) , c2.get(Calendar.MONTH)+1  );
			LocalDate endOfMonth = yearMonth.atEndOfMonth();

			c1.add(Calendar.DATE,endOfMonth.getDayOfMonth()-1);
			ed.setTime(c1.getTime().getTime());

		}
		if(!ed.before(enddate))
		{
			KeywordResult kr = new KeywordResult();
			KeywordTrends k = new KeywordTrends();
			try {
				kr = k.getchartpoints(sd,enddate,selectedSites,key);
				keywordres.add(kr);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}		
		return keywordres;
	}


	public ArrayList<KeywordResult> getkwweekly(Date startdate,Date enddate,String selectedSites,String key)
	{
		ArrayList<KeywordResult> keywordres = new ArrayList<KeywordResult>();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");		
		Date sd= new Date();
		Date ed=new Date();
		Calendar c = Calendar.getInstance();
		c.setTime(startdate);
		sd.setTime(c.getTime().getTime());
		int dayOfWeek = c.get(Calendar.DAY_OF_WEEK) - c.getFirstDayOfWeek();

		c.add(Calendar.DATE, 6-dayOfWeek);
		ed.setTime(c.getTime().getTime());

		while(ed.before(enddate))
		{

			KeywordResult kr = new KeywordResult();
			KeywordTrends k = new KeywordTrends();
			try {
				kr = k.getchartpoints(sd,ed,selectedSites,key);
				keywordres.add(kr);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			};

			Calendar c1 = Calendar.getInstance();
			c1.setTime(ed);
			c1.add(Calendar.DATE, +1);
			sd.setTime(c1.getTime().getTime());


			c1.add(Calendar.DATE, +6);
			ed.setTime(c1.getTime().getTime());
		}
		if(!ed.before(enddate))
		{
			KeywordResult kr = new KeywordResult();
			KeywordTrends k = new KeywordTrends();
			try {
				kr = k.getchartpoints(sd,enddate,selectedSites,key);
				keywordres.add(kr);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}		
		return keywordres;
	}



	public ArrayList<KeywordResult> getkwdaily(Date startdate,Date enddate,String selectedSites,String key)
	{
		ArrayList<KeywordResult> keywordres = new ArrayList<KeywordResult>();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");		
		Date sd= new Date();
		Date ed=new Date();
		Calendar c = Calendar.getInstance();
		c.setTime(startdate);
		sd.setTime(c.getTime().getTime());

		while(sd.before(enddate))
		{

			KeywordResult kr = new KeywordResult();
			KeywordTrends k = new KeywordTrends();
			try {
				kr = k.getchartpoints(sd,sd,selectedSites,key);
				keywordres.add(kr);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			};

			Calendar c1 = Calendar.getInstance();
			c1.setTime(sd);
			c1.add(Calendar.DATE, +1);
			sd.setTime(c1.getTime().getTime());
		}
		if(!sd.before(enddate))
		{
			KeywordResult kr = new KeywordResult();
			KeywordTrends k = new KeywordTrends();
			try {
				kr = k.getchartpoints(sd,enddate,selectedSites,key);
				keywordres.add(kr);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}		
		return keywordres;
	}

	public KeywordNetwork network(ArrayList<ArrayList<String>> id_list) throws SQLException 
	{
		KeywordNetwork kn = new KeywordNetwork();
		KeywordNetwork kn1 = new KeywordNetwork();
		for(int i=0;i<id_list.size();i++)
		{
			Connection conn= getConn();
			String queryStr = "select distinct entity from blogpost_entitysentiment where blogpost_id="+
					id_list.get(i).get(0);	
//			System.out.println("oooo"+queryStr);
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(queryStr);
			ArrayList<String> list = new ArrayList<String>();
			while(rs.next())
			{
				list.add(rs.getString("entity"));
				if(kn.nodelist.containsKey(rs.getString("entity")))
				{

				}
				else
				{
					kn.nodelist.put(rs.getString("entity"), rs.getString("entity"));
				}
			}
			for(int j=0;j<list.size();j++)
			{
				for(int k=j+1;k<list.size();k++)
				{
					String s=list.get(j)+"~"+list.get(k);
					String s1=list.get(k)+"~"+list.get(j);
					if(kn.netlist.containsKey(s))
					{
						kn.netlist.put(s, kn.netlist.get(s)+1);
					}
					else if(kn.netlist.containsKey(s1))
					{
						kn.netlist.put(s1, kn.netlist.get(s1)+1);
					}
					else
					{
						kn.netlist.put(s, 1);
					}

				}
			}
			
			// top 5% code
			kn1.nodelist.putAll(kn.nodelist);
			 Set<Entry<String, Integer>> set = kn.netlist.entrySet();
		        List<Entry<String, Integer>> list1 = new ArrayList<Entry<String, Integer>>(set);
		        Collections.sort( list1, new Comparator<Map.Entry<String, Integer>>()
		        {
		            public int compare( Map.Entry<String, Integer> o1, Map.Entry<String, Integer> o2 )
		            {
		                return (o2.getValue()).compareTo( o1.getValue() );
		            }
		        } );
		        for(Map.Entry<String, Integer> entry:list1){
//		            System.out.println(entry.getKey()+" ==== "+entry.getValue());
		            kn1.netlist.put(entry.getKey(), entry.getValue());
		        }
		        //ends here top5%
		}
		return kn;

	}
}