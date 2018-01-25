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
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
/**
 * author mukti
 */
public class Sentiments_util extends UtilFunctions{

	public int blogpostid;
	public int analytic;
	public int clout;
	public int authentic;
	public int tone;
	public int affect;
	public int posemo;
	public int negemo;
	public int anx;
	public int anger;
	public int sad;
	public int cogproc;
	public int insight;
	public int cause;
	public int discrep;
	public int tentat;
	public int certain;
	public int differ;
	public int drives;
	public int affiliation;
	public int acheive;
	public int power;
	public int reward;
	public int risk;
	public int focuspast;
	public int focuspresent;
	public int focusfuture;
	public int work;
	public int leisure;
	public int home;
	public int money;
	public int religion;
	public int death;
	public String date;
	public String title;
	public String permalink;
	ArrayList<String> trendneg = new ArrayList<String>();
	ArrayList<String> trendpos = new ArrayList<String>();

	public ArrayList<Sentiments_util> getsentiments(Date date1,Date date2,String username, String trackername){

		ArrayList<Sentiments_util> senti = new ArrayList<Sentiments_util>();

		java.sql.Date sqldate1 = new java.sql.Date(date1.getTime());
		java.sql.Date sqldate2 = new java.sql.Date(date2.getTime());

		try{
			Connection conn= getConn();
			String queryStr = "select query from blogtrackers.trackers where userid = \'"+ username +"\' and tracker_name = \'" + trackername + "\'";

			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(queryStr);
			rs.next();
			String query = rs.getString("query");
			queryStr = "SELECT blogpost_id from blogtrackers.blogposts WHERE "+query;
			st = conn.createStatement();
			rs = st.executeQuery(queryStr);
			String blogpostid = "blogpostid in (";
			int h=0;
			while(rs.next())
			{
				if (h==0){
				blogpostid = blogpostid+rs.getInt("blogpost_id");
				h++;				
				}
				else
				{
					blogpostid = blogpostid+","+rs.getInt("blogpost_id");
				}
			}
			
			blogpostid = blogpostid+")";
		   queryStr = "select * from blogtrackers.liwc where date >=\'"+sqldate1+"\' and date<=\'"+sqldate2+"\'"+" and "+blogpostid;
		   st = conn.createStatement();
		   rs = st.executeQuery(queryStr);
			//rs.getRow();
			while(rs.next())
			{
				Sentiments_util s = new Sentiments_util();
				s.blogpostid=rs.getInt(1);
				s.analytic=rs.getInt(2);
				s.clout=rs.getInt(3);
				s.authentic=rs.getInt(4);
				s.tone=rs.getInt(5);
				s.affect=rs.getInt(6);
				s.posemo=rs.getInt(7);
				s.negemo=rs.getShort(8);
				s.anx=rs.getInt(9);
				s.anger=rs.getInt(10);
				s.sad=rs.getInt(11);
				s.cogproc=rs.getInt(12);
				s.insight=rs.getInt(13);
				s.cause=rs.getInt(14);
				s.discrep=rs.getInt(15);
				s.tentat=rs.getInt(16);
				s.certain=rs.getInt(17);
				s.differ=rs.getInt(18);
				s.drives=rs.getInt(19);
				s.affiliation=rs.getInt(20);
				s.acheive=rs.getInt(21);
				s.power=rs.getInt(22);
				s.reward=rs.getInt(23);
				s.risk=rs.getInt(24);
				s.focuspast=rs.getInt(25);
				s.focuspresent=rs.getInt(26);
				s.focusfuture=rs.getInt(27);
				s.work=rs.getInt(28);
				s.leisure=rs.getInt(29);
				s.home=rs.getInt(30);
				s.money=rs.getInt(31);
				s.religion=rs.getInt(32);
				s.death=rs.getInt(33);
				s.date=rs.getString(34);
				s.title=rs.getString(35);
				s.permalink=rs.getString(36);
				senti.add(s);
			}
			rs.close();
			st.close();
			conn.close();
		}catch (SQLException e)
		{
			e.printStackTrace();
		}

		return senti;
	}

