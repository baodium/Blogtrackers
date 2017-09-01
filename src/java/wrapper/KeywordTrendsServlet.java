package wrapper;

import java.io.IOException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Month;
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

import blogtracker.gui.blogtrackers.BeanAllSites;
import blogtracker.util.Common;
import blogtracker.util.KeywordNetwork;
import blogtracker.util.KeywordResult;
import blogtracker.util.KeywordTrendsUtil;
import blogtracker.util.TrackerDialog; 

/**
 * Servlet implementation class KeywordsTrend
 */
@WebServlet("/KeywordTrendsServlet")
public class KeywordTrendsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	TrackerDialog trackerDialog= new TrackerDialog();
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public KeywordTrendsServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session= request.getSession();
		session.setAttribute("key_names", "");
		session.setAttribute("trend", "");
		response.getWriter().append("Served at: ").append(request.getContextPath());
		response.setContentType("text/html");
		response.sendRedirect("keyword_trends.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		System.out.println("lllll in post");
		request.setCharacterEncoding("UTF-8");
		HttpSession session= request.getSession();
		if((session.getAttribute("tracker")==null && request.getParameter("tracker")==null) &&
		   (session.getAttribute("datepicked")==null && request.getParameter("datepicked")==null) &&
		   (session.getAttribute("tags") ==null && request.getParameter("searchButton")==null))
		{
			session.setAttribute("key_names", "");
			session.setAttribute("trend", "");
		}
		else
		{
			if(request.getParameter("tracker")!=null)
			{
				String tracker = request.getParameter("tracker");
				session.setAttribute("tracker", tracker);
				//Saad's Code
				String userName = (String) session.getAttribute("user");
				String selectedSites=trackerDialog.getSelectedSites(userName,tracker);
				ArrayList<BeanAllSites> allSites=trackerDialog.getSiteNames(selectedSites);
				if(session.getAttribute("bsName")!=null)
					session.removeAttribute("bsName");
				session.setAttribute("allSepSites", allSites);
				//Ends here
			}
			if(request.getParameter("datepicked")!=null)
			{
				session.setAttribute("datepicked", request.getParameter("datepicked"));
			}
			if(request.getParameter("searchButton")!=null)
			{
				String tags = request.getParameter("searchText");
				session.setAttribute("tags",tags);
				System.out.println("iiiiiiiii"+tags);
			}
			if(request.getParameter("spanmonthly")==null && request.getParameter("spanyearly") ==null 
					&& request.getParameter("spanweekly") ==null && request.getParameter("spandaily")==null 
					&& request.getParameter("xychange") == null && session.getAttribute("tags") !=null
					&& session.getAttribute("datepicked")!= null && session.getAttribute("tracker")!=null){

				String tracker = (String) session.getAttribute("tracker");
				String userName = (String) session.getAttribute("user");
				String key = (String) session.getAttribute("tags");

				String date =session.getAttribute("datepicked").toString();
				String arr[] = date.split("-", 2);
				String sdate1 = arr[0];   
				String sdate2 = arr[1];
				sdate2=sdate2.trim();  // date 2 will have space trim it
				int mm1=Month.valueOf(sdate1.substring(0, sdate1.indexOf(' ')).toUpperCase()).getValue();
				int mm2=Month.valueOf(sdate2.substring(0, sdate2.indexOf(' ')).toUpperCase()).getValue();

				String tempdate[] = sdate1.split(" ", 3);
				String dd=tempdate[1];
				String year=tempdate[2];
				String d1 = year+"-"+mm1+"-"+dd;
				d1=d1.replace(" ", "");

				String tempdate2[] = sdate2.split(" ", 3);
				dd=tempdate2[1];
				year=tempdate2[2];
				String d2 = year+"-"+mm2+"-"+dd;
				d2=d2.replace(" ", "");

				DateFormat df = new SimpleDateFormat("yyyy-MM-dd"); 


				try {
					Date startdate = df.parse(d1);
					Date enddate = df.parse(d2);

					Common c = new Common();
					long diff[] = c.differenceBetweenDates(startdate,enddate);

					TrackerDialog dialog= new TrackerDialog();
					String selectedSites=dialog.getSelectedSites(userName,tracker);
					KeywordTrendsUtil ku = new KeywordTrendsUtil();

					ArrayList<KeywordResult> res = null;
					String span = null;
					Map<String, ArrayList<KeywordResult>> reslist = new HashMap<String, ArrayList<KeywordResult>>();
					Map<String, ArrayList<String>> trendlist = new HashMap<String, ArrayList<String>>();


					String[] arrayOfString = key.split(",");

					if(diff[2]!=0)
					{

						span="year";
						for(int k=0;k<arrayOfString.length;k++)
						{	
							res = ku.getkwyearly(startdate,enddate,selectedSites,arrayOfString[k]);
							reslist.put(arrayOfString[k], res);
						}
						session.setAttribute("span", "\"year\"");
					}
					else if(diff[1]!=0)
					{
						span="month";
						for(int k=0;k<arrayOfString.length;k++)
						{	
							res = ku.getkwmonthly(startdate,enddate,selectedSites,arrayOfString[k]);
							reslist.put(arrayOfString[k], res);
						}
						session.setAttribute("span", "\"month\"");
					}
					else if(diff[0]!=0 && diff[0]>7)
					{


						span="week";
						for(int k=0;k<arrayOfString.length;k++)
						{	
							res = ku.getkwweekly(startdate,enddate,selectedSites,arrayOfString[k]);
							reslist.put(arrayOfString[k], res);
						}
						session.setAttribute("span", "\"week\"");
					}
					else
					{
						span="day";
						for(int k=0;k<arrayOfString.length;k++)
						{	
							res = ku.getkwdaily(startdate,enddate,selectedSites,arrayOfString[k]);
							reslist.put(arrayOfString[k], res);
						}
						session.setAttribute("span", "\"day\"");
					}



					Map<String, Object> config = new HashMap<String, Object>();
					//if you need pretty printing
					config.put("javax.json.stream.JsonGenerator.prettyPrinting", Boolean.valueOf(true));
					JsonBuilderFactory factory = Json.createBuilderFactory(config);
					for(int k=0;k<arrayOfString.length;k++)
					{
						ArrayList<String> trend = new ArrayList<String>();
						// Get an iterator
						int i = 0;
						while(i<reslist.get(arrayOfString[k]).size()) {
							Date t = df.parse(reslist.get(arrayOfString[k]).get(i).date);
							Calendar c1 = Calendar.getInstance();
							c1.setTime(t);
							c1.add(Calendar.MONTH, -1);
							t=c1.getTime();
							String tt=df.format(t).toString();
							JsonObject jvalue = factory.createObjectBuilder()
									.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
									.add("y",reslist.get(arrayOfString[k]).get(i).count)
									.build();
							trend.add( jvalue.toString());
							i++;
						}


						for(int ii=0;ii<trend.size();ii++)
						{
							String temp = trend.get(ii);
							temp=temp.replaceAll("\"","");
							trend.set(ii,temp);
						}

						trendlist.put(arrayOfString[k], trend);
					}
					//end it
					session.setAttribute("scale", span);
					session.setAttribute("trend", trendlist);
					session.setAttribute("keywordres", reslist);

				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}

			if(request.getParameter("spanyearly")!=null)
			{
				if(session.getAttribute("datepicked")!=null && session.getAttribute("tracker")!=null
						&& session.getAttribute("tags") !=null)
				{
					String tracker = (String) session.getAttribute("tracker");
					String userName = (String) session.getAttribute("user");
					String key = (String) session.getAttribute("tags");
					String[] arrayOfString = key.split(",");
					Map<String, ArrayList<KeywordResult>> reslist = new HashMap<String, ArrayList<KeywordResult>>();
					Map<String, ArrayList<String>> trendlist = new HashMap<String, ArrayList<String>>();

					try{
						String date =session.getAttribute("datepicked").toString();
						String arr[] = date.split("-", 2);
						String sdate1 = arr[0];   
						String sdate2 = arr[1];
						sdate2=sdate2.trim();  // date 2 will have space trim it
						int mm1=Month.valueOf(sdate1.substring(0, sdate1.indexOf(' ')).toUpperCase()).getValue();
						int mm2=Month.valueOf(sdate2.substring(0, sdate2.indexOf(' ')).toUpperCase()).getValue();

						String tempdate[] = sdate1.split(" ", 3);
						String dd=tempdate[1];
						String year=tempdate[2];
						String d1 = year+"-"+mm1+"-"+dd;
						d1=d1.replace(" ", "");

						String tempdate2[] = sdate2.split(" ", 3);
						dd=tempdate2[1];
						year=tempdate2[2];
						String d2 = year+"-"+mm2+"-"+dd;
						d2=d2.replace(" ", "");
						DateFormat df = new SimpleDateFormat("yyyy-MM-dd"); 

						Date startdate = df.parse(d1);
						Date enddate = df.parse(d2);


						Map<String, Object> config = new HashMap<String, Object>();
						//if you need pretty printing
						config.put("javax.json.stream.JsonGenerator.prettyPrinting", Boolean.valueOf(true));

						String span;
						span="year";
						TrackerDialog dialog= new TrackerDialog();
						String selectedSites=dialog.getSelectedSites(userName,tracker);
						KeywordTrendsUtil ku = new KeywordTrendsUtil();
						ArrayList<KeywordResult> res = null;
						for(int k=0;k<arrayOfString.length;k++)
						{	
							res = ku.getkwyearly(startdate,enddate,selectedSites,arrayOfString[k]);
							reslist.put(arrayOfString[k], res);
						}

						JsonBuilderFactory factory = Json.createBuilderFactory(config);
						for(int k=0;k<arrayOfString.length;k++)
						{
							ArrayList<String> trend = new ArrayList<String>();
							// Get an iterator
							int i = 0;
							while(i<reslist.get(arrayOfString[k]).size()) {
								Date t = df.parse(reslist.get(arrayOfString[k]).get(i).date);
								Calendar c1 = Calendar.getInstance();
								c1.setTime(t);
								c1.add(Calendar.MONTH, -1);
								t=c1.getTime();
								String tt=df.format(t).toString();
								JsonObject jvalue = factory.createObjectBuilder()
										.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
										.add("y",reslist.get(arrayOfString[k]).get(i).count)
										.build();
								trend.add( jvalue.toString());
								i++;
							}



							for(int ii=0;ii<trend.size();ii++)
							{
								String temp = trend.get(ii);
								temp=temp.replaceAll("\"","");
								trend.set(ii,temp);
							}
							trendlist.put(arrayOfString[k], trend);
						}
						session.setAttribute("scale", span);
						session.setAttribute("trend", trendlist);
						session.setAttribute("span", "\"year\"");
						session.setAttribute("keywordres", reslist);

					} catch (ParseException e) {
						e.printStackTrace();
					}	
				}
				else
				{
					session.setAttribute("scale", "");
					session.setAttribute("trend", "");
					session.setAttribute("span", "\"year\"");

				}

			}
			if(request.getParameter("spanmonthly")!=null)
			{
				if(session.getAttribute("datepicked")!=null && session.getAttribute("tracker")!=null
						&& session.getAttribute("tags") !=null)
				{
					String tracker = (String) session.getAttribute("tracker");
					String userName = (String) session.getAttribute("user");
					String key = (String) session.getAttribute("tags");
					String[] arrayOfString = key.split(",");
					Map<String, ArrayList<KeywordResult>> reslist = new HashMap<String, ArrayList<KeywordResult>>();
					Map<String, ArrayList<String>> trendlist = new HashMap<String, ArrayList<String>>();

					try{
						String date =session.getAttribute("datepicked").toString();
						String arr[] = date.split("-", 2);
						String sdate1 = arr[0];   
						String sdate2 = arr[1];
						sdate2=sdate2.trim();  // date 2 will have space trim it
						int mm1=Month.valueOf(sdate1.substring(0, sdate1.indexOf(' ')).toUpperCase()).getValue();
						int mm2=Month.valueOf(sdate2.substring(0, sdate2.indexOf(' ')).toUpperCase()).getValue();

						String tempdate[] = sdate1.split(" ", 3);
						String dd=tempdate[1];
						String year=tempdate[2];
						String d1 = year+"-"+mm1+"-"+dd;
						d1=d1.replace(" ", "");

						String tempdate2[] = sdate2.split(" ", 3);
						dd=tempdate2[1];
						year=tempdate2[2];
						String d2 = year+"-"+mm2+"-"+dd;
						d2=d2.replace(" ", "");
						DateFormat df = new SimpleDateFormat("yyyy-MM-dd"); 

						Date startdate = df.parse(d1);
						Date enddate = df.parse(d2);


						Map<String, Object> config = new HashMap<String, Object>();
						//if you need pretty printing
						config.put("javax.json.stream.JsonGenerator.prettyPrinting", Boolean.valueOf(true));

						String span;
						span="month";
						TrackerDialog dialog= new TrackerDialog();
						String selectedSites=dialog.getSelectedSites(userName,tracker);
						KeywordTrendsUtil ku = new KeywordTrendsUtil();
						ArrayList<KeywordResult> res = null;
						for(int k=0;k<arrayOfString.length;k++)
						{	
							res = ku.getkwmonthly(startdate,enddate,selectedSites,arrayOfString[k]);
							reslist.put(arrayOfString[k], res);
						}							
						JsonBuilderFactory factory = Json.createBuilderFactory(config);

						for(int k=0;k<arrayOfString.length;k++)
						{
							ArrayList<String> trend = new ArrayList<String>();
							// Get an iterator
							int i = 0;
							while(i<reslist.get(arrayOfString[k]).size()) {
								Date t = df.parse(reslist.get(arrayOfString[k]).get(i).date);
								Calendar c1 = Calendar.getInstance();
								c1.setTime(t);
								c1.add(Calendar.MONTH, -1);
								t=c1.getTime();
								String tt=df.format(t).toString();
								JsonObject jvalue = factory.createObjectBuilder()
										.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
										.add("y",reslist.get(arrayOfString[k]).get(i).count)
										.build();
								trend.add( jvalue.toString());
								i++;
							}

							for(int ii=0;ii<trend.size();ii++)
							{
								String temp = trend.get(ii);
								temp=temp.replaceAll("\"","");
								trend.set(ii,temp);
							}
							trendlist.put(arrayOfString[k], trend);
						}
						session.setAttribute("scale", span);
						session.setAttribute("trend", trendlist);
						session.setAttribute("span", "\"month\"");
						session.setAttribute("keywordres", reslist);

					} catch (ParseException e) {
						e.printStackTrace();
					}	
				}
				else
				{
					session.setAttribute("scale", "");
					session.setAttribute("trend", "");
					session.setAttribute("span", "\"month\"");

				}

			}
			if(request.getParameter("spanweekly")!=null)
			{
				if(session.getAttribute("datepicked")!=null && session.getAttribute("tracker")!=null
						&& session.getAttribute("tags") !=null)
				{
					String tracker = (String) session.getAttribute("tracker");
					String userName = (String) session.getAttribute("user");
					String key = (String) session.getAttribute("tags");
					String[] arrayOfString = key.split(",");
					Map<String, ArrayList<KeywordResult>> reslist = new HashMap<String, ArrayList<KeywordResult>>();
					Map<String, ArrayList<String>> trendlist = new HashMap<String, ArrayList<String>>();

					try{
						String date =session.getAttribute("datepicked").toString();
						String arr[] = date.split("-", 2);
						String sdate1 = arr[0];   
						String sdate2 = arr[1];
						sdate2=sdate2.trim();  // date 2 will have space trim it
						int mm1=Month.valueOf(sdate1.substring(0, sdate1.indexOf(' ')).toUpperCase()).getValue();
						int mm2=Month.valueOf(sdate2.substring(0, sdate2.indexOf(' ')).toUpperCase()).getValue();

						String tempdate[] = sdate1.split(" ", 3);
						String dd=tempdate[1];
						String year=tempdate[2];
						String d1 = year+"-"+mm1+"-"+dd;
						d1=d1.replace(" ", "");

						String tempdate2[] = sdate2.split(" ", 3);
						dd=tempdate2[1];
						year=tempdate2[2];
						String d2 = year+"-"+mm2+"-"+dd;
						d2=d2.replace(" ", "");
						DateFormat df = new SimpleDateFormat("yyyy-MM-dd"); 

						Date startdate = df.parse(d1);
						Date enddate = df.parse(d2);


						Map<String, Object> config = new HashMap<String, Object>();
						//if you need pretty printing
						config.put("javax.json.stream.JsonGenerator.prettyPrinting", Boolean.valueOf(true));

						String span;
						span="week";
						TrackerDialog dialog= new TrackerDialog();
						String selectedSites=dialog.getSelectedSites(userName,tracker);
						KeywordTrendsUtil ku = new KeywordTrendsUtil();
						ArrayList<KeywordResult> res = null;
						for(int k=0;k<arrayOfString.length;k++)
						{	
							res = ku.getkwweekly(startdate,enddate,selectedSites,arrayOfString[k]);
							reslist.put(arrayOfString[k], res);
						}

						JsonBuilderFactory factory = Json.createBuilderFactory(config);
						for(int k=0;k<arrayOfString.length;k++)
						{
							ArrayList<String> trend = new ArrayList<String>();
							// Get an iterator
							int i = 0;
							while(i<reslist.get(arrayOfString[k]).size()) {
								Date t = df.parse(reslist.get(arrayOfString[k]).get(i).date);
								Calendar c1 = Calendar.getInstance();
								c1.setTime(t);
								c1.add(Calendar.MONTH, -1);
								t=c1.getTime();
								String tt=df.format(t).toString();
								JsonObject jvalue = factory.createObjectBuilder()
										.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
										.add("y",reslist.get(arrayOfString[k]).get(i).count)
										.build();
								trend.add( jvalue.toString());
								i++;
							}

							for(int ii=0;ii<trend.size();ii++)
							{
								String temp = trend.get(ii);
								temp=temp.replaceAll("\"","");
								trend.set(ii,temp);
							}
							trendlist.put(arrayOfString[k], trend);
						}
						session.setAttribute("scale", span);
						session.setAttribute("trend", trendlist);
						session.setAttribute("span", "\"week\"");
						session.setAttribute("keywordres", reslist);

					} catch (ParseException e) {
						e.printStackTrace();
					}	
				}
				else
				{
					session.setAttribute("scale", "");
					session.setAttribute("trend", "");
					session.setAttribute("span", "\"week\"");

				}

			}
			if(request.getParameter("spandaily")!=null)
			{
				if(session.getAttribute("datepicked")!=null && session.getAttribute("tracker")!=null 
						&& session.getAttribute("tags") !=null)
				{
					String tracker = (String) session.getAttribute("tracker");
					String userName = (String) session.getAttribute("user");
					String key = (String) session.getAttribute("tags");
					String[] arrayOfString = key.split(",");
					Map<String, ArrayList<KeywordResult>> reslist = new HashMap<String, ArrayList<KeywordResult>>();
					Map<String, ArrayList<String>> trendlist = new HashMap<String, ArrayList<String>>();

					try{
						String date =session.getAttribute("datepicked").toString();
						String arr[] = date.split("-", 2);
						String sdate1 = arr[0];   
						String sdate2 = arr[1];
						sdate2=sdate2.trim();  // date 2 will have space trim it
						int mm1=Month.valueOf(sdate1.substring(0, sdate1.indexOf(' ')).toUpperCase()).getValue();
						int mm2=Month.valueOf(sdate2.substring(0, sdate2.indexOf(' ')).toUpperCase()).getValue();

						String tempdate[] = sdate1.split(" ", 3);
						String dd=tempdate[1];
						String year=tempdate[2];
						String d1 = year+"-"+mm1+"-"+dd;
						d1=d1.replace(" ", "");

						String tempdate2[] = sdate2.split(" ", 3);
						dd=tempdate2[1];
						year=tempdate2[2];
						String d2 = year+"-"+mm2+"-"+dd;
						d2=d2.replace(" ", "");
						DateFormat df = new SimpleDateFormat("yyyy-MM-dd"); 

						Date startdate = df.parse(d1);
						Date enddate = df.parse(d2);

						Map<String, Object> config = new HashMap<String, Object>();
						//if you need pretty printing
						config.put("javax.json.stream.JsonGenerator.prettyPrinting", Boolean.valueOf(true));

						String span;
						span="day";
						TrackerDialog dialog= new TrackerDialog();
						String selectedSites=dialog.getSelectedSites(userName,tracker);
						KeywordTrendsUtil ku = new KeywordTrendsUtil();
						ArrayList<KeywordResult> res = null;
						for(int k=0;k<arrayOfString.length;k++)
						{	
							res = ku.getkwdaily(startdate,enddate,selectedSites,arrayOfString[k]);
							reslist.put(arrayOfString[k], res);
						}
						JsonBuilderFactory factory = Json.createBuilderFactory(config);
						for(int k=0;k<arrayOfString.length;k++)
						{
							ArrayList<String> trend = new ArrayList<String>();
							// Get an iterator
							int i = 0;
							while(i<reslist.get(arrayOfString[k]).size()) {
								Date t = df.parse(reslist.get(arrayOfString[k]).get(i).date);
								Calendar c1 = Calendar.getInstance();
								c1.setTime(t);
								c1.add(Calendar.MONTH, -1);
								t=c1.getTime();
								String tt=df.format(t).toString();
								JsonObject jvalue = factory.createObjectBuilder()
										.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
										.add("y",reslist.get(arrayOfString[k]).get(i).count)
										.build();
								trend.add( jvalue.toString());
								i++;
							}

							for(int ii=0;ii<trend.size();ii++)
							{
								String temp = trend.get(ii);
								temp=temp.replaceAll("\"","");
								trend.set(ii,temp);
							}
							trendlist.put(arrayOfString[k], trend);
						}
						session.setAttribute("scale", span);
						session.setAttribute("trend", trendlist);
						session.setAttribute("span", "\"day\"");
						session.setAttribute("keywordres", reslist);

					} catch (ParseException e) {
						e.printStackTrace();
					}	
				}
				else
				{
					session.setAttribute("scale", "");
					session.setAttribute("trend", "");
					session.setAttribute("span", "\"day\"");

				}

			}
			if(request.getParameter("xychange") != null )
			{

				String xyrec = request.getParameter("xychange");
				String point[] = xyrec.split(",",3);
				String x = point[0].replaceAll("x:", "");
				String xd[] = point[0].split(" ");

				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				DateFormat originalFormat = new SimpleDateFormat("MMMMddyyyy", Locale.ENGLISH);
				DateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd");
				String formattedDate;
				String selecteddate;
				String yval;
				yval=point[1].replaceAll("y:", "");
				yval=yval.replaceAll(" ", "");
				Date date;
				Date date1;
				String selectedkey = point[2];
				try {
					date = originalFormat.parse((xd[2]+xd[3]+xd[4]).toString());
					date1 = originalFormat.parse((xd[2]+xd[3]+xd[4]).toString());

					formattedDate = targetFormat.format(date);  // 20120821
					selecteddate = dateFormat.format(date);
					@SuppressWarnings("unchecked")
					Map<String, ArrayList<KeywordResult>> kr  = (Map<String, ArrayList<KeywordResult>>)session.getAttribute("keywordres");
					ArrayList<KeywordResult> kwr = kr.get(selectedkey);
					ArrayList<ArrayList<String>> key_names = new ArrayList<ArrayList<String>>();
					for(int i=0;i<kwr.size(); i++)
					{
						if(kwr.get(i).count == Integer.parseInt(yval) )
						{
							if (kwr.get(i).titles.size()>=50)
							{	
								for(int j=0;j<50;j++)
								{
									ArrayList<String> t = new ArrayList<String>();
									t.add(kwr.get(i).titles.get(j).get(0));
									t.add(kwr.get(i).titles.get(j).get(1));
									t.add(kwr.get(i).post.get(j).get(1));
									key_names.add(t);

								}
							}
							else
							{
								for(int j=0;j<kwr.get(i).titles.size();j++)
								{
									ArrayList<String> t = new ArrayList<String>();
									t.add(kwr.get(i).titles.get(j).get(0));
									t.add(kwr.get(i).titles.get(j).get(1));
									t.add(kwr.get(i).post.get(j).get(1));
									key_names.add(t);

								}	
							}

							break;
						}

					}
					session.setAttribute("key_names", key_names);
					KeywordTrendsUtil k = new KeywordTrendsUtil();
					KeywordNetwork kn = k.network(key_names);
					/*Map<String, Integer> idlist = new HashMap<String, Integer>();
					int h=1;
					for (String key : kn.nodelist.keySet()) {
						idlist.put(key, h++);
					}*/
					
					// top 5% code
					Map<String, Integer> netlist = new HashMap<String, Integer>();
					System.out.println("lll"+kn.netlist.size());
					int size = (int) (0.05*kn.netlist.size());
					System.out.println("lll"+size);
					for (Map.Entry<String, Integer> entry : kn.netlist.entrySet()) {
						  if (netlist.size() > size) break;
						    netlist.put(entry.getKey(),entry.getValue());
						}
					//ends here top 5%
					
					//for dangling nodes  - new idlist was made removing the old one
					Map<String, Integer> idlist = new HashMap<String, Integer>();
					int h=1;
					for (Map.Entry<String, Integer> entry : netlist.entrySet()) {
						System.out.println("kk"+entry.getKey()+"kk"+entry.getValue());
						String[] parts = entry.getKey().split("~", 2);
						System.out.println(" "+parts[0]+" "+parts[1]);
						if(!idlist.containsKey(parts[0]))
						{
							idlist.put(parts[0], h++);
						}
						if(!idlist.containsKey(parts[1]))
						{
							idlist.put(parts[1], h++);
						}
						
					}

				//	session.setAttribute("idlist", idlist);
					session.setAttribute("idlist", idlist);
					session.setAttribute("nodelist", kn.nodelist);
					session.setAttribute("netlist", netlist);// top 5% network

				} catch (ParseException | SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}


			}

		}
		response.setContentType("text/html");
		response.sendRedirect("keyword_trends.jsp");
	}



}