
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.IOException"%>
<%@page import="java.text.*"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.annotation.WebServlet"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="blogtracker.gui.blogtrackers.*"%>
<%@page import="blogtracker.util.*"%>
<%@page import="javax.json.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.json.*"%>
<%@page import="java.time.*"%>


<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
	
	<%
	Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	if (username == null || username == "") {
		response.sendRedirect("index.jsp");
	}
	
    ArrayList userinfo = (ArrayList)session.getAttribute("userinfo");
    
    
    final long serialVersionUID = 1L;
	/* PostingFrequencyDialog pfDialog= new PostingFrequencyDialog();
	Common common= new Common(); */
	TrackerDialog trackerDialog = new TrackerDialog();
	//BloggerInfoDialog biDialog= new BloggerInfoDialog();
	
	
	
	String st_spa = (null == session.getAttribute("st_span")) ? "" : session.getAttribute("st_span").toString();
	
	if((session.getAttribute("tracker")==null && request.getParameter("tracker")==null)
			&& ( session.getAttribute("datepicked")==null && request.getParameter("datepicked")==null))
	{
		session.setAttribute("trendneg", "");
		session.setAttribute("trendpos", "");
		session.setAttribute("radio","aggregate");
		session.setAttribute("names", "");
		session.setAttribute("radar", "");
		session.setAttribute("radar1", "");
		session.setAttribute("radar2", "");
		session.setAttribute("radar3", "");
		session.setAttribute("radar4", "");
		session.setAttribute("radar5", "");
		

	}
	else{
		System.out.println(" post"+request.getParameter("aggr_norm"));
		System.out.println(" post"+session.getAttribute("radio"));
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

		if(request.getParameter("options")==null && request.getParameter("xychange") == null 
		   && request.getParameter("go") == null && session.getAttribute("datepicked")!= null
		   && session.getAttribute("tracker")!=null ){
			String tracker = (String) session.getAttribute("tracker");
			String userName = (String) session.getAttribute("user");
			try {		
				//session.setAttribute("datepicked", request.getParameter("datepicked"));
				System.out.println(" inside main");
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

				Sentiments_util s = new Sentiments_util();
				long diff[] = s.differenceBetweenDates(startdate,enddate);  //days, months, years

				Map<String, Object> configg = new HashMap<String, Object>();
				//if you need pretty printing
				configg.put("javax.json.stream.JsonGenerator.prettyPrinting", Boolean.valueOf(true));

				if(diff[2]!=0)
				{
					ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsyearly(startdate, enddate,userName,tracker);
					//ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsmonthly(startdate, enddate);
					//ArrayList<blogtracker.util.Sentiments_result> wr =s.getsentimentsweekly(startdate, enddate);
					//ArrayList<blogtracker.util.Sentiments_result> dr =s.getsentimentsdaily(startdate, enddate);

					JsonBuilderFactory factory = Json.createBuilderFactory(configg);
					ArrayList<String> trendpos = new ArrayList<String>();

					Integer i = 0;
					while(i<mr.size()) {
						Date t = df.parse(mr.get(i).date);
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(mr.get(i).possenti.toString()))
								.build();
						trendpos.add( jvalue.toString());
						i++;
					}	

					for(int ii=0;ii<trendpos.size();ii++)
					{
						String temp = trendpos.get(ii);
						temp = temp.replace("\"", "");
						trendpos.set(ii,temp);

					}
					session.setAttribute("trendpos", trendpos);
					session.setAttribute("trendposagg", trendpos);
					session.setAttribute("names", "");
					// Get a set of the entries
					//  Set set2 = ynegsenti.entrySet();

					// Get an iterator
					i = 0;

					ArrayList<String> trendneg = new ArrayList<String>();

					while(i<mr.size()) {
						Date t = df.parse(mr.get(i).date);
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(mr.get(i).negsenti.toString()))
								.build();
						trendneg.add( jvalue.toString());
						i++;
					}
					for(int ij=0;ij<trendneg.size();ij++)
					{
						String temp = trendneg.get(ij);
						temp = temp.replace("\"", "");
						trendneg.set(ij,temp);

					}

					session.setAttribute("trendneg",trendneg);
					session.setAttribute("trendnegagg",trendneg);
					session.setAttribute("sentires", mr);
					session.setAttribute("st_span", "year");
					session.setAttribute("names", "");

				}
				else if(diff[1]!=0)
				{
					//ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsyearly(startdate, enddate);
					ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsmonthly(startdate, enddate,userName,tracker);
					//ArrayList<blogtracker.util.Sentiments_result> wr =s.getsentimentsweekly(startdate, enddate);
					//ArrayList<blogtracker.util.Sentiments_result> dr =s.getsentimentsdaily(startdate, enddate);

					JsonBuilderFactory factory = Json.createBuilderFactory(configg);
					ArrayList<String> trendpos = new ArrayList<String>();


					Integer i = 0;
					while(i<mr.size()) {

						Date t = df.parse(mr.get(i).date);
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(mr.get(i).possenti.toString()))
								.build();
						trendpos.add( jvalue.toString());
						i++;
					}	

					for(int ii=0;ii<trendpos.size();ii++)
					{
						String temp = trendpos.get(ii);
						temp = temp.replace("\"", "");
						trendpos.set(ii,temp);

					}
					session.setAttribute("trendpos", trendpos);
					session.setAttribute("trendposagg", trendpos);
					session.setAttribute("names", "");
					// Get a set of the entries
					//  Set set2 = ynegsenti.entrySet();

					// Get an iterator
					i = 0;

					ArrayList<String> trendneg = new ArrayList<String>();

					while(i<mr.size()) {

						Date t = df.parse(mr.get(i).date);
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(mr.get(i).negsenti.toString()))
								.build();
						trendneg.add( jvalue.toString());
						i++;
					}
					for(int ij=0;ij<trendneg.size();ij++)
					{
						String temp = trendneg.get(ij);
						temp = temp.replace("\"", "");
						trendneg.set(ij,temp);

					}
					session.setAttribute("trendneg",trendneg);
					session.setAttribute("trendnegagg",trendneg);
					session.setAttribute("sentires", mr);
					session.setAttribute("st_span", "month");
					session.setAttribute("names", "");

				}
				else if(diff[0]!=0 && diff[0]>7)
				{
					//ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsyearly(startdate, enddate);
					//ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsmonthly(startdate, enddate);
					ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsweekly(startdate, enddate,userName,tracker);
					//ArrayList<blogtracker.util.Sentiments_result> dr =s.getsentimentsdaily(startdate, enddate);

					JsonBuilderFactory factory = Json.createBuilderFactory(configg);
					ArrayList<String> trendpos = new ArrayList<String>();


					Integer i = 0;
					while(i<mr.size()) {
						Date t = df.parse(mr.get(i).date);
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(mr.get(i).possenti.toString()))
								.build();
						trendpos.add( jvalue.toString());
						i++;
					}	

					for(int ii=0;ii<trendpos.size();ii++)
					{
						String temp = trendpos.get(ii);
						temp = temp.replace("\"", "");
						trendpos.set(ii,temp);

					}
					session.setAttribute("trendpos", trendpos);
					session.setAttribute("trendposagg", trendpos);
					session.setAttribute("names", "");
					// Get a set of the entries
					//  Set set2 = ynegsenti.entrySet();

					// Get an iterator
					i = 0;

					ArrayList<String> trendneg = new ArrayList<String>();

					while(i<mr.size()) {
						Date t = df.parse(mr.get(i).date);
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(mr.get(i).negsenti.toString()))
								.build();
						trendneg.add( jvalue.toString());
						i++;
					}
					for(int ij=0;ij<trendneg.size();ij++)
					{
						String temp = trendneg.get(ij);
						temp = temp.replace("\"", "");
						trendneg.set(ij,temp);

					}
					session.setAttribute("trendneg",trendneg);
					session.setAttribute("trendnegagg",trendneg);
					session.setAttribute("sentires", mr);
					session.setAttribute("st_span", "week");
					session.setAttribute("names", "");

				}
				else
				{

					//ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsyearly(startdate, enddate);
					//ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsmonthly(startdate, enddate);
					//ArrayList<blogtracker.util.Sentiments_result> wr =s.getsentimentsweekly(startdate, enddate);
					ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsdaily(startdate, enddate,userName,tracker);

					JsonBuilderFactory factory = Json.createBuilderFactory(configg);
					ArrayList<String> trendpos = new ArrayList<String>();


					Integer i = 0;
					while(i<mr.size()) {

						Date t = df.parse(mr.get(i).date);
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(mr.get(i).possenti.toString()))
								.build();
						trendpos.add( jvalue.toString());
						i++;
					}	
					for(int ii=0;ii<trendpos.size();ii++)
					{
						String temp = trendpos.get(ii);
						temp = temp.replace("\"", "");
						trendpos.set(ii,temp);

					}
					session.setAttribute("trendpos", trendpos);
					session.setAttribute("trendposagg", trendpos);
					session.setAttribute("names", "");
					// Get a set of the entries
					//  Set set2 = ynegsenti.entrySet();

					// Get an iterator
					i = 0;

					ArrayList<String> trendneg = new ArrayList<String>();

					while(i<mr.size()) {
						Date t = df.parse(mr.get(i).date);
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(mr.get(i).negsenti.toString()))
								.build();
						trendneg.add( jvalue.toString());
						i++;
					}
					for(int ij=0;ij<trendneg.size();ij++)
					{
						String temp = trendneg.get(ij);
						temp = temp.replace("\"", "");
						trendneg.set(ij,temp);

					}
					session.setAttribute("trendneg",trendneg);
					session.setAttribute("trendnegagg",trendneg);
					session.setAttribute("sentires", mr);
					session.setAttribute("st_span", "day");
					session.setAttribute("names", "");
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}		    
			
			session.setAttribute("radio","aggregate");
		}
		if(request.getParameter("xychange") != null)
		{
			
			System.out.println(" inside xychange");
			String xyrec = request.getParameter("xychange");
			String point[] = xyrec.split(",",2);
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
			try {
				date = originalFormat.parse((xd[2]+xd[3]+xd[4]).toString());
				date1 = originalFormat.parse((xd[2]+xd[3]+xd[4]).toString());

				formattedDate = targetFormat.format(date);  // 20120821
				selecteddate = dateFormat.format(date);
				session.setAttribute("selecteddate", selecteddate);
				ArrayList<Sentiments_result> sr = (ArrayList<Sentiments_result>)session.getAttribute("sentires");
				ArrayList<ArrayList<String>> names = new ArrayList<ArrayList<String>>();
				ArrayList<ArrayList<String>> titles = null;
				ArrayList<Sentiments_result> srsorted; // sentiments sorting
				String sort_type;
				
				if(session.getAttribute("radio")== "aggregate"){
				
				for(int i=0;i<sr.size(); i++)
				{
					if(selecteddate.equals(sr.get(i).date)){
						
						if(sr.get(i).possenti.equals(Integer.parseInt(yval) )||sr.get(i).negsenti.equals( Integer.parseInt(yval) ))
						{
						
						LinkedHashMap<String,ArrayList<Integer>> ls = sr.get(i).emo.get(sr.get(i).date);
						ArrayList<ArrayList<Integer>> k = new ArrayList<ArrayList<Integer>>();
						
						
						if(sr.get(i).possenti.equals(Integer.parseInt(yval)))
						{
							sort_type="pos";
							for (Entry<String, ArrayList<Integer>> entry : ls.entrySet()) 
							{
								ArrayList<Integer> l = new ArrayList<Integer>();
								l.add(Integer.parseInt(entry.getKey()));
								l.add(entry.getValue().get(24));
								k.add(l);
							}
						}
						else if(sr.get(i).negsenti.equals(Integer.parseInt(yval)))
						{
							sort_type="neg";
							for (Entry<String, ArrayList<Integer>> entry : ls.entrySet()) 
							{
								ArrayList<Integer> l = new ArrayList<Integer>();
								l.add(Integer.parseInt(entry.getKey()));
								l.add(entry.getValue().get(25));
								k.add(l);
							}
						}
						
						
						
						//k.sort((o1, o2) -> o1.get(1).compareTo(o2.get(1)));
						for(int g=0;g<k.size();g++)
						{
							System.out.println(" "+k.get(g).get(0)+" "+k.get(g).get(1));
						}
						
						titles=sr.get(i).titles;
						if (sr.get(i).titles.size()>=50)
						{	
							int size = k.size()-1;
							for(int j=size;j>size-50;j--)
							{
								for(int f=0;f<sr.get(i).titles.size();f++)
								{	
									if(k.get(j).get(0) == Integer.parseInt(sr.get(i).titles.get(f).get(1)))
									{
										ArrayList<String> t = new ArrayList<String>();
										t.add(sr.get(i).titles.get(f).get(0));
										t.add(sr.get(i).titles.get(f).get(1));
										names.add(t);
										break;
									}
									
								}
								/*ArrayList<String> t = new ArrayList<String>();
								t.add(sr.get(i).titles.get(j).get(0));
								t.add(sr.get(i).titles.get(j).get(1));
								names.add(t);*/

							}
						}
						else
						{
							/*for(int j=0;j<sr.get(i).titles.size();j++)
							{
								ArrayList<String> t = new ArrayList<String>();
								t.add(sr.get(i).titles.get(j).get(0));
								t.add(sr.get(i).titles.get(j).get(1));
								names.add(t);

							}*/
							
							int size = k.size()-1;
							for(int j=size;j>=0;j--)
							{
								for(int f=0;f<sr.get(i).titles.size();f++)
								{	
									if(k.get(j).get(0) == Integer.parseInt(sr.get(i).titles.get(f).get(1)))
									{
										ArrayList<String> t = new ArrayList<String>();
										t.add(sr.get(i).titles.get(f).get(0));
										t.add(sr.get(i).titles.get(f).get(1));
										names.add(t);
										break;
									}
									
								}
								
							}
						}

						break;
					}
					 
				  }
				}
				
				}
				else if(session.getAttribute("radio")=="normalized" )
				{
					System.out.println(" inside normalized ");
					ArrayList<ArrayList<Integer>> n_a_pos = (ArrayList<ArrayList<Integer>>) session.getAttribute("norm_aggr_pos");
					ArrayList<ArrayList<Integer>> n_a_neg = (ArrayList<ArrayList<Integer>>) session.getAttribute("norm_aggr_neg");
					
					for(int i=0;i<sr.size(); i++)
					{
						System.out.println(" "+selecteddate+" "+sr.get(i).date);
						if(selecteddate.equals(sr.get(i).date)){
							System.out.println(" pos "+n_a_pos.get(i).get(1)+" neg"+n_a_neg.get(i).get(1));
							if(sr.get(i).possenti.equals(n_a_pos.get(i).get(1)) ||sr.get(i).negsenti.equals(n_a_neg.get(i).get(1)))
							{
								System.out.println(" posss "+n_a_pos.get(i).get(1)+" negggg "+n_a_neg.get(i).get(1));
							LinkedHashMap<String,ArrayList<Integer>> ls = sr.get(i).emo.get(sr.get(i).date);
							ArrayList<ArrayList<Integer>> k = new ArrayList<ArrayList<Integer>>();
							
							
							if(sr.get(i).possenti.equals(n_a_pos.get(i).get(1)))
							{
								sort_type="pos";
								for (Entry<String, ArrayList<Integer>> entry : ls.entrySet()) 
								{
									ArrayList<Integer> l = new ArrayList<Integer>();
									l.add(Integer.parseInt(entry.getKey()));
									l.add(entry.getValue().get(24));
									k.add(l);
								}
							}
							else if(sr.get(i).negsenti.equals(n_a_neg.get(i).get(1)))
							{
								sort_type="neg";
								for (Entry<String, ArrayList<Integer>> entry : ls.entrySet()) 
								{
									ArrayList<Integer> l = new ArrayList<Integer>();
									l.add(Integer.parseInt(entry.getKey()));
									l.add(entry.getValue().get(25));
									k.add(l);
									System.out.println(" kk "+k.get(0).get(0)+" "+k.get(0).get(1));
								}
							}
							
							
							
							//k.sort((o1, o2) -> o1.get(1).compareTo(o2.get(1)));
							for(int g=0;g<k.size();g++)
							{
								System.out.println(" "+k.get(g).get(0)+" "+k.get(g).get(1));
							}
							
							titles=sr.get(i).titles;
							if (sr.get(i).titles.size()>=50)
							{	
								int size = k.size()-1;
								for(int j=size;j>size-50;j--)
								{
									for(int f=0;f<sr.get(i).titles.size();f++)
									{	
										if(k.get(j).get(0) == Integer.parseInt(sr.get(i).titles.get(f).get(1)))
										{
											ArrayList<String> t = new ArrayList<String>();
											t.add(sr.get(i).titles.get(f).get(0));
											t.add(sr.get(i).titles.get(f).get(1));
											names.add(t);
											break;
										}
										
									}
									/*ArrayList<String> t = new ArrayList<String>();
									t.add(sr.get(i).titles.get(j).get(0));
									t.add(sr.get(i).titles.get(j).get(1));
									names.add(t);*/

								}
							}
							else
							{
								/*for(int j=0;j<sr.get(i).titles.size();j++)
								{
									ArrayList<String> t = new ArrayList<String>();
									t.add(sr.get(i).titles.get(j).get(0));
									t.add(sr.get(i).titles.get(j).get(1));
									names.add(t);

								}*/
								
								int size = k.size()-1;
								for(int j=size;j>=0;j--)
								{
									for(int f=0;f<sr.get(i).titles.size();f++)
									{	
										if(k.get(j).get(0) == Integer.parseInt(sr.get(i).titles.get(f).get(1)))
										{
											ArrayList<String> t = new ArrayList<String>();
											t.add(sr.get(i).titles.get(f).get(0));
											t.add(sr.get(i).titles.get(f).get(1));
											names.add(t);
											break;
										}
										
									}
									
								}
							}

							break;
						}
						 
					  }
					}
					
					
				}
				
				session.setAttribute("names", names);
				for(int i=0;i<names.size();i++)
				System.out.println(" ddd"+names.get(i).get(0));
				Sentiments_util s = new Sentiments_util();
				String tracker = (String) session.getAttribute("tracker");
				String userName = (String) session.getAttribute("user");
				int tracker_id = s.get_tracker_id(userName, tracker);
				ArrayList<String> bloggers = s.get_blogger(userName, tracker);
				session.setAttribute("tracker_id",tracker_id);
				session.setAttribute("bloggers",bloggers);

			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}


		}
		if(request.getParameter("options")!=null && request.getParameter("options").equals("month") )
		{
			System.out.println(" inside spanmonth");
			if(session.getAttribute("datepicked")!=null && session.getAttribute("tracker")!=null){
				String tracker = (String) session.getAttribute("tracker");
				String userName = (String) session.getAttribute("user");
				try{

					session.setAttribute("st_span", "month");	

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

					Sentiments_util s = new Sentiments_util();
					long diff[] = s.differenceBetweenDates(startdate,enddate);  //days, months, years

					Map<String, Object> configg = new HashMap<String, Object>();
					//if you need pretty printing
					configg.put("javax.json.stream.JsonGenerator.prettyPrinting", Boolean.valueOf(true));


					//ArrayList<blogtracker.util.Sentiments_result> yr =s.getsentimentsyearly(startdate, enddate);
					ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsmonthly(startdate, enddate,userName,tracker);
					//ArrayList<blogtracker.util.Sentiments_result> wr =s.getsentimentsweekly(startdate, enddate);
					//ArrayList<blogtracker.util.Sentiments_result> dr =s.getsentimentsdaily(startdate, enddate);

					JsonBuilderFactory factory = Json.createBuilderFactory(configg);
					
					if(session.getAttribute("radio").equals("aggregate"))
					{
					ArrayList<String> trendpos = new ArrayList<String>();


					Integer i = 0;
					while(i<mr.size()) {

						Date t = df.parse(mr.get(i).date);
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(mr.get(i).possenti.toString()))
								.build();
						trendpos.add( jvalue.toString());
						i++;
					}	

					for(int ii=0;ii<trendpos.size();ii++)
					{
						String temp = trendpos.get(ii);
						temp = temp.replace("\"", "");
						trendpos.set(ii,temp);

					}
					session.setAttribute("trendpos", trendpos);
					session.setAttribute("trendposagg", trendpos);
					session.setAttribute("names", "");
					// Get a set of the entries
					//  Set set2 = ynegsenti.entrySet();

					// Get an iterator
					i = 0;

					ArrayList<String> trendneg = new ArrayList<String>();

					while(i<mr.size()) {

						Date t = df.parse(mr.get(i).date);	//date decrement 
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(mr.get(i).negsenti.toString()))
								.build();
						trendneg.add( jvalue.toString());
						i++;
					}
					for(int ij=0;ij<trendneg.size();ij++)
					{
						String temp = trendneg.get(ij);
						temp = temp.replace("\"", "");
						trendneg.set(ij,temp);

					}
					session.setAttribute("trendneg",trendneg);
					session.setAttribute("trendnegagg",trendneg);
					}
					else
					{
						
						session.setAttribute("radio","normalized");
						ArrayList<String> trendposnorm = new ArrayList<String>();
						ArrayList<ArrayList<Integer>> norm_aggr_pos =new ArrayList<ArrayList<Integer>>();  
						ArrayList<ArrayList<Integer>> norm_aggr_neg =new ArrayList<ArrayList<Integer>>();
						Integer i = 0;
						while(i<mr.size()) {
							ArrayList<Integer> td = new ArrayList<Integer>();
							Date t = df.parse(mr.get(i).date);
							Calendar c = Calendar.getInstance();
							c.setTime(t);
							c.add(Calendar.MONTH, -1);
							t=c.getTime();
							String tt=df.format(t).toString();
							JsonObject jvalue = factory.createObjectBuilder()
									.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
									.add("y",Integer.parseInt(mr.get(i).possenti.toString())/mr.get(i).titles.size())
									.build();
							trendposnorm.add( jvalue.toString());
							td.add(Integer.parseInt(mr.get(i).possenti.toString())/mr.get(i).titles.size());
							td.add(Integer.parseInt(mr.get(i).possenti.toString()));
							norm_aggr_pos.add(td);
							i++;
						}	

						for(int ii=0;ii<trendposnorm.size();ii++)
						{
							String temp = trendposnorm.get(ii);
							temp = temp.replace("\"", "");
							trendposnorm.set(ii,temp);

						}
						session.setAttribute("trendpos", trendposnorm);
						session.setAttribute("trendposnorm", trendposnorm);
						session.setAttribute("norm_aggr_pos",norm_aggr_pos);
						session.setAttribute("names", "");
						// Get a set of the entries
						//  Set set2 = ynegsenti.entrySet();

						// Get an iterator
						i = 0;

						ArrayList<String> trendnegnorm = new ArrayList<String>();

						while(i<mr.size()) {
							ArrayList<Integer> td = new ArrayList<Integer>();
							Date t = df.parse(mr.get(i).date);	//date decrement 
							Calendar c = Calendar.getInstance();
							c.setTime(t);
							c.add(Calendar.MONTH, -1);
							t=c.getTime();
							String tt=df.format(t).toString();
							JsonObject jvalue = factory.createObjectBuilder()
									.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
									.add("y",Integer.parseInt(mr.get(i).negsenti.toString())/mr.get(i).titles.size())
									.build();
							trendnegnorm.add( jvalue.toString());
							td.add(Integer.parseInt(mr.get(i).negsenti.toString())/mr.get(i).titles.size());
							td.add(Integer.parseInt(mr.get(i).negsenti.toString()));
							norm_aggr_neg.add(td);
							i++;
						}
						for(int ij=0;ij<trendnegnorm.size();ij++)
						{
							String temp = trendnegnorm.get(ij);
							temp = temp.replace("\"", "");
							trendnegnorm.set(ij,temp);

						}
						session.setAttribute("trendneg",trendnegnorm);
						session.setAttribute("trendnegnorm",trendnegnorm);
						session.setAttribute("norm_aggr_neg",norm_aggr_neg);
					}
					session.setAttribute("sentires", mr);
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
			else
			{
				session.setAttribute("trendneg", "");
				session.setAttribute("trendpos", "");
				session.setAttribute("names", "");
				session.setAttribute("radar", "");
				session.setAttribute("radar1", "");
				session.setAttribute("radar2", "");
				session.setAttribute("radar3", "");
				session.setAttribute("radar4", "");
				session.setAttribute("radar5", "");
			}

		}

		if(request.getParameter("options")!=null && request.getParameter("options").equals("year"))
		{
			System.out.println(" inside span year");
			if(session.getAttribute("datepicked")!=null && session.getAttribute("tracker")!=null){
				String tracker = (String) session.getAttribute("tracker");
				String userName = (String) session.getAttribute("user");
				try{
					session.setAttribute("st_span", "year");	
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

					Sentiments_util s = new Sentiments_util();
					long diff[] = s.differenceBetweenDates(startdate,enddate);  //days, months, years

					Map<String, Object> configg = new HashMap<String, Object>();
					//if you need pretty printing
					configg.put("javax.json.stream.JsonGenerator.prettyPrinting", Boolean.valueOf(true));

					ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsyearly(startdate, enddate,userName,tracker);
					//ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsmonthly(startdate, enddate);
					//ArrayList<blogtracker.util.Sentiments_result> wr =s.getsentimentsweekly(startdate, enddate);
					//ArrayList<blogtracker.util.Sentiments_result> dr =s.getsentimentsdaily(startdate, enddate);

					JsonBuilderFactory factory = Json.createBuilderFactory(configg);
					
					
					if(session.getAttribute("radio").equals("aggregate"))
					{
						
						
					ArrayList<String> trendpos = new ArrayList<String>();


					Integer i = 0;
					while(i<mr.size()) {
						Date t = df.parse(mr.get(i).date);
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();

						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(mr.get(i).possenti.toString()))
								.build();
						trendpos.add( jvalue.toString());
						i++;
					}	
					for(int ii=0;ii<trendpos.size();ii++)
					{
						String temp = trendpos.get(ii);
						temp = temp.replace("\"", "");
						trendpos.set(ii,temp);

					}
					session.setAttribute("trendpos", trendpos);
					session.setAttribute("trendposagg", trendpos);
					session.setAttribute("names", "");
					// Get a set of the entries
					//  Set set2 = ynegsenti.entrySet();

					// Get an iterator
					i = 0;

					ArrayList<String> trendneg = new ArrayList<String>();

					while(i<mr.size()) {

						Date t = df.parse(mr.get(i).date);
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(mr.get(i).negsenti.toString()))
								.build();
						trendneg.add( jvalue.toString());
						i++;
					}
					for(int ij=0;ij<trendneg.size();ij++)
					{
						String temp = trendneg.get(ij);
						temp = temp.replace("\"", "");
						trendneg.set(ij,temp);

					}
					session.setAttribute("trendneg",trendneg);
					session.setAttribute("trendnegagg",trendneg);
					}
					else
					{
						session.setAttribute("radio", "normalized");
						ArrayList<String> trendposnorm = new ArrayList<String>();
						ArrayList<ArrayList<Integer>> norm_aggr_pos =new ArrayList<ArrayList<Integer>>();  
						ArrayList<ArrayList<Integer>> norm_aggr_neg =new ArrayList<ArrayList<Integer>>();


						Integer i = 0;
						while(i<mr.size()) {
							ArrayList<Integer> td = new ArrayList<Integer>();
							Date t = df.parse(mr.get(i).date);
							Calendar c = Calendar.getInstance();
							c.setTime(t);
							c.add(Calendar.MONTH, -1);
							t=c.getTime();
							String tt=df.format(t).toString();

							JsonObject jvalue = factory.createObjectBuilder()
									.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
									.add("y",Integer.parseInt(mr.get(i).possenti.toString())/mr.get(i).titles.size())
									.build();
							trendposnorm.add( jvalue.toString());
							td.add(Integer.parseInt(mr.get(i).possenti.toString())/mr.get(i).titles.size());
							td.add(Integer.parseInt(mr.get(i).possenti.toString()));
							norm_aggr_pos.add(td);
							i++;
						}	
						for(int ii=0;ii<trendposnorm.size();ii++)
						{
							String temp = trendposnorm.get(ii);
							temp = temp.replace("\"", "");
							trendposnorm.set(ii,temp);

						}
						session.setAttribute("trendpos", trendposnorm);
						session.setAttribute("trendposnorm", trendposnorm);
						session.setAttribute("norm_aggr_pos",norm_aggr_pos);
						session.setAttribute("names", "");
						// Get a set of the entries
						//  Set set2 = ynegsenti.entrySet();

						// Get an iterator
						i = 0;

						ArrayList<String> trendnegnorm = new ArrayList<String>();

						while(i<mr.size()) {
							ArrayList<Integer> td = new ArrayList<Integer>();
							Date t = df.parse(mr.get(i).date);
							Calendar c = Calendar.getInstance();
							c.setTime(t);
							c.add(Calendar.MONTH, -1);
							t=c.getTime();
							String tt=df.format(t).toString();
							JsonObject jvalue = factory.createObjectBuilder()
									.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
									.add("y",Integer.parseInt(mr.get(i).negsenti.toString())/mr.get(i).titles.size())
									.build();
							trendnegnorm.add( jvalue.toString());
							td.add(Integer.parseInt(mr.get(i).negsenti.toString())/mr.get(i).titles.size());
							td.add(Integer.parseInt(mr.get(i).negsenti.toString()));
							norm_aggr_neg.add(td);
							i++;
						}
						for(int ij=0;ij<trendnegnorm.size();ij++)
						{
							String temp = trendnegnorm.get(ij);
							temp = temp.replace("\"", "");
							trendnegnorm.set(ij,temp);

						}
						session.setAttribute("trendneg",trendnegnorm);
						session.setAttribute("trendnegnorm",trendnegnorm);
						session.setAttribute("norm_aggr_neg",norm_aggr_neg);
						
						
					}
					session.setAttribute("sentires", mr);
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
			else
			{
				session.setAttribute("trendneg", "");
				session.setAttribute("trendpos", "");
				session.setAttribute("names", "");
				session.setAttribute("radar", "");
				session.setAttribute("radar1", "");
				session.setAttribute("radar2", "");
				session.setAttribute("radar3", "");
				session.setAttribute("radar4", "");
				session.setAttribute("radar5", "");
			}

		}

		if(request.getParameter("options")!=null && request.getParameter("options").equals("week"))
		{
			System.out.println(" inside span week");
			if(session.getAttribute("datepicked")!=null && session.getAttribute("tracker")!=null){
				String tracker = (String) session.getAttribute("tracker");
				String userName = (String) session.getAttribute("user");
				try{
					session.setAttribute("st_span", "week");
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

					Sentiments_util s = new Sentiments_util();
					long diff[] = s.differenceBetweenDates(startdate,enddate);  //days, months, years

					Map<String, Object> configg = new HashMap<String, Object>();
					//if you need pretty printing
					configg.put("javax.json.stream.JsonGenerator.prettyPrinting", Boolean.valueOf(true));


					//ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsyearly(startdate, enddate);
					//ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsmonthly(startdate, enddate);
					ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsweekly(startdate, enddate,userName,tracker);
					//ArrayList<blogtracker.util.Sentiments_result> dr =s.getsentimentsdaily(startdate, enddate);

					JsonBuilderFactory factory = Json.createBuilderFactory(configg);
					
					if(session.getAttribute("radio").equals("aggregate"))
					{
					ArrayList<String> trendpos = new ArrayList<String>();


					Integer i = 0;
					while(i<mr.size()) {

						Date t = df.parse(mr.get(i).date);
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(mr.get(i).possenti.toString()))
								.build();
						trendpos.add( jvalue.toString());
						i++;
					}	

					for(int ii=0;ii<trendpos.size();ii++)
					{
						String temp = trendpos.get(ii);
						temp = temp.replace("\"", "");
						trendpos.set(ii,temp);

					}
					session.setAttribute("trendpos", trendpos);
					session.setAttribute("trendposagg", trendpos);
					session.setAttribute("names", "");
					// Get a set of the entries
					//  Set set2 = ynegsenti.entrySet();

					// Get an iterator
					i = 0;

					ArrayList<String> trendneg = new ArrayList<String>();

					while(i<mr.size()) {
						Date t = df.parse(mr.get(i).date);
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(mr.get(i).negsenti.toString()))
								.build();
						trendneg.add( jvalue.toString());
						i++;
					}
					for(int ij=0;ij<trendneg.size();ij++)
					{
						String temp = trendneg.get(ij);
						temp = temp.replace("\"", "");
						trendneg.set(ij,temp);

					}

					session.setAttribute("trendneg",trendneg);
					session.setAttribute("trendnegagg",trendneg);
					}
					else
					{
						session.setAttribute("radio","normalized");
						ArrayList<String> trendposnorm = new ArrayList<String>();
						ArrayList<ArrayList<Integer>> norm_aggr_pos =new ArrayList<ArrayList<Integer>>();  
						ArrayList<ArrayList<Integer>> norm_aggr_neg =new ArrayList<ArrayList<Integer>>();

						Integer i = 0;
						while(i<mr.size()) {
							ArrayList<Integer> td = new ArrayList<Integer>();
							Date t = df.parse(mr.get(i).date);
							Calendar c = Calendar.getInstance();
							c.setTime(t);
							c.add(Calendar.MONTH, -1);
							t=c.getTime();
							String tt=df.format(t).toString();
							JsonObject jvalue = factory.createObjectBuilder()
									.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
									.add("y",Integer.parseInt(mr.get(i).possenti.toString())/mr.get(i).titles.size())
									.build();
							trendposnorm.add( jvalue.toString());
							td.add(Integer.parseInt(mr.get(i).possenti.toString())/mr.get(i).titles.size());
							td.add(Integer.parseInt(mr.get(i).possenti.toString()));
							norm_aggr_pos.add(td);
							i++;
						}	

						for(int ii=0;ii<trendposnorm.size();ii++)
						{
							String temp = trendposnorm.get(ii);
							temp = temp.replace("\"", "");
							trendposnorm.set(ii,temp);

						}
						session.setAttribute("trendpos", trendposnorm);
						session.setAttribute("trendposnorm", trendposnorm);
						session.setAttribute("norm_aggr_pos",norm_aggr_pos);
						session.setAttribute("names", "");
						// Get a set of the entries
						//  Set set2 = ynegsenti.entrySet();

						// Get an iterator
						i = 0;

						ArrayList<String> trendnegnorm = new ArrayList<String>();

						while(i<mr.size()) {
							ArrayList<Integer> td = new ArrayList<Integer>();
							Date t = df.parse(mr.get(i).date);
							Calendar c = Calendar.getInstance();
							c.setTime(t);
							c.add(Calendar.MONTH, -1);
							t=c.getTime();
							String tt=df.format(t).toString();
							JsonObject jvalue = factory.createObjectBuilder()
									.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
									.add("y",Integer.parseInt(mr.get(i).negsenti.toString())/mr.get(i).titles.size())
									.build();
							trendnegnorm.add( jvalue.toString());
							td.add(Integer.parseInt(mr.get(i).negsenti.toString())/mr.get(i).titles.size());
							td.add(Integer.parseInt(mr.get(i).negsenti.toString()));
							norm_aggr_neg.add(td);
							i++;
						}
						for(int ij=0;ij<trendnegnorm.size();ij++)
						{
							String temp = trendnegnorm.get(ij);
							temp = temp.replace("\"", "");
							trendnegnorm.set(ij,temp);

						}

						session.setAttribute("trendneg",trendnegnorm);
						session.setAttribute("trendnegnorm",trendnegnorm);
						session.setAttribute("norm_aggr_neg",norm_aggr_neg);
					}
					session.setAttribute("sentires", mr);

				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
			else
			{
				session.setAttribute("trendneg", "");
				session.setAttribute("trendpos", "");
				session.setAttribute("names", "");
				session.setAttribute("radar", "");
				session.setAttribute("radar1", "");
				session.setAttribute("radar2", "");
				session.setAttribute("radar3", "");
				session.setAttribute("radar4", "");
				session.setAttribute("radar5", "");
			}

		}

		if(request.getParameter("options")!=null && request.getParameter("options").equals("day"))
		{
			System.out.println(" inside span day");
			if(session.getAttribute("datepicked")!=null && session.getAttribute("tracker")!=null){
				String tracker = (String) session.getAttribute("tracker");
				String userName = (String) session.getAttribute("user");
				try{
					session.setAttribute("st_span", "day");
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

					Sentiments_util s = new Sentiments_util();
					long diff[] = s.differenceBetweenDates(startdate,enddate);  //days, months, years

					Map<String, Object> configg = new HashMap<String, Object>();
					//if you need pretty printing
					configg.put("javax.json.stream.JsonGenerator.prettyPrinting", Boolean.valueOf(true));

					//ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsyearly(startdate, enddate);
					//ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsmonthly(startdate, enddate);
					//ArrayList<blogtracker.util.Sentiments_result> wr =s.getsentimentsweekly(startdate, enddate);
					ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsdaily(startdate, enddate,userName,tracker);

					JsonBuilderFactory factory = Json.createBuilderFactory(configg);
					
					if(session.getAttribute("radio").equals("aggregate"))
					{
					ArrayList<String> trendpos = new ArrayList<String>();


					Integer i = 0;
					while(i<mr.size()) {

						Date t = df.parse(mr.get(i).date);
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(mr.get(i).possenti.toString()))
								.build();
						trendpos.add( jvalue.toString());
						i++;
					}	

					for(int ii=0;ii<trendpos.size();ii++)
					{
						String temp = trendpos.get(ii);
						temp = temp.replace("\"", "");
						trendpos.set(ii,temp);

					}
					session.setAttribute("trendpos", trendpos);
					session.setAttribute("trendposagg", trendpos);
					session.setAttribute("names", "");
					// Get a set of the entries
					//  Set set2 = ynegsenti.entrySet();

					// Get an iterator
					i = 0;

					ArrayList<String> trendneg = new ArrayList<String>();

					while(i<mr.size()) {

						Date t = df.parse(mr.get(i).date);
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						// Map.Entry me = (Map.Entry)i2.next();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(mr.get(i).negsenti.toString()))
								.build();
						trendneg.add( jvalue.toString());
						i++;
					}
					for(int ij=0;ij<trendneg.size();ij++)
					{
						String temp = trendneg.get(ij);
						temp = temp.replace("\"", "");
						trendneg.set(ij,temp);

					}
					session.setAttribute("trendneg",trendneg);
					session.setAttribute("trendnegagg",trendneg);
					}
					else
					{
						session.setAttribute("radio","normalized");
						ArrayList<String> trendposnorm = new ArrayList<String>();
						ArrayList<ArrayList<Integer>> norm_aggr_pos =new ArrayList<ArrayList<Integer>>();  
						ArrayList<ArrayList<Integer>> norm_aggr_neg =new ArrayList<ArrayList<Integer>>();


						Integer i = 0;
						while(i<mr.size()) {
							ArrayList<Integer> td = new ArrayList<Integer>();
							Date t = df.parse(mr.get(i).date);
							Calendar c = Calendar.getInstance();
							c.setTime(t);
							c.add(Calendar.MONTH, -1);
							t=c.getTime();
							String tt=df.format(t).toString();
							JsonObject jvalue = factory.createObjectBuilder()
									.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
									.add("y",Integer.parseInt(mr.get(i).possenti.toString())/mr.get(i).titles.size())
									.build();
							trendposnorm.add( jvalue.toString());
							td.add(Integer.parseInt(mr.get(i).possenti.toString())/mr.get(i).titles.size());
							td.add(Integer.parseInt(mr.get(i).possenti.toString()));
							norm_aggr_pos.add(td);
							i++;
						}	

						for(int ii=0;ii<trendposnorm.size();ii++)
						{
							String temp = trendposnorm.get(ii);
							temp = temp.replace("\"", "");
							trendposnorm.set(ii,temp);

						}
						session.setAttribute("trendpos", trendposnorm);
						session.setAttribute("trendposnorm", trendposnorm);
						session.setAttribute("norm_aggr_pos",norm_aggr_pos);
						session.setAttribute("names", "");
						// Get a set of the entries
						//  Set set2 = ynegsenti.entrySet();

						// Get an iterator
						i = 0;

						ArrayList<String> trendnegnorm = new ArrayList<String>();

						while(i<mr.size()) {
							ArrayList<Integer> td = new ArrayList<Integer>();
							Date t = df.parse(mr.get(i).date);
							Calendar c = Calendar.getInstance();
							c.setTime(t);
							c.add(Calendar.MONTH, -1);
							t=c.getTime();
							String tt=df.format(t).toString();
							// Map.Entry me = (Map.Entry)i2.next();
							JsonObject jvalue = factory.createObjectBuilder()
									.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
									.add("y",Integer.parseInt(mr.get(i).negsenti.toString())/mr.get(i).titles.size())
									.build();
							trendnegnorm.add( jvalue.toString());
							td.add(Integer.parseInt(mr.get(i).negsenti.toString())/mr.get(i).titles.size());
							td.add(Integer.parseInt(mr.get(i).negsenti.toString()));
							norm_aggr_neg.add(td);
							i++;
						}
						for(int ij=0;ij<trendnegnorm.size();ij++)
						{
							String temp = trendnegnorm.get(ij);
							temp = temp.replace("\"", "");
							trendnegnorm.set(ij,temp);

						}
						session.setAttribute("trendneg",trendnegnorm);
						session.setAttribute("trendnegnorm",trendnegnorm);
						session.setAttribute("norm_aggr_neg",norm_aggr_neg);
						
					}
					session.setAttribute("sentires", mr);
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
			else{

				session.setAttribute("trendneg", "");
				session.setAttribute("trendpos", "");
				session.setAttribute("names", "");
				session.setAttribute("radar", "");
				session.setAttribute("radar1", "");
				session.setAttribute("radar2", "");
				session.setAttribute("radar3", "");
				session.setAttribute("radar4", "");
				session.setAttribute("radar5", "");
			}
			

		}

		
		if(request.getParameter("aggr_norm")!=null && request.getParameter("aggr_norm").equals("aggregate")&&request.getParameter("go")==null)
		{
			System.out.println(" inside agg");
			session.setAttribute("radio", "aggregate");
			System.out.println("aggregate" );
			if(st_spa.equals("year"))
			{
				
				String tracker = (String) session.getAttribute("tracker");
				String userName = (String) session.getAttribute("user");
				try{
					session.setAttribute("st_span", "year");	
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

					Sentiments_util s = new Sentiments_util();
					long diff[] = s.differenceBetweenDates(startdate,enddate);  //days, months, years

					Map<String, Object> configg = new HashMap<String, Object>();
					//if you need pretty printing
					configg.put("javax.json.stream.JsonGenerator.prettyPrinting", Boolean.valueOf(true));

					ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsyearly(startdate, enddate,userName,tracker);
					//ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsmonthly(startdate, enddate);
					//ArrayList<blogtracker.util.Sentiments_result> wr =s.getsentimentsweekly(startdate, enddate);
					//ArrayList<blogtracker.util.Sentiments_result> dr =s.getsentimentsdaily(startdate, enddate);

					JsonBuilderFactory factory = Json.createBuilderFactory(configg);
					
						
					ArrayList<String> trendpos = new ArrayList<String>();


					Integer i = 0;
					while(i<mr.size()) {
						Date t = df.parse(mr.get(i).date);
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();

						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(mr.get(i).possenti.toString()))
								.build();
						trendpos.add( jvalue.toString());
						i++;
					}	
					for(int ii=0;ii<trendpos.size();ii++)
					{
						String temp = trendpos.get(ii);
						temp = temp.replace("\"", "");
						trendpos.set(ii,temp);

					}
					session.setAttribute("trendpos", trendpos);
					session.setAttribute("trendposagg", trendpos);
					session.setAttribute("names", "");
					// Get a set of the entries
					//  Set set2 = ynegsenti.entrySet();

					// Get an iterator
					i = 0;

					ArrayList<String> trendneg = new ArrayList<String>();

					while(i<mr.size()) {

						Date t = df.parse(mr.get(i).date);
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(mr.get(i).negsenti.toString()))
								.build();
						trendneg.add( jvalue.toString());
						i++;
					}
					for(int ij=0;ij<trendneg.size();ij++)
					{
						String temp = trendneg.get(ij);
						temp = temp.replace("\"", "");
						trendneg.set(ij,temp);

					}
					session.setAttribute("trendneg",trendneg);
					session.setAttribute("trendnegagg",trendneg);
					session.setAttribute("sentires", mr);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
					
				
			}
			else if(st_spa.equals("month"))
			{
				
				String tracker = (String) session.getAttribute("tracker");
				String userName = (String) session.getAttribute("user");
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

					Sentiments_util s = new Sentiments_util();
					long diff[] = s.differenceBetweenDates(startdate,enddate);  //days, months, years

					Map<String, Object> configg = new HashMap<String, Object>();
					//if you need pretty printing
					configg.put("javax.json.stream.JsonGenerator.prettyPrinting", Boolean.valueOf(true));


					//ArrayList<blogtracker.util.Sentiments_result> yr =s.getsentimentsyearly(startdate, enddate);
					ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsmonthly(startdate, enddate,userName,tracker);
					//ArrayList<blogtracker.util.Sentiments_result> wr =s.getsentimentsweekly(startdate, enddate);
					//ArrayList<blogtracker.util.Sentiments_result> dr =s.getsentimentsdaily(startdate, enddate);

					JsonBuilderFactory factory = Json.createBuilderFactory(configg);
					
					
					ArrayList<String> trendpos = new ArrayList<String>();


					Integer i = 0;
					while(i<mr.size()) {

						Date t = df.parse(mr.get(i).date);
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(mr.get(i).possenti.toString()))
								.build();
						trendpos.add( jvalue.toString());
						i++;
					}	

					for(int ii=0;ii<trendpos.size();ii++)
					{
						String temp = trendpos.get(ii);
						temp = temp.replace("\"", "");
						trendpos.set(ii,temp);

					}
					session.setAttribute("trendpos", trendpos);
					session.setAttribute("trendposagg", trendpos);
					session.setAttribute("names", "");
					// Get a set of the entries
					//  Set set2 = ynegsenti.entrySet();

					// Get an iterator
					i = 0;

					ArrayList<String> trendneg = new ArrayList<String>();

					while(i<mr.size()) {

						Date t = df.parse(mr.get(i).date);	//date decrement 
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(mr.get(i).negsenti.toString()))
								.build();
						trendneg.add( jvalue.toString());
						i++;
					}
					for(int ij=0;ij<trendneg.size();ij++)
					{
						String temp = trendneg.get(ij);
						temp = temp.replace("\"", "");
						trendneg.set(ij,temp);

					}
					session.setAttribute("trendneg",trendneg);
					session.setAttribute("trendnegagg",trendneg);
					session.setAttribute("sentires", mr);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
			else if(st_spa.equals("week"))
			{
				String tracker = (String) session.getAttribute("tracker");
				String userName = (String) session.getAttribute("user");
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

					Sentiments_util s = new Sentiments_util();
					long diff[] = s.differenceBetweenDates(startdate,enddate);  //days, months, years

					Map<String, Object> configg = new HashMap<String, Object>();
					//if you need pretty printing
					configg.put("javax.json.stream.JsonGenerator.prettyPrinting", Boolean.valueOf(true));


					//ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsyearly(startdate, enddate);
					//ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsmonthly(startdate, enddate);
					ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsweekly(startdate, enddate,userName,tracker);
					//ArrayList<blogtracker.util.Sentiments_result> dr =s.getsentimentsdaily(startdate, enddate);

					JsonBuilderFactory factory = Json.createBuilderFactory(configg);
					
					
					ArrayList<String> trendpos = new ArrayList<String>();


					Integer i = 0;
					while(i<mr.size()) {

						Date t = df.parse(mr.get(i).date);
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(mr.get(i).possenti.toString()))
								.build();
						trendpos.add( jvalue.toString());
						i++;
					}	

					for(int ii=0;ii<trendpos.size();ii++)
					{
						String temp = trendpos.get(ii);
						temp = temp.replace("\"", "");
						trendpos.set(ii,temp);

					}
					session.setAttribute("trendpos", trendpos);
					session.setAttribute("trendposagg", trendpos);
					session.setAttribute("names", "");
					// Get a set of the entries
					//  Set set2 = ynegsenti.entrySet();

					// Get an iterator
					i = 0;

					ArrayList<String> trendneg = new ArrayList<String>();

					while(i<mr.size()) {
						Date t = df.parse(mr.get(i).date);
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(mr.get(i).negsenti.toString()))
								.build();
						trendneg.add( jvalue.toString());
						i++;
					}
					for(int ij=0;ij<trendneg.size();ij++)
					{
						String temp = trendneg.get(ij);
						temp = temp.replace("\"", "");
						trendneg.set(ij,temp);

					}

					session.setAttribute("trendneg",trendneg);
					session.setAttribute("trendnegagg",trendneg);
					session.setAttribute("sentires", mr);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
										
			}
			else if(st_spa.equals("day"))
			{
				String tracker = (String) session.getAttribute("tracker");
				String userName = (String) session.getAttribute("user");
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

					Sentiments_util s = new Sentiments_util();
					long diff[] = s.differenceBetweenDates(startdate,enddate);  //days, months, years

					Map<String, Object> configg = new HashMap<String, Object>();
					//if you need pretty printing
					configg.put("javax.json.stream.JsonGenerator.prettyPrinting", Boolean.valueOf(true));

					//ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsyearly(startdate, enddate);
					//ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsmonthly(startdate, enddate);
					//ArrayList<blogtracker.util.Sentiments_result> wr =s.getsentimentsweekly(startdate, enddate);
					ArrayList<blogtracker.util.Sentiments_result> mr =s.getsentimentsdaily(startdate, enddate,userName,tracker);

					JsonBuilderFactory factory = Json.createBuilderFactory(configg);
					
					
					ArrayList<String> trendpos = new ArrayList<String>();


					Integer i = 0;
					while(i<mr.size()) {

						Date t = df.parse(mr.get(i).date);
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(mr.get(i).possenti.toString()))
								.build();
						trendpos.add( jvalue.toString());
						i++;
					}	

					for(int ii=0;ii<trendpos.size();ii++)
					{
						String temp = trendpos.get(ii);
						temp = temp.replace("\"", "");
						trendpos.set(ii,temp);

					}
					session.setAttribute("trendpos", trendpos);
					session.setAttribute("trendposagg", trendpos);
					session.setAttribute("names", "");
					// Get a set of the entries
					//  Set set2 = ynegsenti.entrySet();

					// Get an iterator
					i = 0;

					ArrayList<String> trendneg = new ArrayList<String>();

					while(i<mr.size()) {

						Date t = df.parse(mr.get(i).date);
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						// Map.Entry me = (Map.Entry)i2.next();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(mr.get(i).negsenti.toString()))
								.build();
						trendneg.add( jvalue.toString());
						i++;
					}
					for(int ij=0;ij<trendneg.size();ij++)
					{
						String temp = trendneg.get(ij);
						temp = temp.replace("\"", "");
						trendneg.set(ij,temp);

					}
					session.setAttribute("trendneg",trendneg);
					session.setAttribute("trendnegagg",trendneg);
					session.setAttribute("sentires", mr);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
		}
		else if(request.getParameter("aggr_norm")!=null && request.getParameter("aggr_norm").equals("normalized" )&& request.getParameter("go")==null)
		{
			
				System.out.println("inside normalized" );
				session.setAttribute("radio","normalized");
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd"); 
				Map<String, Object> configg = new HashMap<String, Object>();
				//if you need pretty printing
				configg.put("javax.json.stream.JsonGenerator.prettyPrinting", Boolean.valueOf(true));
				
				
				
				
				ArrayList<blogtracker.util.Sentiments_result> sr = (ArrayList<Sentiments_result>) session.getAttribute("sentires");
				if(st_spa.equals("year"))
				{
					
					JsonBuilderFactory factory = Json.createBuilderFactory(configg);
					ArrayList<String> trendposnorm = new ArrayList<String>();
					ArrayList<ArrayList<Integer>> norm_aggr_pos =new ArrayList<ArrayList<Integer>>();  
					ArrayList<ArrayList<Integer>> norm_aggr_neg =new ArrayList<ArrayList<Integer>>();

					Integer i = 0;
					while(i<sr.size()) {
						Date t;
						ArrayList<Integer> td = new ArrayList<Integer>();
						try {
							t = df.parse(sr.get(i).date);
						
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(sr.get(i).possenti.toString())/sr.get(i).titles.size())
								.build();
						trendposnorm.add( jvalue.toString());
						td.add(Integer.parseInt(sr.get(i).possenti.toString())/sr.get(i).titles.size());
						td.add(Integer.parseInt(sr.get(i).possenti.toString()));
						norm_aggr_pos.add(td);
						i++;
						System.out.println("ll "+Integer.parseInt(sr.get(i).possenti.toString())/sr.get(i).titles.size());
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}	

					for(int ii=0;ii<trendposnorm.size();ii++)
					{
						String temp = trendposnorm.get(ii);
						temp = temp.replace("\"", "");
						trendposnorm.set(ii,temp);

					}
					session.setAttribute("trendpos", trendposnorm);
					session.setAttribute("trendposnorm", trendposnorm);
					session.setAttribute("norm_aggr_pos",norm_aggr_pos);
					session.setAttribute("names", "");
					// Get a set of the entries
					//  Set set2 = ynegsenti.entrySet();

					// Get an iterator
					i = 0;

					ArrayList<String> trendnegnorm = new ArrayList<String>();

					while(i<sr.size()) {
						Date t;
						ArrayList<Integer> td = new ArrayList<Integer>();
						try {
							t = df.parse(sr.get(i).date);
						
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(sr.get(i).negsenti.toString())/sr.get(i).titles.size())
								.build();
						trendnegnorm.add( jvalue.toString());
						td.add(Integer.parseInt(sr.get(i).negsenti.toString())/sr.get(i).titles.size());
						td.add(Integer.parseInt(sr.get(i).negsenti.toString()));
						norm_aggr_neg.add(td);
						i++;
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
					for(int ij=0;ij<trendnegnorm.size();ij++)
					{
						String temp = trendnegnorm.get(ij);
						temp = temp.replace("\"", "");
						trendnegnorm.set(ij,temp);

					}

					session.setAttribute("trendneg",trendnegnorm);
					session.setAttribute("trendnegnorm",trendnegnorm);
					session.setAttribute("norm_aggr_neg",norm_aggr_neg);
					
				}
				else if(st_spa.equals("month"))
				{
					JsonBuilderFactory factory = Json.createBuilderFactory(configg);
					ArrayList<String> trendposnorm = new ArrayList<String>();
					ArrayList<ArrayList<Integer>> norm_aggr_pos =new ArrayList<ArrayList<Integer>>();  
					ArrayList<ArrayList<Integer>> norm_aggr_neg =new ArrayList<ArrayList<Integer>>();

					System.out.println(" inside month");
					Integer i = 0;
					while(i<sr.size()) {
						ArrayList<Integer> td = new ArrayList<Integer>();
						Date t;
						try {
							t = df.parse(sr.get(i).date);
						
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(sr.get(i).possenti.toString())/sr.get(i).titles.size())
								.build();
						trendposnorm.add( jvalue.toString());
						td.add(Integer.parseInt(sr.get(i).possenti.toString())/sr.get(i).titles.size());
						td.add(Integer.parseInt(sr.get(i).possenti.toString()));
						norm_aggr_pos.add(td);
						System.out.println(" pos "+td.get(0)+" neg"+td.get(1));
						System.out.println(" pos "+norm_aggr_pos.get(0).get(0)+" neg"+norm_aggr_pos.get(0).get(1));	
						i++;
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}	

					for(int ii=0;ii<trendposnorm.size();ii++)
					{
						String temp = trendposnorm.get(ii);
						temp = temp.replace("\"", "");
						trendposnorm.set(ii,temp);

					}
				//	System.out.println(" pos "+norm_aggr_pos.get(0).get(1)+" neg"+norm_aggr_neg.get(0).get(1));
					session.setAttribute("trendpos", trendposnorm);
					session.setAttribute("trendposnorm", trendposnorm);
					session.setAttribute("norm_aggr_pos",norm_aggr_pos);
					session.setAttribute("names", "");
					// Get a set of the entries
					//  Set set2 = ynegsenti.entrySet();

					// Get an iterator
					i = 0;

					ArrayList<String> trendnegnorm = new ArrayList<String>();

					while(i<sr.size()) {
						ArrayList<Integer> td = new ArrayList<Integer>();
						Date t;
						try {
							t = df.parse(sr.get(i).date);
						
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(sr.get(i).negsenti.toString())/sr.get(i).titles.size())
								.build();
						trendnegnorm.add( jvalue.toString());
						td.add(Integer.parseInt(sr.get(i).negsenti.toString())/sr.get(i).titles.size());
						td.add(Integer.parseInt(sr.get(i).negsenti.toString()));
						norm_aggr_neg.add(td);
						i++;
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
					for(int ij=0;ij<trendnegnorm.size();ij++)
					{
						String temp = trendnegnorm.get(ij);
						temp = temp.replace("\"", "");
						trendnegnorm.set(ij,temp);

					}
					session.setAttribute("trendneg",trendnegnorm);
					session.setAttribute("trendnegnorm",trendnegnorm);
					session.setAttribute("norm_aggr_neg",norm_aggr_neg);
				//	System.out.println(" maps " +norm_aggr_neg.);
					//System.out.println(" maps " +norm_aggr_pos.entrySet());
				}
				else if(st_spa.equals("week"))
				{
					
					JsonBuilderFactory factory = Json.createBuilderFactory(configg);
					ArrayList<String> trendposnorm = new ArrayList<String>();
					ArrayList<ArrayList<Integer>> norm_aggr_pos =new ArrayList<ArrayList<Integer>>();  
					ArrayList<ArrayList<Integer>> norm_aggr_neg =new ArrayList<ArrayList<Integer>>();


					Integer i = 0;
					while(i<sr.size()) {
						ArrayList<Integer> td = new ArrayList<Integer>();
						Date t;
						try {
							t = df.parse(sr.get(i).date);
						
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(sr.get(i).possenti.toString())/sr.get(i).titles.size())
								.build();
						trendposnorm.add( jvalue.toString());
						td.add(Integer.parseInt(sr.get(i).possenti.toString())/sr.get(i).titles.size());
						td.add(Integer.parseInt(sr.get(i).possenti.toString()));
						norm_aggr_pos.add(td);
						i++;
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}	

					for(int ii=0;ii<trendposnorm.size();ii++)
					{
						String temp = trendposnorm.get(ii);
						temp = temp.replace("\"", "");
						trendposnorm.set(ii,temp);

					}
					session.setAttribute("trendpos", trendposnorm);
					session.setAttribute("trendposnorm", trendposnorm);
					session.setAttribute("norm_aggr_pos",norm_aggr_pos);
					session.setAttribute("names", "");
					// Get a set of the entries
					//  Set set2 = ynegsenti.entrySet();

					// Get an iterator
					i = 0;

					ArrayList<String> trendnegnorm = new ArrayList<String>();

					while(i<sr.size()) {
						ArrayList<Integer> td = new ArrayList<Integer>();
						Date t;
						try {
							t = df.parse(sr.get(i).date);
						
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(sr.get(i).negsenti.toString())/sr.get(i).titles.size())
								.build();
						trendnegnorm.add( jvalue.toString());
						td.add(Integer.parseInt(sr.get(i).negsenti.toString())/sr.get(i).titles.size());
						td.add(Integer.parseInt(sr.get(i).negsenti.toString()));
						norm_aggr_neg.add(td);
						i++;
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
					for(int ij=0;ij<trendnegnorm.size();ij++)
					{
						String temp = trendnegnorm.get(ij);
						temp = temp.replace("\"", "");
						trendnegnorm.set(ij,temp);

					}
					session.setAttribute("trendneg",trendnegnorm);
					session.setAttribute("trendnegnorm",trendnegnorm);
					session.setAttribute("norm_aggr_neg",norm_aggr_neg);
					
				}
				else if(st_spa.equals("day"))
				{
					JsonBuilderFactory factory = Json.createBuilderFactory(configg);
					ArrayList<String> trendposnorm = new ArrayList<String>();
					ArrayList<ArrayList<Integer>> norm_aggr_pos =new ArrayList<ArrayList<Integer>>();  
					ArrayList<ArrayList<Integer>> norm_aggr_neg =new ArrayList<ArrayList<Integer>>();

					Integer i = 0;
					while(i<sr.size()) {
						ArrayList<Integer> td = new ArrayList<Integer>();
						Date t;
						try {
							t = df.parse(sr.get(i).date);
						
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(sr.get(i).possenti.toString())/sr.get(i).titles.size())
								.build();
						trendposnorm.add( jvalue.toString());
						td.add(Integer.parseInt(sr.get(i).possenti.toString())/sr.get(i).titles.size());
						td.add(Integer.parseInt(sr.get(i).possenti.toString()));
						norm_aggr_pos.add(td);
						i++;
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}	
					for(int ii=0;ii<trendposnorm.size();ii++)
					{
						String temp = trendposnorm.get(ii);
						temp = temp.replace("\"", "");
						trendposnorm.set(ii,temp);

					}
					session.setAttribute("trendpos", trendposnorm);
					session.setAttribute("trendposnorm", trendposnorm);
					session.setAttribute("norm_aggr_pos",norm_aggr_pos);
					session.setAttribute("names", "");

					// Get a set of the entries
					//  Set set2 = ynegsenti.entrySet();

					// Get an iterator
					i = 0;

					ArrayList<String> trendnegnorm = new ArrayList<String>();

					while(i<sr.size()) {
						ArrayList<Integer> td = new ArrayList<Integer>();
						
						Date t;
						try {
							t = df.parse(sr.get(i).date);
						
						Calendar c = Calendar.getInstance();
						c.setTime(t);
						c.add(Calendar.MONTH, -1);
						t=c.getTime();
						String tt=df.format(t).toString();
						JsonObject jvalue = factory.createObjectBuilder()
								.add("x","new Date("+tt.substring(0, 4)+","+tt.substring(5,7)+","+tt.substring(8,10)+")")
								.add("y",Integer.parseInt(sr.get(i).negsenti.toString())/sr.get(i).titles.size())
								.build();
						trendnegnorm.add( jvalue.toString());
						td.add(Integer.parseInt(sr.get(i).negsenti.toString())/sr.get(i).titles.size());
						td.add(Integer.parseInt(sr.get(i).negsenti.toString()));
						norm_aggr_neg.add(td);
						i++;
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
					for(int ij=0;ij<trendnegnorm.size();ij++)
					{
						String temp = trendnegnorm.get(ij);
						temp = temp.replace("\"", "");
						trendnegnorm.set(ij,temp);

					}
					session.setAttribute("trendneg",trendnegnorm);
					session.setAttribute("trendnegnorm",trendnegnorm);
					session.setAttribute("norm_aggr_neg",norm_aggr_neg);
					
					
				}
				
			}
		}
		if(request.getParameter("go")!=null)
		{
			System.out.println(" inside go");
			if(session.getAttribute("datepicked")!=null && session.getAttribute("tracker")!=null
					&& session.getAttribute("trendneg")!="" && session.getAttribute("trendpos")!="" && session.getAttribute("names")!=null){
				String[] selectedpostid = request.getParameterValues("table_records");
				 ArrayList<ArrayList<String>> names = (ArrayList<ArrayList<String>>) session.getAttribute("names");
				for(int i=0;i<names.size();i++)
				{
					for(int j=0;j<selectedpostid.length;j++)
					{
						if(selectedpostid[j].equals(names.get(i).get(1)))
						{
							names.get(i).add("checked");
						}
					}
				}
				
				for(int i=0;i<names.size();i++)
				{
					for(String item:names.get(i))
					{
					System.out.print(" loop        "+item );
					}
					System.out.println("");
				}
				Map<String, Object> configg = new HashMap<String, Object>();
				//if you need pretty printing
				configg.put("javax.json.stream.JsonGenerator.prettyPrinting", Boolean.valueOf(true));
				JsonBuilderFactory factory = Json.createBuilderFactory(configg);
				ArrayList<String> radar = new ArrayList<String>();
				ArrayList<String> radar1 = new ArrayList<String>();
				ArrayList<String> radar2= new ArrayList<String>();
				ArrayList<String> radar3 = new ArrayList<String>();
				ArrayList<String> radar4 = new ArrayList<String>();
				ArrayList<String> radar5 = new ArrayList<String>();
				int i=3,j=88,k=106; double l= 0.80;
				int m=245,n=10,o=38; double p=0.85;
				ArrayList<Sentiments_result> sr = (ArrayList<Sentiments_result>)session.getAttribute("sentires");

				for(int kk=0;kk<sr.size();kk++)
				{	


					String t = (String) session.getAttribute("selecteddate");
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

					Date rdate = new Date();
					try {
						rdate = formatter.parse(t);
						Calendar c = Calendar.getInstance();
						c.setTime(rdate);
						c.add(Calendar.MONTH, 0);		//date decrement
						rdate=c.getTime();

					} catch (ParseException e) {
						e.printStackTrace();
					}
					if(sr.get(kk).emo.get(formatter.format(rdate))!=null)
					{	
						for(int ii=0;ii<selectedpostid.length;ii++)
						{	


							{
								//block radar

								if(ii%2!=0)
								{	

									int d1=sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(0);
									int d2 =sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(1);
									int d3= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(2);
									int d4= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(3);
									int d5= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(4);
									int d6= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(5);

									JsonObject jvalue = factory.createObjectBuilder()
											.add("label","Blogpost"+ii+1)
											.add("backgroundColor","rgba("+i+","+j+","+k+",0)")
											.add("borderColor","rgba("+i+","+j+","+k+","+l+")")
											.add("pointBorderColor","rgba("+i+","+j+","+k+","+l+")")
											.add("pointBackgroundColor","rgba("+i+","+j+","+k+","+l+")")
											.add("pointHoverBackgroundColor", "#fff")
											.add("pointHighlightStroke", "rgba(151,187,205,1)")
											.add("data", "["+d1+","+d2+","+d3+","+d4+","+d5+","+d6+"]")
											.build();
									radar.add(jvalue.toString());
								}
								else
								{
									int d1=sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(0);
									int d2 =sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(1);
									int d3= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(2);
									int d4= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(3);
									int d5= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(4);
									int d6= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(5);

									JsonObject jvalue = factory.createObjectBuilder()
											.add("label","Blogpost"+ii+1)
											.add("backgroundColor","rgba("+m+","+n+","+o+",0)")
											.add("borderColor","rgba("+m+","+n+","+o+","+p+")")
											.add("pointBorderColor","rgba("+m+","+n+","+o+","+p+")")
											.add("pointBackgroundColor","rgba("+m+","+n+","+o+","+p+")")
											.add("pointHoverBackgroundColor", "#fff")
											.add("pointHighlightStroke", "rgba(151,187,205,1)")
											.add("data", "["+d1+","+d2+","+d3+","+d4+","+d5+","+d6+"]")	
											.build();
									radar.add(jvalue.toString());
								}
							}


							{
								//block radar1

								if(ii%2!=0)
								{	
									int d1=sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(6);
									int d2 =sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(7);
									int d3= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(8);

									JsonObject jvalue = factory.createObjectBuilder()
											.add("label","Blogpost"+ii+1)
											.add("backgroundColor","rgba("+i+","+j+","+k+",0)")
											.add("borderColor","rgba("+i+","+j+","+k+","+l+")")
											.add("pointBorderColor","rgba("+i+","+j+","+k+","+l+")")
											.add("pointBackgroundColor","rgba("+i+","+j+","+k+","+l+")")
											.add("pointHoverBackgroundColor", "#fff")
											.add("pointHighlightStroke", "rgba(151,187,205,1)")
											.add("data", "["+d1+","+d2+","+d3+"]")
											.build();
									radar1.add(jvalue.toString());
								}
								else
								{
									int d1=sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(6);
									int d2 =sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(7);
									int d3= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(8);

									JsonObject jvalue = factory.createObjectBuilder()
											.add("label","Blogpost"+ii+1)
											.add("backgroundColor","rgba("+m+","+n+","+o+",0)")
											.add("borderColor","rgba("+m+","+n+","+o+","+p+")")
											.add("pointBorderColor","rgba("+m+","+n+","+o+","+p+")")
											.add("pointBackgroundColor","rgba("+m+","+n+","+o+","+p+")")
											.add("pointHoverBackgroundColor", "#fff")
											.add("pointHighlightStroke", "rgba(151,187,205,1)")
											.add("data", "["+d1+","+d2+","+d3+"]")	
											.build();
									radar1.add(jvalue.toString());
								}
							}

							{
								//block radar2

								if(ii%2!=0)
								{	
									int d1=sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(9);
									int d2 =sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(10);
									int d3= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(11);
									int d4= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(12);
									int d5= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(13);
									//int d6= sr.get(0).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(5);

									JsonObject jvalue = factory.createObjectBuilder()
											.add("label","Blogpost"+ii+1)
											.add("backgroundColor","rgba("+i+","+j+","+k+",0)")
											.add("borderColor","rgba("+i+","+j+","+k+","+l+")")
											.add("pointBorderColor","rgba("+i+","+j+","+k+","+l+")")
											.add("pointBackgroundColor","rgba("+i+","+j+","+k+","+l+")")
											.add("pointHoverBackgroundColor", "#fff")
											.add("pointHighlightStroke", "rgba(151,187,205,1)")
											.add("data", "["+d1+","+d2+","+d3+","+d4+","+d5+"]")
											.build();
									radar2.add(jvalue.toString());
								}
								else
								{
									int d1=sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(9);
									int d2 =sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(10);
									int d3= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(11);
									int d4= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(12);
									int d5= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(13);

									JsonObject jvalue = factory.createObjectBuilder()
											.add("label","Blogpost"+ii+1)
											.add("backgroundColor","rgba("+m+","+n+","+o+",0)")
											.add("borderColor","rgba("+m+","+n+","+o+","+p+")")
											.add("pointBorderColor","rgba("+m+","+n+","+o+","+p+")")
											.add("pointBackgroundColor","rgba("+m+","+n+","+o+","+p+")")
											.add("pointHoverBackgroundColor", "#fff")
											.add("pointHighlightStroke", "rgba(151,187,205,1)")
											.add("data", "["+d1+","+d2+","+d3+","+d4+","+d5+"]")	
											.build();
									radar2.add(jvalue.toString());
								}
							}


							{
								//block radar3

								if(ii%2!=0)
								{	
									int d1=sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(14);
									int d2 =sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(15);
									int d3= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(16);
									int d4= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(17);
									int d5= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(18);
									int d6= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(19);

									JsonObject jvalue = factory.createObjectBuilder()
											.add("label","Blogpost"+ii+1)
											.add("backgroundColor","rgba("+i+","+j+","+k+",0)")
											.add("borderColor","rgba("+i+","+j+","+k+","+l+")")
											.add("pointBorderColor","rgba("+i+","+j+","+k+","+l+")")
											.add("pointBackgroundColor","rgba("+i+","+j+","+k+","+l+")")
											.add("pointHoverBackgroundColor", "#fff")
											.add("pointHighlightStroke", "rgba(151,187,205,1)")
											.add("data", "["+d1+","+d2+","+d3+","+d4+","+d5+","+d6+"]")
											.build();
									radar3.add(jvalue.toString());
								}
								else
								{
									int d1=sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(14);
									int d2 =sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(15);
									int d3= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(16);
									int d4= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(17);
									int d5= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(18);
									int d6= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(19);

									JsonObject jvalue = factory.createObjectBuilder()
											.add("label","Blogpost"+ii+1)
											.add("backgroundColor","rgba("+m+","+n+","+o+",0)")
											.add("borderColor","rgba("+m+","+n+","+o+","+p+")")
											.add("pointBorderColor","rgba("+m+","+n+","+o+","+p+")")
											.add("pointBackgroundColor","rgba("+m+","+n+","+o+","+p+")")
											.add("pointHoverBackgroundColor", "#fff")
											.add("pointHighlightStroke", "rgba(151,187,205,1)")
											.add("data", "["+d1+","+d2+","+d3+","+d4+","+d5+","+d6+"]")	
											.build();
									radar3.add(jvalue.toString());
								}
							}


							{
								//block radar4

								if(ii%2!=0)
								{	
									int d1=sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(20);
									int d2 =sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(21);
									int d3= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(22);
									int d4= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(23);

									JsonObject jvalue = factory.createObjectBuilder()
											.add("label","Blogpost"+ii+1)
											.add("backgroundColor","rgba("+i+","+j+","+k+",0)")
											.add("borderColor","rgba("+i+","+j+","+k+","+l+")")
											.add("pointBorderColor","rgba("+i+","+j+","+k+","+l+")")
											.add("pointBackgroundColor","rgba("+i+","+j+","+k+","+l+")")
											.add("pointHoverBackgroundColor", "#fff")
											.add("pointHighlightStroke", "rgba(151,187,205,1)")
											.add("data", "["+d1+","+d2+","+d3+","+d4+"]")
											.build();
									radar4.add(jvalue.toString());
								}
								else
								{
									int d1=sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(20);
									int d2 =sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(21);
									int d3= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(22);
									int d4= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(23);

									JsonObject jvalue = factory.createObjectBuilder()
											.add("label","Blogpost"+ii+1)
											.add("backgroundColor","rgba("+m+","+n+","+o+",0)")
											.add("borderColor","rgba("+m+","+n+","+o+","+p+")")
											.add("pointBorderColor","rgba("+m+","+n+","+o+","+p+")")
											.add("pointBackgroundColor","rgba("+m+","+n+","+o+","+p+")")
											.add("pointHoverBackgroundColor", "#fff")
											.add("pointHighlightStroke", "rgba(151,187,205,1)")
											.add("data", "["+d1+","+d2+","+d3+","+d4+"]")	
											.build();
									radar4.add(jvalue.toString());
								}
							}	


							{
								//block radar5

								if(ii%2!=0)
								{	
									int d1=sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(24);
									int d2 =sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(25);
									int d3= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(26);
									int d4= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(27);
									int d5= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(28);

									JsonObject jvalue = factory.createObjectBuilder()
											.add("label","Blogpost"+ii+1)
											.add("backgroundColor","rgba("+i+","+j+","+k+",0)")
											.add("borderColor","rgba("+i+","+j+","+k+","+l+")")
											.add("pointBorderColor","rgba("+i+","+j+","+k+","+l+")")
											.add("pointBackgroundColor","rgba("+i+","+j+","+k+","+l+")")
											.add("pointHoverBackgroundColor", "#fff")
											.add("pointHighlightStroke", "rgba(151,187,205,1)")
											.add("data", "["+d1+","+d2+","+d3+","+d4+","+d5+"]")
											.build();
									radar5.add(jvalue.toString());
								}
								else
								{
									int d1=sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(24);
									int d2 =sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(25);
									int d3= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(26);
									int d4= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(27);
									int d5= sr.get(kk).emo.get(formatter.format(rdate)).get(selectedpostid[ii].toString()).get(28);
									JsonObject jvalue = factory.createObjectBuilder()
											.add("label","Blogpost"+ii+1)
											.add("backgroundColor","rgba("+m+","+n+","+o+",0)")
											.add("borderColor","rgba("+m+","+n+","+o+","+p+")")
											.add("pointBorderColor","rgba("+m+","+n+","+o+","+p+")")
											.add("pointBackgroundColor","rgba("+m+","+n+","+o+","+p+")")
											.add("pointHoverBackgroundColor", "#fff")
											.add("pointHighlightStroke", "rgba(151,187,205,1)")
											.add("data", "["+d1+","+d2+","+d3+","+d4+","+d5+"]")	
											.build();
									radar5.add(jvalue.toString());
								}
							}	//end block
							if(ii%2!=0)
							{
								i=i+20;
								j=j+20;
								k=k+20;
							}
							else
							{
								m=m+20;
								n=n+20;
								o=o+20;
							}
						} //end for		


					}//end if
				}//end for
				for(int ii=0;ii<radar.size();ii++)
				{
					String temp = radar.get(ii);
					String[] splits = temp.split("data");
					splits[1] = splits[1].replaceAll("\"","");
					temp=splits[0]+"data\""+splits[1];
					radar.set(ii,temp);

				}

				for(int ii=0;ii<radar1.size();ii++)
				{
					String temp = radar1.get(ii);
					String[] splits = temp.split("data");
					splits[1] = splits[1].replaceAll("\"","");
					temp=splits[0]+"data\""+splits[1];
					radar1.set(ii,temp);

				}

				for(int ii=0;ii<radar2.size();ii++)
				{
					String temp = radar2.get(ii);
					String[] splits = temp.split("data");
					splits[1] = splits[1].replaceAll("\"","");
					temp=splits[0]+"data\""+splits[1];
					radar2.set(ii,temp);
				}

				for(int ii=0;ii<radar3.size();ii++)
				{
					String temp = radar3.get(ii);
					String[] splits = temp.split("data");
					splits[1] = splits[1].replaceAll("\"","");
					temp=splits[0]+"data\""+splits[1];
					radar3.set(ii,temp);
				}
				for(int ii=0;ii<radar4.size();ii++)
				{
					String temp = radar4.get(ii);
					String[] splits = temp.split("data");
					splits[1] = splits[1].replaceAll("\"","");
					temp=splits[0]+"data\""+splits[1];
					radar4.set(ii,temp);
				}

				for(int ii=0;ii<radar5.size();ii++)
				{
					String temp = radar5.get(ii);
					String[] splits = temp.split("data");
					splits[1] = splits[1].replaceAll("\"","");
					temp=splits[0]+"data\""+splits[1];
					radar5.set(ii,temp);
				}
				session.setAttribute("radar", radar);
				session.setAttribute("radar1", radar1);
				session.setAttribute("radar2", radar2);
				session.setAttribute("radar3", radar3);
				session.setAttribute("radar4", radar4);
				session.setAttribute("radar5", radar5);
				session.setAttribute("selectedpostid",selectedpostid);
				session.setAttribute("names",names);
			}
			else
			{				
				session.setAttribute("radar", "");
				session.setAttribute("radar1", "");
				session.setAttribute("radar2", "");
				session.setAttribute("radar3", "");
				session.setAttribute("radar4", "");
				session.setAttribute("radar5", "");
				session.setAttribute("selectedpostid","");
			}	

	}

	
	%>
	

<% ArrayList mytrackers = new ArrayList();
mytrackers = (ArrayList)session.getAttribute("trackers");
int trackerSize = mytrackers.size();
    if(trackerSize == 0)
    {%>
    
  <% } %> 


											<div id="chartContainer" style="height: 350px"></div>

											<div style="text-align: center; margin-bottom: 15px;">
												<br />


												<form name="st_spanform" id="st_spanform"
													action="Sentiments" method="post">

													<%
														Object span = (null == session.getAttribute("st_span")) ? "" : session.getAttribute("st_span");
														if (span != null && (span.toString()).equalsIgnoreCase("month")) {
													%>

													<div class="btn-group colors" data-toggle="buttons">
														<label class="btn btn-default btn-sm"> <input
															type="radio" name="options" value="day"
															autocomplete="off" onchange="spanChanged()"> Day
														</label> <label class="btn btn-default btn-sm"> <input
															type="radio" name="options" value="week"
															autocomplete="off" onchange="spanChanged()"> Week
														</label> <label class="btn btn-default btn-sm active"> <input
															type="radio" name="options" value="month"
															autocomplete="off" checked onchange="spanChanged()">
															Month
														</label> <label class="btn btn-default btn-sm"> <input
															type="radio" name="options" value="year"
															autocomplete="off" onchange="spanChanged()"> Year
														</label>
													</div>
													<%
														} else if (span != null && (span.toString()).equalsIgnoreCase("day")) {
													%>
													<div class="btn-group colors" data-toggle="buttons">
														<label class="btn btn-default btn-sm active"> <input
															type="radio" name="options" value="day"
															autocomplete="off" checked onchange="spanChanged()">
															Day
														</label> <label class="btn btn-default btn-sm"> <input
															type="radio" name="options" value="week"
															autocomplete="off" onchange="spanChanged()"> Week
														</label> <label class="btn btn-default btn-sm"> <input
															type="radio" name="options" value="month"
															autocomplete="off" onchange="spanChanged()">
															Month
														</label> <label class="btn btn-default btn-sm"> <input
															type="radio" name="options" value="year"
															autocomplete="off" onchange="spanChanged()"> Year
														</label>
													</div>
													<%
														} else if (span != null && (span.toString()).equalsIgnoreCase("year")) {
													%>
													<div class="btn-group colors" data-toggle="buttons">
														<label class="btn btn-default btn-sm"> <input
															type="radio" name="options" value="day"
															autocomplete="off" onchange="spanChanged()"> Day
														</label> <label class="btn btn-default btn-sm"> <input
															type="radio" name="options" value="week"
															autocomplete="off" onchange="spanChanged()"> Week
														</label> <label class="btn btn-default btn-sm"> <input
															type="radio" name="options" value="month"
															autocomplete="off" onchange="spanChanged()">
															Month
														</label> <label class="btn btn-default btn-sm active"> <input
															type="radio" name="options" value="year"
															autocomplete="off" checked onchange="spanChanged()">
															Year
														</label>
													</div>
													<%
														} else if (span != null && (span.toString()).equalsIgnoreCase("week")) {
													%>

													<div class="btn-group colors" data-toggle="buttons">
														<label class="btn btn-default btn-sm"> <input
															type="radio" name="options" value="day"
															autocomplete="off" onchange="spanChanged()"> Day
														</label> <label class="btn btn-default btn-sm active"> <input
															type="radio" name="options" value="week"
															autocomplete="off" checked onchange="spanChanged()">
															Week
														</label> <label class="btn btn-default btn-sm"> <input
															type="radio" name="options" value="month"
															autocomplete="off" onchange="spanChanged()">
															Month
														</label> <label class="btn btn-default btn-sm"> <input
															type="radio" name="options" value="year"
															autocomplete="off" onchange="spanChanged()"> Year
														</label>
													</div>
													<%
														} else {
													%>
													<div class="btn-group colors" data-toggle="buttons">
														<label class="btn btn-default btn-sm"> <input
															type="radio" name="options" value="day"
															autocomplete="off" onchange="spanChanged()"> Day
														</label> <label class="btn btn-default btn-sm"> <input
															type="radio" name="options" value="week"
															autocomplete="off" onchange="spanChanged()"> Week
														</label> <label class="btn btn-default btn-sm"> <input
															type="radio" name="options" value="month"
															autocomplete="off" onchange="spanChanged()">
															Month
														</label> <label class="btn btn-default btn-sm"> <input
															type="radio" name="options" value="year"
															autocomplete="off" onchange="spanChanged()"> Year
														</label>
													</div>

													<%
														}
													%>

												</form>


												<!-- <div class="btn-group" role="group" aria-label="First group">
													<form name="spanform" id="spanform" action="Sentiments" method="post">
														<button type="submit" name="spandaily" value="daily" id="addDataPoint"
															class="btn btn-default btn-sm">Day</button>
														<button type="submit" name="spanweekly" value="weekly"
															class="btn btn-default btn-sm">Week</button>
														<button type="submit" name="spanmonthly" value="monthly"
															class="btn btn-default btn-sm">Month</button>
														<button type="submit" name="spanyearly" value="yearly"
															class="btn btn-default btn-sm">Year</button>
													</form>
													<br/>
												</div> -->

												<form name="trendtype" id="trendtype" action="Sentiments"
													method="post">
													<c:choose>
														<c:when test="${radio eq 'aggregate'}">
															<input type="radio" name="aggr_norm" value="aggregate"
																checked="checked"> Aggregate 
															<input type="radio"  name="aggr_norm" value="normalized"
																onchange="aggr_norm_changed()"> Normalized
													    </c:when>
														<c:otherwise>

															<input type="radio" name="aggr_norm" value="aggregate"
																onchange="aggr_norm_changed()"> Aggregate 
															<input type="radio" name="aggr_norm" value="normalized"
																checked="checked"> Normalized
													    
    												</c:otherwise>
													</c:choose>
												</form>


												<div id="chartpoint">
													<form name="xyform" id="xyform" action="Sentiments"
														method="post">
														<input id="xychange" name="xychange" type="hidden"
															onchange="xychanged()">
													</form>
												</div>

											</div>
<jsp:include page="../pagedependencies/sentiments.jsp"></jsp:include>