	public long[] differenceBetweenDates(Date fromDate, Date toDate) {
		Calendar startDate = Calendar.getInstance();
		startDate.setTime(fromDate);
		long years = 0;
		long months = 0;
		long days = 0;
		Calendar endDate = Calendar.getInstance();
		endDate.setTime(toDate);
		Calendar tmpdate = Calendar.getInstance();
		tmpdate.setTime(startDate.getTime());

		tmpdate.add(Calendar.YEAR, 1);
		while (tmpdate.compareTo(endDate) <= 0) {
			startDate.add(Calendar.YEAR, 1);
			tmpdate.add(Calendar.YEAR, 1);
			years++;
		}
		tmpdate.setTime(startDate.getTime());
		tmpdate.add(Calendar.MONTH, 1);
		while (tmpdate.compareTo(endDate) <= 0) {
			startDate.add(Calendar.MONTH, 1);
			tmpdate.add(Calendar.MONTH, 1);
			months++;
		}
		tmpdate.setTime(startDate.getTime());
		tmpdate.add(Calendar.DATE, 1);
		while (tmpdate.compareTo(endDate) <= 0) {
			startDate.add(Calendar.DATE, 1);
			tmpdate.add(Calendar.DATE, 1);
			days++;
		}
		return new long[]{days, months, years};
	}


