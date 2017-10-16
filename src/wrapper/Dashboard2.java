package wrapper;

import java.io.IOException;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.json.Json;
import javax.json.JsonBuilderFactory;
import javax.json.JsonObject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;

import blogtracker.util.CountryCodes;
/**
 * Servlet implementation class Dashboard
 * @author mukti
 */
@WebServlet("/Dashboard")
public class Dashboard2 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Dashboard2() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		StringBuffer trackerurl =  request.getRequestURL();
		if(trackerurl != null)
		{
		//System.out.println(trackerurl);	
		}
		if(session.getAttribute("tracker")==null && request.getParameter("tracker")==null)
		{
			session.setAttribute("nblogs", 0);
			session.setAttribute("nblogposts", 0);
			session.setAttribute("nbloggers", 0);
			session.setAttribute("npsenti", 0);
			session.setAttribute("nnsenti", 0);
			session.setAttribute("nloc", "");
			session.setAttribute("data", "");
			session.setAttribute("nlang", "");
			session.setAttribute("nlg", "");
			session.setAttribute("series", "");			
			response.setContentType("text/html");
	    	response.sendRedirect("Dashboard.jsp");
		}
		else
		{	
		
		if(request.getParameter("tracker")!=null)
		{
			String tracker = request.getParameter("tracker");
			session.setAttribute("tracker", tracker);
		}
		String tracker = (String) session.getAttribute("tracker");
		String userName = (String) session.getAttribute("user");

		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.DATE, -7);
		date.setTime(c.getTime().getTime());
		System.out.println(dateFormat.format(date)); //2014/08/06 15:59:48
		blogtracker.util.Dashboard d = new blogtracker.util.Dashboard(userName,tracker);

		int nblogs = d.getnblogs(userName,tracker);     // number of blogs varied from last week
		session.setAttribute("nblogs", nblogs);



		int nblogposts = d.getnblogposts(userName,tracker); // number of blogsposts
		session.setAttribute("nblogposts", nblogposts);



		int nbloggers = d.getnbloggers(userName,tracker); // number of bloggers
		session.setAttribute("nbloggers", nbloggers);



		double npsenti = d.getnpsenti(userName,tracker); // number of positive sentiments
		session.setAttribute("npsenti", npsenti);



		double nnsenti = d.getnnsenti(userName,tracker); // number of positive sentiments
		session.setAttribute("nnsenti", nnsenti);


		ArrayList<ArrayList<String>> nlocation = new ArrayList<ArrayList<String>>();
		ArrayList<ArrayList<String>> location = new ArrayList<ArrayList<String>>();  // country names
		nlocation = d.getnlocation(date,userName,tracker);
		
		int result=0;
		System.out.println("size = "+nlocation.size());
		for(int i = 0; i < nlocation.size(); i++)
		{

			result += Integer.parseInt(nlocation.get(i).get(0));

		}   
		for(int i = 0; i < nlocation.size(); i++)
		{
			int x = (int)((float)(Integer.parseInt(nlocation.get(i).get(0)))/(float)(result)*100);
			System.out.println("  "+x);
			nlocation.get(i).set(0,Integer.toString(x));
			System.out.println("  "+nlocation.get(i).get(1));			
			nlocation.get(i).set(1, nlocation.get(i).get(1).replaceAll(".*,",""));
			System.out.println("  "+nlocation.get(i).get(0));
			System.out.println("  "+nlocation.get(i).get(1));
			ArrayList<String> s = new ArrayList<String>();   //country names
			s.add(nlocation.get(i).get(0));
			s.add(nlocation.get(i).get(1));
			location.add(s);
			
		}   
		
		CountryCodes cc = new CountryCodes();
		
		
		for(int i=0;i<location.size(); i++)				//country names
		{
			location.get(i).set(1,cc.names.get(location.get(i).get(1)));
		}
		session.setAttribute("nloc", location);
		
		
		Map<String, Object> config = new HashMap<String, Object>();
		//if you need pretty printing
		config.put("javax.json.stream.JsonGenerator.prettyPrinting", Boolean.valueOf(true));
		JsonBuilderFactory factory1 = Json.createBuilderFactory(config);
		ArrayList<String> a1 = new ArrayList<String>();
		//JSONArray mainArray1 = new JSONArray();
		for(int i = 0; i < nlocation.size(); i++)
		{	

			String s = new String();
			String countryFound = nlocation.get(i).get(1);
			if(countryFound!= "Undefined"){
				s=nlocation.get(i).get(1).toLowerCase();
				JsonObject jvalue = factory1.createObjectBuilder()
						.add(s,(nlocation.get(i).get(0)))
						.build();
				a1.add( jvalue.toString());

			}

		}

		String finaldata = new String();
		ArrayList<String> t1 = new ArrayList<String>();
		for(int i=0;i<a1.size();i++)
		{
			String temp = a1.get(i);
			temp = temp.replace("{", "");
			temp = temp.replace("}", "");
			t1.add(temp);
			finaldata=finaldata+temp+",";

		}


		session.setAttribute("data", finaldata);
		System.out.println("fd "+finaldata);  
		
		for(int i = 0; i < nlocation.size()-1; i++)
		{
               	
                nlocation.get(i).get(0);
                nlocation.get(i).set(1, nlocation.get(i).get(1).replaceAll(".*,",""));
                System.out.println("fd "+nlocation.get(i).get(1));
  		} 
		
		ArrayList<ArrayList<String>> nlanguage = new ArrayList<ArrayList<String>>();
		nlanguage = d.getnlanguage(userName,tracker);
		ArrayList<ArrayList<String>> nlg = new ArrayList<ArrayList<String>>();
		for(int i=0;i<nlanguage.size();i++)
		{
			ArrayList<String> t = new ArrayList<String>();
			t.add(nlanguage.get(i).get(0));
			t.add(nlanguage.get(i).get(1));
			nlg.add(t);
		}
		session.setAttribute("nlg", nlg);
		//System.out.println(" "+nlg.get(0).get(0)+" "+nlg.get(0).get(1));
		int sumlang=0;
		ArrayList<String> nposts = new  ArrayList<String>();
		for(int i=0; i<nlanguage.size();i++)
		{
			sumlang = sumlang + Integer.parseInt(nlanguage.get(i).get(0));
			nposts.add(nlanguage.get(i).get(0));
		}
		
		for(int i=0; i<nlanguage.size();i++)
		{	Double l;
			nlanguage.get(i).set(0, (Double.toString((Double.parseDouble((nlanguage.get(i).get(0)))/sumlang)*100)));
			l = Double.parseDouble(nlanguage.get(i).get(0));
			DecimalFormat df = new DecimalFormat("#.##");  
			l = Double.valueOf(df.format(l));
			nlanguage.get(i).set(0, String.valueOf(l));
			
		}
				
		
		
		
		ArrayList<ArrayList<String>> nlang = new ArrayList<ArrayList<String>> ();
		String e;
		String b ;//= new String();
		ArrayList<String> b2 = new ArrayList<String>();
		
		for(int i=0;i<nlanguage.size();i++)
		{
			ArrayList<String> c1 = new ArrayList<String>();
			b = nlanguage.get(i).get(0);
			e= "% "+nlanguage.get(i).get(1)+" ("+nposts.get(i)+" posts)";
			c1.add(b);
			c1.add(e);
			nlang.add(c1);

			b +="% "+nlanguage.get(i).get(1)+" ("+nposts.get(i)+" posts)";
			b2.add(b);
		}
		
		
		
		int r1= 105, r2=130;
		String r3 ="["+r1+","+r2+"]";
		JsonBuilderFactory factory = Json.createBuilderFactory(config);
		ArrayList<String> a = new ArrayList<String>();

		for(int i=0;i<b2.size();i++)
		{	 
			String p = "placeHolderStyle";
			JsonObject jvalue = factory.createObjectBuilder()
					.add("name",i+1)
					.add("type","pie")
					.add("clockWise",false)
					.add("radius",r3)
					.add("itemStyle","dataStyle")
					.add("data", factory.createArrayBuilder()
							.add(factory.createObjectBuilder()
									.add("value", nlang.get(i).get(0))
									.add("name", b2.get(i)))
							.add(factory.createObjectBuilder()
									.add("value", (100-Double.parseDouble(nlang.get(i).get(0))))
									.add("name", "others")
									.add("itemStyle", p)))
					.build();

			r1= r1-5;
			r2 = r2-5;
			r3 = "["+r1+","+r2+"]";
			//	mainArray.put((JsonObject)jvalue);
			a.add( jvalue.toString());

		}

		JSONArray nl = new JSONArray(b2);
		ArrayList<String> t = new ArrayList<String>();
		for(int i=0;i<a.size();i++)
		{
			String temp = a.get(i);
			temp = temp.replace("\"placeHolderStyle\"", "placeHolderStyle");
			temp = temp.replace("\"[", "[");
			temp = temp.replace("]\"", "]");
			t.add(temp);

		}

		
		ArrayList<ArrayList<String>> tree = d.tree_result(userName, tracker);
		for(int i=0;i<tree.size();i++)
		{
			
			System.out.println(" "+tree.get(i).get(0)+" "+tree.get(i).get(1)+" "+tree.get(i).get(2)+" "+tree.get(i).get(3)+" ");
		}
		session.setAttribute("tree", tree);
		session.setAttribute("nlang", nl);
		session.setAttribute("series", t);
		response.setContentType("text/html");
		response.sendRedirect("dashboard.jsp");

		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("tracker")==null && request.getParameter("tracker")==null)
		{
			
			session.setAttribute("nblogs", 0);
			session.setAttribute("nblogposts", 0);
			session.setAttribute("nbloggers", 0);
			session.setAttribute("npsenti", 0);
			session.setAttribute("nnsenti", 0);
			session.setAttribute("nloc", "");
			session.setAttribute("data", "");
			session.setAttribute("nlang", "");
			session.setAttribute("series", "");			
			response.setContentType("text/html");
	    	response.sendRedirect("dashboard.jsp");
		}
		else
		{
			
			if(request.getParameter("tracker")!=null)
			{
				String tracker = request.getParameter("tracker");
				session.setAttribute("tracker", tracker);
			}
		String tracker = (String) session.getAttribute("tracker");
		String userName = (String) session.getAttribute("user");
		Date date = new Date();
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.DATE, -7);
		date.setTime(c.getTime().getTime());
		blogtracker.util.Dashboard d = new blogtracker.util.Dashboard(userName,tracker);

		int nblogs = d.getnblogs(userName,tracker);     // number of blogs 
		session.setAttribute("nblogs", nblogs);


		int nblogposts = d.getnblogposts(userName,tracker); // number of blogsposts
		session.setAttribute("nblogposts", nblogposts);


		int nbloggers = d.getnbloggers(userName,tracker); // number of bloggers
		session.setAttribute("nbloggers", nbloggers);


		double npsenti = d.getnpsenti(userName,tracker); // number of positive sentiments
		session.setAttribute("npsenti", npsenti);


		double nnsenti = d.getnnsenti(userName,tracker); // number of positive sentiments
		session.setAttribute("nnsenti", nnsenti);

		ArrayList<ArrayList<String>> nlocation = new ArrayList<ArrayList<String>>();
		ArrayList<ArrayList<String>> location = new ArrayList<ArrayList<String>>();
		nlocation = d.getnlocation(date,userName,tracker);
		
		int result=0;
		for(int i = 0; i < nlocation.size(); i++)
		{
			result += Integer.parseInt(nlocation.get(i).get(0));
		}   
		for(int i = 0; i < nlocation.size(); i++)
		{
			int x = (int)((float)(Integer.parseInt(nlocation.get(i).get(0)))/(float)(result)*100);
			nlocation.get(i).set(0,Integer.toString(x));
			nlocation.get(i).set(1, nlocation.get(i).get(1).replaceAll(".*,",""));
			ArrayList<String> s = new ArrayList<String>();
			s.add(nlocation.get(i).get(0));
			s.add(nlocation.get(i).get(1));
			location.add(s);
		}   
		CountryCodes cc = new CountryCodes();
		for(int i=0;i<location.size(); i++)				//country names
		{
			location.get(i).set(1,cc.names.get(location.get(i).get(1)));
		}
		session.setAttribute("nloc", location);
		Map<String, Object> config = new HashMap<String, Object>();
		//if you need pretty printing
		config.put("javax.json.stream.JsonGenerator.prettyPrinting", Boolean.valueOf(true));
		JsonBuilderFactory factory1 = Json.createBuilderFactory(config);
		ArrayList<String> a1 = new ArrayList<String>();
		//JSONArray mainArray1 = new JSONArray();
		for(int i = 0; i < nlocation.size(); i++)
		{	
			String s = new String();
			//String countryFound = cc.getCode(nlocation.get(i).get(1));
			String countryFound = nlocation.get(i).get(1);
			if(countryFound!= "Undefined"){
				s=nlocation.get(i).get(1).toLowerCase();
				//s = s.replace("_", "");
				JsonObject jvalue = factory1.createObjectBuilder()
						.add(s,(nlocation.get(i).get(0)))
						.build();
				a1.add( jvalue.toString());

			
			}
		}
		String finaldata = new String();
		ArrayList<String> t1 = new ArrayList<String>();
		for(int i=0;i<a1.size();i++)
		{
			String temp = a1.get(i);
			temp = temp.replace("{", "");
			temp = temp.replace("}", "");
			t1.add(temp);
			finaldata=finaldata+temp+",";
		}

		session.setAttribute("data", finaldata);
		System.out.println("fd "+finaldata);  
		  
		for(int i = 0; i < nlocation.size()-1; i++)
		{
               	
                nlocation.get(i).get(0);
                nlocation.get(i).set(1, nlocation.get(i).get(1).replaceAll(".*,",""));
                System.out.println("fs "+nlocation.get(i).get(1));
  		}  
		
		ArrayList<ArrayList<String>> nlanguage = new ArrayList<ArrayList<String>>();
		nlanguage = d.getnlanguage(userName,tracker);
		ArrayList<ArrayList<String>> nlg = new ArrayList<ArrayList<String>>();
		for(int i=0;i<nlanguage.size();i++)
		{
			ArrayList<String> t = new ArrayList<String>();
			t.add(nlanguage.get(i).get(0));
			t.add(nlanguage.get(i).get(1));
			nlg.add(t);
		}
		session.setAttribute("nlg", nlg);
		System.out.println(" "+nlg.get(0).get(0)+" "+nlg.get(0).get(1));
		int sumlang=0;
		ArrayList<String> nposts = new  ArrayList<String>();
		for(int i=0; i<nlanguage.size();i++)
		{
			sumlang = sumlang + Integer.parseInt(nlanguage.get(i).get(0));
			nposts.add(nlanguage.get(i).get(0));
		}
		for(int i=0; i<nlanguage.size();i++)
		{
			Double l;
			nlanguage.get(i).set(0, (Double.toString((Double.parseDouble((nlanguage.get(i).get(0)))/sumlang)*100)));
			l = Double.parseDouble(nlanguage.get(i).get(0));
			DecimalFormat df = new DecimalFormat("#.##");  
			l = Double.valueOf(df.format(l));
			nlanguage.get(i).set(0, String.valueOf(l));
		}

		ArrayList<ArrayList<String>> nlang = new ArrayList<ArrayList<String>> ();
		String e;
		String b ;//= new String();
		ArrayList<String> b2 = new ArrayList<String>();
		for(int i=0;i<nlanguage.size();i++)
		{
			ArrayList<String> c1 = new ArrayList<String>();
			b = nlanguage.get(i).get(0);
			e= "% "+nlanguage.get(i).get(1)+" ("+nposts.get(i)+" posts)";
			c1.add(b);
			c1.add(e);
			nlang.add(c1);
			b +="% "+nlanguage.get(i).get(1)+" ("+nposts.get(i)+" posts)";
			b2.add(b);
		}

		

		int r1= 105, r2=130;
		String r3 ="["+r1+","+r2+"]";
		JsonBuilderFactory factory = Json.createBuilderFactory(config);
		// JsonObject value = (JsonObject) factory.createObjectBuilder();
		ArrayList<String> a = new ArrayList<String>();
		//JSONArray mainArray = new JSONArray();

		for(int i=0;i<b2.size();i++)
		{	 
			String p = "placeHolderStyle";
			JsonObject jvalue = factory.createObjectBuilder()
					.add("name",i+1)
					.add("type","pie")
					.add("clockWise",false)
					.add("radius",r3)
					.add("itemStyle","dataStyle")
					.add("data", factory.createArrayBuilder()
							.add(factory.createObjectBuilder()
									.add("value", nlang.get(i).get(0))
									.add("name", b2.get(i)))
							.add(factory.createObjectBuilder()
									.add("value", (100-Double.parseDouble(nlang.get(i).get(0))))
									.add("name", "others")
									.add("itemStyle", p)))
					.build();

			r1= r1-5;
			r2 = r2-5;
			r3 = "["+r1+","+r2+"]";
			a.add( jvalue.toString());
		}

		JSONArray nl = new JSONArray(b2);
		ArrayList<String> t = new ArrayList<String>();
		for(int i=0;i<a.size();i++)
		{
			String temp = a.get(i);
			temp = temp.replace("\"placeHolderStyle\"", "placeHolderStyle");
			temp = temp.replace("\"[", "[");
			temp = temp.replace("]\"", "]");
			t.add(temp);
		}
		ArrayList<ArrayList<String>> tree = d.tree_result(userName, tracker);
		for(int i=0;i<tree.size();i++)
		{
			
			System.out.println("  "+tree.get(i).get(0)+" "+tree.get(i).get(1)+" "+tree.get(i).get(2)+" "+tree.get(i).get(3)+" ");
		}
		session.setAttribute("tree", tree);
		session.setAttribute("nlang", nl);
		session.setAttribute("series", t);
		response.setContentType("text/html");
		response.sendRedirect("dashboard.jsp");
		}
	}
}