	@SuppressWarnings("deprecation")
	public ArrayList<Sentiments_result> getsentimentsyearly(Date startdate,Date enddate,String username, String trackername){

		ArrayList<ArrayList<String>> a = new ArrayList<ArrayList<String>>();
		Map<String, Object> config = new HashMap<String, Object>();
		//if you need pretty printing
		config.put("javax.json.stream.JsonGenerator.prettyPrinting", Boolean.valueOf(true));
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

			Sentiments_result sr = new Sentiments_result();
			ArrayList<Sentiments_util> senti = getsentiments(sd,ed,username,trackername);

			if(senti.isEmpty())
			{
				ArrayList<String> ti = new ArrayList<String>();
				sr.date=df.format(sd).toString();
				sr.possenti =0;
				sr.negsenti=0;
				ti.add("Empty result");
				ti.add("0");
				sr.titles.add(ti);
				sentires.add(sr);
			}else
			{	
				int sumpos=0;
				
				LinkedHashMap<String,ArrayList<Integer>> el = new LinkedHashMap<String,ArrayList<Integer>>();
				for(int i=0;i<senti.size();i++)
				{
					ArrayList<Integer> e = new ArrayList<Integer>();
					ArrayList<String> ti = new ArrayList<String>();
					sumpos = sumpos + senti.get(i).posemo;
					ti.add(senti.get(i).title);
					ti.add(Integer.toString(senti.get(i).blogpostid));
					e.add(senti.get(i).work);
					e.add(senti.get(i).leisure);
					e.add(senti.get(i).home);
					e.add(senti.get(i).money);
					e.add(senti.get(i).religion);
					e.add(senti.get(i).death);
					e.add(senti.get(i).focuspast);
					e.add(senti.get(i).focuspresent);
					e.add(senti.get(i).focusfuture);
					e.add(senti.get(i).affiliation);
					e.add(senti.get(i).acheive);
					e.add(senti.get(i).power);
					e.add(senti.get(i).reward);
					e.add(senti.get(i).risk);
					e.add(senti.get(i).insight);
					e.add(senti.get(i).cause);
					e.add(senti.get(i).discrep);
					e.add(senti.get(i).tentat);
					e.add(senti.get(i).certain);
					e.add(senti.get(i).differ);
					e.add(senti.get(i).analytic);
					e.add(senti.get(i).clout);
					e.add(senti.get(i).authentic);
					e.add(senti.get(i).tone);
					e.add(senti.get(i).posemo);
					e.add(senti.get(i).negemo);
					e.add(senti.get(i).anx);
					e.add(senti.get(i).anger);
					e.add(senti.get(i).sad);
					el.put(Integer.toString(senti.get(i).blogpostid), e);
					sr.titles.add(ti);
					sr.emo.put(df.format(sd).toString(), el);
				}
				int sumneg=0;
				for(int i=0;i<senti.size();i++)
				{
					sumneg = sumneg + senti.get(i).negemo;
				}
				sr.date=df.format(sd).toString();
				sr.possenti = sumpos;
				sr.negsenti= sumneg;
			}
			Calendar c1 = Calendar.getInstance();
			Calendar c2 = Calendar.getInstance();

			c1.setTime(ed);
			sd.setTime(c1.getTime().getTime());
			c2.setTime(sd);
			c2.add(Calendar.DATE, +1);
			c1.add(Calendar.DATE, +365);
			sd.setTime(c2.getTime().getTime());
			ed.setTime(c1.getTime().getTime());
			sentires.add(sr);
		} //end while
		if(!ed.before(enddate))
		{
			Sentiments_result sr = new Sentiments_result();

			ArrayList<Sentiments_util> senti = getsentiments(sd,enddate,username,trackername);
			if(senti.isEmpty())
			{
				ArrayList<String> ti = new ArrayList<String>();
				sr.date=df.format(sd).toString();
				sr.possenti =0;
				sr.negsenti=0;
				ti.add("Empty result");
				ti.add("0");
				sr.titles.add(ti);
				sentires.add(sr);
			}else
			{	
				
				LinkedHashMap<String,ArrayList<Integer>> el = new LinkedHashMap<String,ArrayList<Integer>>();

				int sumpos=0;
				for(int i=0;i<senti.size();i++)
				{
					ArrayList<Integer> e = new ArrayList<Integer>();
					ArrayList<String> ti = new ArrayList<String>();
					sumpos = sumpos + senti.get(i).posemo;

					ti.add(senti.get(i).title);
					ti.add(Integer.toString(senti.get(i).blogpostid));
					e.add(senti.get(i).work);
					e.add(senti.get(i).leisure);
					e.add(senti.get(i).home);
					e.add(senti.get(i).money);
					e.add(senti.get(i).religion);
					e.add(senti.get(i).death);
					e.add(senti.get(i).focuspast);
					e.add(senti.get(i).focuspresent);
					e.add(senti.get(i).focusfuture);
					e.add(senti.get(i).affiliation);
					e.add(senti.get(i).acheive);
					e.add(senti.get(i).power);
					e.add(senti.get(i).reward);
					e.add(senti.get(i).risk);
					e.add(senti.get(i).insight);
					e.add(senti.get(i).cause);
					e.add(senti.get(i).discrep);
					e.add(senti.get(i).tentat);
					e.add(senti.get(i).certain);
					e.add(senti.get(i).differ);
					e.add(senti.get(i).analytic);
					e.add(senti.get(i).clout);
					e.add(senti.get(i).authentic);
					e.add(senti.get(i).tone);
					e.add(senti.get(i).posemo);
					e.add(senti.get(i).negemo);
					e.add(senti.get(i).anx);
					e.add(senti.get(i).anger);
					e.add(senti.get(i).sad);
					el.put(Integer.toString(senti.get(i).blogpostid), e);
					sr.titles.add(ti);
					sr.emo.put(df.format(sd).toString(), el);
				}

				int sumneg=0;
				for(int i=0;i<senti.size();i++)
				{
					sumneg = sumneg + senti.get(i).negemo;
				}
				sr.date=df.format(sd).toString();
				sr.possenti = sumpos;
				sr.negsenti= sumneg;

			}
			sentires.add(sr);
		}
		return sentires;
	}

	public ArrayList<Sentiments_result> getsentimentsmonthly(Date startdate,Date enddate,String username, String trackername){

		ArrayList<ArrayList<String>> a = new ArrayList<ArrayList<String>>();
		Map<String, Object> config = new HashMap<String, Object>();
		//if you need pretty printing
		config.put("javax.json.stream.JsonGenerator.prettyPrinting", Boolean.valueOf(true));
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");		
		LinkedHashMap<String,Integer> ypossenti = new LinkedHashMap<String,Integer>();
		LinkedHashMap<String,Integer> ynegsenti = new LinkedHashMap<String,Integer>();
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

		ArrayList<Sentiments_result> sentires = new ArrayList<Sentiments_result>(); //for the result set
		while(ed.before(enddate))
		{

			Sentiments_result sr = new Sentiments_result();

			ArrayList<Sentiments_util> senti = getsentiments(sd,ed,username,trackername);

			if(senti.isEmpty())
			{
				ArrayList<String> ti = new ArrayList<String>();
				sr.date=df.format(sd).toString();
				sr.possenti =0;
				sr.negsenti=0;
				ti.add("Empty result");
				ti.add("0");
				sr.titles.add(ti);
			}else
			{	
				int sumpos=0;
				LinkedHashMap<String,ArrayList<Integer>> el = new LinkedHashMap<String,ArrayList<Integer>>();
				
				for(int i=0;i<senti.size();i++)
				{
					ArrayList<Integer> e = new ArrayList<Integer>();			
					
					ArrayList<String> ti = new ArrayList<String>();
					sumpos = sumpos + senti.get(i).posemo;
					ti.add(senti.get(i).title);
					ti.add(Integer.toString(senti.get(i).blogpostid));
					e.add(senti.get(i).work);
					e.add(senti.get(i).leisure);
					e.add(senti.get(i).home);
					e.add(senti.get(i).money);
					e.add(senti.get(i).religion);
					e.add(senti.get(i).death);
					e.add(senti.get(i).focuspast);
					e.add(senti.get(i).focuspresent);
					e.add(senti.get(i).focusfuture);
					e.add(senti.get(i).affiliation);
					e.add(senti.get(i).acheive);
					e.add(senti.get(i).power);
					e.add(senti.get(i).reward);
					e.add(senti.get(i).risk);
					e.add(senti.get(i).insight);
					e.add(senti.get(i).cause);
					e.add(senti.get(i).discrep);
					e.add(senti.get(i).tentat);
					e.add(senti.get(i).certain);
					e.add(senti.get(i).differ);
					e.add(senti.get(i).analytic);
					e.add(senti.get(i).clout);
					e.add(senti.get(i).authentic);
					e.add(senti.get(i).tone);
					e.add(senti.get(i).posemo);
					e.add(senti.get(i).negemo);
					e.add(senti.get(i).anx);
					e.add(senti.get(i).anger);
					e.add(senti.get(i).sad);
					el.put(Integer.toString(senti.get(i).blogpostid), e);
					sr.titles.add(ti);
					sr.emo.put(df.format(sd).toString(), el);
				
				}

				int sumneg=0;
				for(int i=0;i<senti.size();i++)
				{
					sumneg = sumneg + senti.get(i).negemo;
				}
				sr.date=df.format(sd).toString();
				sr.possenti = sumpos;
				sr.negsenti= sumneg;

			}
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
			sentires.add(sr);
		} //end while
		if(!ed.before(enddate))
		{
			Sentiments_result sr = new Sentiments_result();
			ArrayList<Sentiments_util> senti = getsentiments(sd,enddate,username,trackername);
			if(senti.isEmpty())
			{
				ArrayList<String> ti = new ArrayList<String>();
				sr.date=df.format(sd).toString();
				sr.possenti =0;
				sr.negsenti=0;
				ti.add("Empty result");
				ti.add("0");
				sr.titles.add(ti);
			}else
			{	
				

				int sumpos=0;
				LinkedHashMap<String,ArrayList<Integer>> el = new LinkedHashMap<String,ArrayList<Integer>>();
				for(int i=0;i<senti.size();i++)
				{
					ArrayList<Integer> e = new ArrayList<Integer>();					
					ArrayList<String> ti = new ArrayList<String>();
					sumpos = sumpos + senti.get(i).posemo;

					ti.add(senti.get(i).title);
					ti.add(Integer.toString(senti.get(i).blogpostid));
					e.add(senti.get(i).work);
					e.add(senti.get(i).leisure);
					e.add(senti.get(i).home);
					e.add(senti.get(i).money);
					e.add(senti.get(i).religion);
					e.add(senti.get(i).death);
					e.add(senti.get(i).focuspast);
					e.add(senti.get(i).focuspresent);
					e.add(senti.get(i).focusfuture);
					e.add(senti.get(i).affiliation);
					e.add(senti.get(i).acheive);
					e.add(senti.get(i).power);
					e.add(senti.get(i).reward);
					e.add(senti.get(i).risk);
					e.add(senti.get(i).insight);
					e.add(senti.get(i).cause);
					e.add(senti.get(i).discrep);
					e.add(senti.get(i).tentat);
					e.add(senti.get(i).certain);
					e.add(senti.get(i).differ);
					e.add(senti.get(i).analytic);
					e.add(senti.get(i).clout);
					e.add(senti.get(i).authentic);
					e.add(senti.get(i).tone);
					e.add(senti.get(i).posemo);
					e.add(senti.get(i).negemo);
					e.add(senti.get(i).anx);
					e.add(senti.get(i).anger);
					e.add(senti.get(i).sad);
					el.put(Integer.toString(senti.get(i).blogpostid), e);
					sr.titles.add(ti);
					sr.emo.put(df.format(sd).toString(), el);
				}

				int sumneg=0;
				for(int i=0;i<senti.size();i++)
				{
					sumneg = sumneg + senti.get(i).negemo;
				}
				sr.date=df.format(sd).toString();
				sr.possenti = sumpos;
				sr.negsenti= sumneg;
			}
			sentires.add(sr);
		}
		return sentires;
	}


	public ArrayList<Sentiments_result> getsentimentsweekly(Date startdate,Date enddate,String username, String trackername){

		Map<String, Object> config = new HashMap<String, Object>();
		//if you need pretty printing
		config.put("javax.json.stream.JsonGenerator.prettyPrinting", Boolean.valueOf(true));
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");		
		Date sd= new Date();
		Date ed=new Date();
		Calendar c = Calendar.getInstance();
		c.setTime(startdate);
		sd.setTime(c.getTime().getTime());
		int dayOfWeek = c.get(Calendar.DAY_OF_WEEK) - c.getFirstDayOfWeek();

		c.add(Calendar.DATE, 6-dayOfWeek);
		ed.setTime(c.getTime().getTime());

		ArrayList<Sentiments_result> sentires = new ArrayList<Sentiments_result>(); //for the result set
		while(ed.before(enddate))
		{
			Sentiments_result sr = new Sentiments_result();
			ArrayList<Sentiments_util> senti = getsentiments(sd,ed,username,trackername);

			if(senti.isEmpty())
			{
				ArrayList<String> ti = new ArrayList<String>();
				sr.date=df.format(sd).toString();
				sr.possenti =0;
				sr.negsenti=0;
				ti.add("Empty result");
				ti.add("0");
				sr.titles.add(ti);
				sentires.add(sr);

			}else
			{	
				int sumpos=0;
				
				LinkedHashMap<String,ArrayList<Integer>> el = new LinkedHashMap<String,ArrayList<Integer>>();
				for(int i=0;i<senti.size();i++)
				{
					ArrayList<Integer> e = new ArrayList<Integer>();
					ArrayList<String> ti = new ArrayList<String>();
					sumpos = sumpos + senti.get(i).posemo;
					ti.add(senti.get(i).title);
					ti.add(Integer.toString(senti.get(i).blogpostid));
					e.add(senti.get(i).work);
					e.add(senti.get(i).leisure);
					e.add(senti.get(i).home);
					e.add(senti.get(i).money);
					e.add(senti.get(i).religion);
					e.add(senti.get(i).death);
					e.add(senti.get(i).focuspast);
					e.add(senti.get(i).focuspresent);
					e.add(senti.get(i).focusfuture);
					e.add(senti.get(i).affiliation);
					e.add(senti.get(i).acheive);
					e.add(senti.get(i).power);
					e.add(senti.get(i).reward);
					e.add(senti.get(i).risk);
					e.add(senti.get(i).insight);
					e.add(senti.get(i).cause);
					e.add(senti.get(i).discrep);
					e.add(senti.get(i).tentat);
					e.add(senti.get(i).certain);
					e.add(senti.get(i).differ);
					e.add(senti.get(i).analytic);
					e.add(senti.get(i).clout);
					e.add(senti.get(i).authentic);
					e.add(senti.get(i).tone);
					e.add(senti.get(i).posemo);
					e.add(senti.get(i).negemo);
					e.add(senti.get(i).anx);
					e.add(senti.get(i).anger);
					e.add(senti.get(i).sad);
					el.put(Integer.toString(senti.get(i).blogpostid), e);
					sr.titles.add(ti);
					sr.emo.put(df.format(sd).toString(), el);

				}

				int sumneg=0;
				for(int i=0;i<senti.size();i++)
				{
					sumneg = sumneg + senti.get(i).negemo;
				}
				sr.date=df.format(sd).toString();
				sr.possenti = sumpos;
				sr.negsenti= sumneg;
				sentires.add(sr);
			}
			Calendar c1 = Calendar.getInstance();
			c1.setTime(ed);
			c1.add(Calendar.DATE, +1);
			sd.setTime(c1.getTime().getTime());


			c1.add(Calendar.DATE, +6);
			ed.setTime(c1.getTime().getTime());

		} //end while
		if(!ed.before(enddate))
		{
			Sentiments_result sr = new Sentiments_result();
			ArrayList<Sentiments_util> senti = getsentiments(sd,enddate,username,trackername);
			if(senti.isEmpty())
			{
				ArrayList<String> ti = new ArrayList<String>();
				sr.date=df.format(enddate).toString();
				sr.possenti =0;
				sr.negsenti=0;
				ti.add("Empty result");
				ti.add("0");
				sr.titles.add(ti);
				sentires.add(sr);

			}else
			{	
				
				LinkedHashMap<String,ArrayList<Integer>> el = new LinkedHashMap<String,ArrayList<Integer>>();

				int sumpos=0;
				for(int i=0;i<senti.size();i++)
				{
					ArrayList<Integer> e = new ArrayList<Integer>();
					ArrayList<String> ti = new ArrayList<String>();
					sumpos = sumpos + senti.get(i).posemo;

					ti.add(senti.get(i).title);
					ti.add(Integer.toString(senti.get(i).blogpostid));
					e.add(senti.get(i).work);
					e.add(senti.get(i).leisure);
					e.add(senti.get(i).home);
					e.add(senti.get(i).money);
					e.add(senti.get(i).religion);
					e.add(senti.get(i).death);
					e.add(senti.get(i).focuspast);
					e.add(senti.get(i).focuspresent);
					e.add(senti.get(i).focusfuture);
					e.add(senti.get(i).affiliation);
					e.add(senti.get(i).acheive);
					e.add(senti.get(i).power);
					e.add(senti.get(i).reward);
					e.add(senti.get(i).risk);
					e.add(senti.get(i).insight);
					e.add(senti.get(i).cause);
					e.add(senti.get(i).discrep);
					e.add(senti.get(i).tentat);
					e.add(senti.get(i).certain);
					e.add(senti.get(i).differ);
					e.add(senti.get(i).analytic);
					e.add(senti.get(i).clout);
					e.add(senti.get(i).authentic);
					e.add(senti.get(i).tone);
					e.add(senti.get(i).posemo);
					e.add(senti.get(i).negemo);
					e.add(senti.get(i).anx);
					e.add(senti.get(i).anger);
					e.add(senti.get(i).sad);
					el.put(Integer.toString(senti.get(i).blogpostid), e);
					sr.titles.add(ti);
					sr.emo.put(df.format(sd).toString(), el);
				}

				int sumneg=0;
				for(int i=0;i<senti.size();i++)
				{
					sumneg = sumneg + senti.get(i).negemo;
				}
				sr.date=df.format(sd).toString();
				sr.possenti = sumpos;
				sr.negsenti= sumneg;
				sentires.add(sr);
			}
		}
		return sentires;
	}



	public ArrayList<Sentiments_result> getsentimentsdaily(Date startdate,Date enddate,String username, String trackername){

		Map<String, Object> config = new HashMap<String, Object>();
		//if you need pretty printing
		config.put("javax.json.stream.JsonGenerator.prettyPrinting", Boolean.valueOf(true));
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");		
		Date sd= new Date();
		Date ed=new Date();
		Calendar c = Calendar.getInstance();
		c.setTime(startdate);
		sd.setTime(c.getTime().getTime());

		ArrayList<Sentiments_result> sentires = new ArrayList<Sentiments_result>(); //for the result set
		while(sd.before(enddate))
		{

			Sentiments_result sr = new Sentiments_result();
			ArrayList<Sentiments_util> senti = getsentiments(sd,sd,username,trackername);

			if(senti.isEmpty())
			{
				ArrayList<String> ti = new ArrayList<String>();
				sr.date=df.format(sd).toString();
				sr.possenti =0;
				sr.negsenti=0;
				ti.add("Empty result");
				ti.add("0");
				sr.titles.add(ti);
				sentires.add(sr);

			}else
			{	
				int sumpos=0;

				LinkedHashMap<String,ArrayList<Integer>> el = new LinkedHashMap<String,ArrayList<Integer>>();
				for(int i=0;i<senti.size();i++)
				{
					ArrayList<Integer> e = new ArrayList<Integer>();
					ArrayList<String> ti = new ArrayList<String>();
					sumpos = sumpos + senti.get(i).posemo;
					ti.add(senti.get(i).title);
					ti.add(Integer.toString(senti.get(i).blogpostid));
					e.add(senti.get(i).work);
					e.add(senti.get(i).leisure);
					e.add(senti.get(i).home);
					e.add(senti.get(i).money);
					e.add(senti.get(i).religion);
					e.add(senti.get(i).death);
					e.add(senti.get(i).focuspast);
					e.add(senti.get(i).focuspresent);
					e.add(senti.get(i).focusfuture);
					e.add(senti.get(i).affiliation);
					e.add(senti.get(i).acheive);
					e.add(senti.get(i).power);
					e.add(senti.get(i).reward);
					e.add(senti.get(i).risk);
					e.add(senti.get(i).insight);
					e.add(senti.get(i).cause);
					e.add(senti.get(i).discrep);
					e.add(senti.get(i).tentat);
					e.add(senti.get(i).certain);
					e.add(senti.get(i).differ);
					e.add(senti.get(i).analytic);
					e.add(senti.get(i).clout);
					e.add(senti.get(i).authentic);
					e.add(senti.get(i).tone);
					e.add(senti.get(i).posemo);
					e.add(senti.get(i).negemo);
					e.add(senti.get(i).anx);
					e.add(senti.get(i).anger);
					e.add(senti.get(i).sad);
					el.put(Integer.toString(senti.get(i).blogpostid), e);
					sr.titles.add(ti);
					sr.emo.put(df.format(sd).toString(), el);
					
				}

				int sumneg=0;
				for(int i=0;i<senti.size();i++)
				{
					sumneg = sumneg + senti.get(i).negemo;
				}
				sr.date=df.format(sd).toString();
				sr.possenti = sumpos;
				sr.negsenti= sumneg;
				
				sentires.add(sr);
			}
			Calendar c1 = Calendar.getInstance();
			c1.setTime(sd);
			c1.add(Calendar.DATE, +1);
			sd.setTime(c1.getTime().getTime());

		} //end while
		if(!sd.before(enddate))
		{
			Sentiments_result sr = new Sentiments_result();
			ArrayList<Sentiments_util> senti = getsentiments(sd,enddate,username,trackername);
			if(senti.isEmpty())
			{
				ArrayList<String> ti = new ArrayList<String>();
				sr.date=df.format(sd).toString();
				sr.possenti =0;
				sr.negsenti=0;
				ti.add("Empty result");
				ti.add("0");
				sr.titles.add(ti);
				sentires.add(sr);

			}else
			{	
				LinkedHashMap<String,ArrayList<Integer>> el = new LinkedHashMap<String,ArrayList<Integer>>();
				int sumpos=0;
				for(int i=0;i<senti.size();i++)
				{
					ArrayList<Integer> e = new ArrayList<Integer>();
					ArrayList<String> ti = new ArrayList<String>();
					sumpos = sumpos + senti.get(i).posemo;
					ti.add(senti.get(i).title);
					ti.add(Integer.toString(senti.get(i).blogpostid));
					e.add(senti.get(i).work);
					e.add(senti.get(i).leisure);
					e.add(senti.get(i).home);
					e.add(senti.get(i).money);
					e.add(senti.get(i).religion);
					e.add(senti.get(i).death);
					e.add(senti.get(i).focuspast);
					e.add(senti.get(i).focuspresent);
					e.add(senti.get(i).focusfuture);
					e.add(senti.get(i).affiliation);
					e.add(senti.get(i).acheive);
					e.add(senti.get(i).power);
					e.add(senti.get(i).reward);
					e.add(senti.get(i).risk);
					e.add(senti.get(i).insight);
					e.add(senti.get(i).cause);
					e.add(senti.get(i).discrep);
					e.add(senti.get(i).tentat);
					e.add(senti.get(i).certain);
					e.add(senti.get(i).differ);
					e.add(senti.get(i).analytic);
					e.add(senti.get(i).clout);
					e.add(senti.get(i).authentic);
					e.add(senti.get(i).tone);
					e.add(senti.get(i).posemo);
					e.add(senti.get(i).negemo);
					e.add(senti.get(i).anx);
					e.add(senti.get(i).anger);
					e.add(senti.get(i).sad);
					el.put(Integer.toString(senti.get(i).blogpostid), e);
					sr.titles.add(ti);
					sr.emo.put(df.format(sd).toString(), el);
				}

				int sumneg=0;
				for(int i=0;i<senti.size();i++)
				{
					sumneg = sumneg + senti.get(i).negemo;
				}
				sr.date=df.format(sd).toString();
				sr.possenti = sumpos;
				sr.negsenti= sumneg;
				
				sentires.add(sr);

			}
		}
		return sentires;
	}
	
	public int get_tracker_id(String username, String trackername) 
	{
		int tracker_id;
		String tid ="";
		Connection conn= getConn();
		String queryStr = "select tid from blogtrackers.trackers where userid = \'"+ username +"\' and tracker_name = \'" + trackername + "\'";

		Statement st;
		try {
			st = conn.createStatement();
			ResultSet rs = st.executeQuery(queryStr);
			rs.next();
			tid = rs.getString("tid");
			rs.close();
			st.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		tracker_id = Integer.parseInt(tid); 
		return tracker_id;
		
	}
	
	public ArrayList<String> get_blogger(String username, String trackername)
	{
		ArrayList<String> bloggers = new ArrayList<String>();
		Connection conn= getConn();
		String queryStr = "select query from blogtrackers.trackers where userid = \'"+ username +"\' and tracker_name = \'" + trackername + "\'";

		Statement st;
		try {
			st = conn.createStatement();
			ResultSet rs = st.executeQuery(queryStr);
			rs.next();
			String query = rs.getString("query");
			queryStr = "SELECT distinct blogger from blogtrackers.blogposts WHERE "+query;
//			System.out.println(queryStr);
			st = conn.createStatement();
			rs = st.executeQuery(queryStr);
			
			while(rs.next())
			{
				bloggers.add(rs.getString("blogger"));
			}
			
			rs.close();
			st.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return bloggers;
	}

}
