package wrapper;

/*****
 * Author Adigun Adekunle
 * 
 * 
 * */

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.Month;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import blogtracker.gui.blogtrackers.BeanAllSites;
import blogtracker.util.BlogNetworkUtil;
import blogtracker.util.TrackerDialog;

/**
 * Servlet implementation class BlogNetwork
 */
@WebServlet("/BlogNetwork")
public class BlogNetwork extends HttpServlet {
	private static final long serialVersionUID = 1L;
	TrackerDialog trackerDialog= new TrackerDialog();  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BlogNetwork() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		HttpSession session= request.getSession();
		
	    doPost(request,response);
	   
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println(" post  on net");
		request.setCharacterEncoding("UTF-8");
		HttpSession session= request.getSession();
		
		if((session.getAttribute("tracker")==null && request.getParameter("tracker")==null))
		{
			session.setAttribute("blog_network", "");
		}
		else
		{
			System.out.println("  inside else before");
			if(request.getParameter("blogtoblog") != null)
			{
			System.out.println(request.getParameter("blogtoblog").toString());	
			}
			// block of code for get parameter
//				if(session.getAttribute("tracker") != null && request.getParameter("tracker")==null)
//						{
//							String tracker = session.getAttribute("tracker").toString();
//							System.out.println("Tracker Session "+tracker);	
//							
//							//Saad's Code
//							String userName = (String) session.getAttribute("user");
//							String selectedSites=trackerDialog.getSelectedSites(userName,tracker);
//							ArrayList<BeanAllSites> allSites=trackerDialog.getSiteNames(selectedSites);
//							if(session.getAttribute("bsName")!=null)
//								session.removeAttribute("bsName");
//							session.setAttribute("allSepSites", allSites);
//							//Ends here
//							System.out.println(" before cal");
//							
//							
//							BlogNetworkUtil bg = new BlogNetworkUtil();
//							//bg.get_bn_sites(userName,tracker);
//							
//							
//						}
						// block of code for request parameter	
			if(request.getParameter("tracker")!=null )
			{
				String tracker = request.getParameter("tracker");
				System.out.println(" before");
				session.setAttribute("tracker", tracker);	
				System.out.println("Tracker Name for request" +tracker);
							
				//Saad's Code
				String userName = (String) session.getAttribute("user");
				String selectedSites=trackerDialog.getSelectedSites(userName,tracker);
				ArrayList<BeanAllSites> allSites=trackerDialog.getSiteNames(selectedSites);
				if(session.getAttribute("bsName")!=null)
					session.removeAttribute("bsName");
				session.setAttribute("allSepSites", allSites);
				//Ends here
				System.out.println(" before cal");
				
				
				BlogNetworkUtil bg = new BlogNetworkUtil();
				//bg.get_bn_sites(userName,tracker);	
			 }
				
		
			if(request.getParameter("datepicked") != null)
			{
				try
				{
				String date = request.getParameter("datepicked");
				session.setAttribute("datepicked", date);

				//System.out.println("Filter Value"+filtervalue );
				System.out.println("Date for Request "+date);
				// addition by adekunle blog network by date range
				date = session.getAttribute("datepicked").toString();
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

		
			String tracker = (String) session.getAttribute("tracker");
			//Saad's Code
			String userName = (String) session.getAttribute("user");
			String selectedSites=trackerDialog.getSelectedSites(userName,tracker);
			ArrayList<BeanAllSites> allSites=trackerDialog.getSiteNames(selectedSites);
			if(session.getAttribute("bsName")!=null)
				session.removeAttribute("bsName");
			session.setAttribute("allSepSites", allSites);
			//Ends here
			System.out.println(" before cal");
			
			BlogNetworkUtil bg = new BlogNetworkUtil();
			HashMap<Integer,String> sn =bg.get_bn_sites(startdate, enddate, userName,tracker); //site id and names
			/*HashMap<Integer,Integer> sid =new HashMap<Integer,Integer>(); 
			int i=1;*/
					
			HashMap<Integer,String> bln =bg.get_bn_bloggers(userName,tracker); //site id and bloggers
			//creating blogger ids
			ArrayList<ArrayList<String>> bid = new ArrayList<ArrayList<String>>();
			int x=267;
			for (Map.Entry<Integer,String> entry : bln.entrySet())
			{
				ArrayList<String> t = new ArrayList<String>();
				int y = x++;
				t.add(Integer.toString(y));  //blogger id
				t.add(Integer.toString(entry.getKey()));  //blogsite id
				t.add(entry.getValue());  //blogger name
				t.add("arrows:'to, from'");
				bid.add(t);
			}
			
			//creating media ids
			HashMap<Integer,String> dn =bg.get_bn_medias(startdate, enddate,userName,tracker);  // site id and domain
			ArrayList<ArrayList<String>> mid = new ArrayList<ArrayList<String>>();
			ArrayList<ArrayList<String>> fb = new ArrayList<ArrayList<String>>();
			ArrayList<ArrayList<String>> yt = new ArrayList<ArrayList<String>>();
			ArrayList<ArrayList<String>> tw = new ArrayList<ArrayList<String>>();
			ArrayList<ArrayList<String>> in = new ArrayList<ArrayList<String>>();
			ArrayList<ArrayList<String>> tmb = new ArrayList<ArrayList<String>>();
			ArrayList<ArrayList<String>> en = new ArrayList<ArrayList<String>>();
			/*for (Map.Entry<Integer,String> entry : dn.entrySet())
			{
				ArrayList<String> t = new ArrayList<String>();
				int y = x++;
				t.add("0"+Integer.toString(y));  //media id
				t.add(Integer.toString(entry.getKey()));  //blogsite id
				t.add(entry.getValue());  //media name
				mid.add(t);
			}*/
			
			//Identifying social media sites
			HashMap<String,String> cate =bg.get_bn_media_category(userName,tracker); 
			
			for (Map.Entry<Integer,String> entry : dn.entrySet())
			{
				ArrayList<String> t = new ArrayList<String>();
				int y = x++;
				t.add(Integer.toString(y));  //media id
				t.add(Integer.toString(entry.getKey()));  //blogsite id
				t.add(entry.getValue());  //media name
				t.add("arrows:'from'");
				if(entry.getValue().contains("facebook"))
				{
					fb.add(t);
				}
				else if(entry.getValue().contains("twitter"))
				{
					tw.add(t);
				}
				else if(entry.getValue().contains("youtube"))
				{
					yt.add(t);
				}
				else if(entry.getValue().contains("linkedin"))
				{
					in.add(t);
				}
				else if(entry.getValue().contains("tumblr"))
				{
					tmb.add(t);
				}
				else
				{
					mid.add(t);
				}
				
			}
			
			ArrayList<ArrayList<String>> entities = bg.get_bn_entity(startdate, enddate,userName,tracker);
			for (int j=0;j<entities.size();j++)
			{
				ArrayList<String> t = new ArrayList<String>();
				int y = x++;
				t.add(Integer.toString(y));  //media id
				t.add(entities.get(j).get(0));  //blogsite id
				t.add(entities.get(j).get(1));  //entity
				t.add("arrows:'from'");
				en.add(t);
			}
		
			
			
			//creating nodes
			ArrayList<ArrayList<String>> nodes = new ArrayList<ArrayList<String>>();
			for (Map.Entry<Integer,String> entry : sn.entrySet())
			{
				ArrayList<String> t = new ArrayList<String>();
				t.add(Integer.toString(entry.getKey()));
				t.add(entry.getValue());
				t.add("diamonds");
				nodes.add(t);
			}
			
			for( int i=0;i<bid.size();i++)
			{
				ArrayList<String> t = new ArrayList<String>();
				t.add(bid.get(i).get(0));
				t.add(bid.get(i).get(2));
				t.add("icons");
				nodes.add(t);
			}
			for( int i=0;i<fb.size();i++)
			{
				ArrayList<String> t = new ArrayList<String>();
				t.add(fb.get(i).get(0));
				t.add(fb.get(i).get(2));
				t.add("facebook");
				nodes.add(t);
			}
			for( int i=0;i<tw.size();i++)
			{
				ArrayList<String> t = new ArrayList<String>();
				t.add(tw.get(i).get(0));
				t.add(tw.get(i).get(2));
				t.add("twitter");
				nodes.add(t);
			}
			for( int i=0;i<yt.size();i++)
			{
				ArrayList<String> t = new ArrayList<String>();
				t.add(yt.get(i).get(0));
				t.add(yt.get(i).get(2));
				t.add("youtube");
				nodes.add(t);
			}
			for( int i=0;i<in.size();i++)
			{
				ArrayList<String> t = new ArrayList<String>();
				t.add(in.get(i).get(0));
				t.add(in.get(i).get(2));
				t.add("linkedin");
				nodes.add(t);
			}
			for( int i=0;i<tmb.size();i++)
			{
				ArrayList<String> t = new ArrayList<String>();
				t.add(tmb.get(i).get(0));
				t.add(tmb.get(i).get(2));
				t.add("tumblr");
				nodes.add(t);
			}
			for( int i=0;i<en.size();i++)  //entity code for creating node
			{
				ArrayList<String> t = new ArrayList<String>();
				t.add(en.get(i).get(0));
				t.add(en.get(i).get(2));
				t.add("circle");
				nodes.add(t);
			}							//entity code end
			for( int i=0;i<mid.size();i++)
			{
				ArrayList<String> t = new ArrayList<String>();
				t.add(mid.get(i).get(0));
				t.add(mid.get(i).get(2));
				t.add("mints");
				nodes.add(t);
			}
			
			
			//creating links or edges
			ArrayList<ArrayList<String>> edges = new ArrayList<ArrayList<String>>();
			for( int i=0;i<bid.size();i++)
			{
				ArrayList<String> t = new ArrayList<String>();
				t.add(bid.get(i).get(0));
				t.add(bid.get(i).get(1));
				t.add(bid.get(i).get(3));
				edges.add(t);
			}
			for( int i=0;i<fb.size();i++)
			{
				ArrayList<String> t = new ArrayList<String>();
				t.add(fb.get(i).get(0));
				t.add(fb.get(i).get(1));
				t.add(fb.get(i).get(1));
				edges.add(t);
			}
			for( int i=0;i<tw.size();i++)
			{
				ArrayList<String> t = new ArrayList<String>();
				t.add(tw.get(i).get(0));
				t.add(tw.get(i).get(1));
				t.add(tw.get(i).get(3));
				edges.add(t);
			}
			for( int i=0;i<yt.size();i++)
			{
				ArrayList<String> t = new ArrayList<String>();
				t.add(yt.get(i).get(0));
				t.add(yt.get(i).get(1));
				t.add(yt.get(i).get(3));
				edges.add(t);
			}
			for( int i=0;i<in.size();i++)
			{
				ArrayList<String> t = new ArrayList<String>();
				t.add(in.get(i).get(0));
				t.add(in.get(i).get(1));
				t.add(in.get(i).get(3));
				edges.add(t);
			}
			for( int i=0;i<tmb.size();i++)
			{
				ArrayList<String> t = new ArrayList<String>();
				t.add(tmb.get(i).get(0));
				t.add(tmb.get(i).get(1));
				t.add(tmb.get(i).get(3));
				edges.add(t);
			}
			for( int i=0;i<en.size();i++)  //entity code for creating edges
			{
				ArrayList<String> t = new ArrayList<String>();
				t.add(en.get(i).get(0));
				t.add(en.get(i).get(1));
				edges.add(t);
			}							//entity code end
			
			for( int i=0;i<mid.size();i++)
			{
				ArrayList<String> t = new ArrayList<String>();
				t.add(mid.get(i).get(0));
				t.add(mid.get(i).get(1));
				t.add(mid.get(i).get(3));
				edges.add(t);
			}
			
			session.setAttribute("nodes", nodes);
			session.setAttribute("edges", edges);
			System.out.println("print nodes"+nodes);
			System.out.println("print edges"+edges);
		}
			
			catch(Exception ex)
			{
				
			}
		}
			
				// start of the get request for already initialiized session variable
			else if(session.getAttribute("datepicked") != null)
				{
					try
					{
					String date = session.getAttribute("datepicked").toString();
					System.out.println("Date for get" +session.getAttribute("datepicked"));	
					//String filtervalue = request.getParameter("filtervalue");
					//System.out.println("Filter " + filtervalue);
					// addition by adekunle blognetwork search by date range
					// PrintWriter pww = response.getWriter();
					
					if(request.getParameter("blogtoblog") != null)
					{
					String blogtoblog = request.getParameter("blogtoblog");
					session.setAttribute("blogtoblog", blogtoblog);
					System.out.println(request.getParameter("blogtoblog"));	
					}
					if(request.getParameter("blogtoblog") == null)
					{
					session.setAttribute("blogtoblog", "");	
					}
					if(request.getParameter("bloggertoblogger") != null)
					{
					String bloggertoblogger = request.getParameter("bloggertoblogger");
					session.setAttribute("blogtoblog", bloggertoblogger);	
					System.out.println(request.getParameter("bloggertoblogger"));	
					}
					if(request.getParameter("bloggertoblogger") == null)
					{
					session.setAttribute("bloggertoblogger", "");		
					}
					if(request.getParameter("facebook") != null)
					{
					System.out.println(request.getParameter("facebook"));	
					}
					date = session.getAttribute("datepicked").toString();
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

			
				String tracker = (String) session.getAttribute("tracker");
				//Saad's Code
				String userName = (String) session.getAttribute("user");
				String selectedSites=trackerDialog.getSelectedSites(userName,tracker);
				ArrayList<BeanAllSites> allSites=trackerDialog.getSiteNames(selectedSites);
				if(session.getAttribute("bsName")!=null)
					session.removeAttribute("bsName");
				session.setAttribute("allSepSites", allSites);
				//Ends here
				System.out.println(" before cal");
				
				BlogNetworkUtil bg = new BlogNetworkUtil();
				HashMap<Integer,String> sn =bg.get_bn_sites(startdate, enddate, userName,tracker); //site id and names
				/*HashMap<Integer,Integer> sid =new HashMap<Integer,Integer>(); 
				int i=1;*/
						
				HashMap<Integer,String> bln =bg.get_bn_bloggers(userName,tracker); //site id and bloggers
				
				//creating blogger ids
				ArrayList<ArrayList<String>> bid = new ArrayList<ArrayList<String>>();
				int x=267;
				for (Map.Entry<Integer,String> entry : bln.entrySet())
				{
					ArrayList<String> t = new ArrayList<String>();
					int y = x++;
					t.add(Integer.toString(y));  //blogger id
					t.add(Integer.toString(entry.getKey()));  //blogsite id
					t.add(entry.getValue());  //blogger name
					t.add("arrows:'to, from'");
					bid.add(t);
				}
				
				//creating media ids
				HashMap<Integer,String> dn =bg.get_bn_medias(startdate, enddate,userName,tracker);  // site id and domain
				ArrayList<ArrayList<String>> mid = new ArrayList<ArrayList<String>>();
				ArrayList<ArrayList<String>> fb = new ArrayList<ArrayList<String>>();
				ArrayList<ArrayList<String>> yt = new ArrayList<ArrayList<String>>();
				ArrayList<ArrayList<String>> tw = new ArrayList<ArrayList<String>>();
				ArrayList<ArrayList<String>> in = new ArrayList<ArrayList<String>>();
				ArrayList<ArrayList<String>> tmb = new ArrayList<ArrayList<String>>();
				ArrayList<ArrayList<String>> en = new ArrayList<ArrayList<String>>();
				/*for (Map.Entry<Integer,String> entry : dn.entrySet())
				{
					ArrayList<String> t = new ArrayList<String>();
					int y = x++;
					t.add("0"+Integer.toString(y));  //media id
					t.add(Integer.toString(entry.getKey()));  //blogsite id
					t.add(entry.getValue());  //media name
					mid.add(t);
				}*/
				
				//Identifying social media sites
				HashMap<String,String> cate =bg.get_bn_media_category(userName,tracker); 
				
				for (Map.Entry<Integer,String> entry : dn.entrySet())
				{
					ArrayList<String> t = new ArrayList<String>();
					int y = x++;
					t.add(Integer.toString(y));  //media id
					t.add(Integer.toString(entry.getKey()));  //blogsite id
					t.add(entry.getValue());  //media name
					t.add("arrows:'from'");
					if(entry.getValue().contains("facebook"))
					{
						fb.add(t);
					}
					else if(entry.getValue().contains("twitter"))
					{
						tw.add(t);
					}
					else if(entry.getValue().contains("youtube"))
					{
						yt.add(t);
					}
					else if(entry.getValue().contains("linkedin"))
					{
						in.add(t);
					}
					else if(entry.getValue().contains("tumblr"))
					{
						tmb.add(t);
					}
					else
					{
						mid.add(t);
					}
					
				}
				
				ArrayList<ArrayList<String>> entities = bg.get_bn_entity(startdate, enddate,userName,tracker);
				for (int j=0;j<entities.size();j++)
				{
					ArrayList<String> t = new ArrayList<String>();
					int y = x++;
					t.add(Integer.toString(y));  //media id
					t.add(entities.get(j).get(0));  //blogsite id
					t.add(entities.get(j).get(1));  //entity
					t.add("arrows:'from'");
					en.add(t);
				}
			
				
				
				//creating nodes
				ArrayList<ArrayList<String>> nodes = new ArrayList<ArrayList<String>>();
				for (Map.Entry<Integer,String> entry : sn.entrySet())
				{
					ArrayList<String> t = new ArrayList<String>();
					t.add(Integer.toString(entry.getKey()));
					t.add(entry.getValue());
					t.add("diamonds");
					nodes.add(t);
				}
				
				for( int i=0;i<bid.size();i++)
				{
					ArrayList<String> t = new ArrayList<String>();
					t.add(bid.get(i).get(0));
					t.add(bid.get(i).get(2));
					t.add("icons");
					nodes.add(t);
				}
				for( int i=0;i<fb.size();i++)
				{
					ArrayList<String> t = new ArrayList<String>();
					t.add(fb.get(i).get(0));
					t.add(fb.get(i).get(2));
					t.add("facebook");
					nodes.add(t);
				}
				for( int i=0;i<tw.size();i++)
				{
					ArrayList<String> t = new ArrayList<String>();
					t.add(tw.get(i).get(0));
					t.add(tw.get(i).get(2));
					t.add("twitter");
					nodes.add(t);
				}
				for( int i=0;i<yt.size();i++)
				{
					ArrayList<String> t = new ArrayList<String>();
					t.add(yt.get(i).get(0));
					t.add(yt.get(i).get(2));
					t.add("youtube");
					nodes.add(t);
				}
				for( int i=0;i<in.size();i++)
				{
					ArrayList<String> t = new ArrayList<String>();
					t.add(in.get(i).get(0));
					t.add(in.get(i).get(2));
					t.add("linkedin");
					nodes.add(t);
				}
				for( int i=0;i<tmb.size();i++)
				{ 
					ArrayList<String> t = new ArrayList<String>();
					t.add(tmb.get(i).get(0));
					t.add(tmb.get(i).get(2));
					t.add("tumblr");
					nodes.add(t);
				}
				for( int i=0;i<en.size();i++)  //entity code for creating node
				{
					ArrayList<String> t = new ArrayList<String>();
					t.add(en.get(i).get(0));
					t.add(en.get(i).get(2));
					t.add("circle");
					nodes.add(t);
				}
				//entity code end
				for( int i=0;i<mid.size();i++)
				{
					ArrayList<String> t = new ArrayList<String>();
					t.add(mid.get(i).get(0));
					t.add(mid.get(i).get(2));
					t.add("mints");
					nodes.add(t);
				}
				
				
				//creating links or edges
				ArrayList<ArrayList<String>> edges = new ArrayList<ArrayList<String>>();
				for( int i=0;i<bid.size();i++)
				{
					ArrayList<String> t = new ArrayList<String>();
					t.add(bid.get(i).get(0));
					t.add(bid.get(i).get(1));
					t.add(bid.get(i).get(3));
					edges.add(t);
				}
				for( int i=0;i<fb.size();i++)
				{
					ArrayList<String> t = new ArrayList<String>();
					t.add(fb.get(i).get(0));
					t.add(fb.get(i).get(1));
					t.add(fb.get(i).get(1));
					edges.add(t);
				}
				for( int i=0;i<tw.size();i++)
				{
					ArrayList<String> t = new ArrayList<String>();
					t.add(tw.get(i).get(0));
					t.add(tw.get(i).get(1));
					t.add(tw.get(i).get(3));
					edges.add(t);
				}
				for( int i=0;i<yt.size();i++)
				{
					ArrayList<String> t = new ArrayList<String>();
					t.add(yt.get(i).get(0));
					t.add(yt.get(i).get(1));
					t.add(yt.get(i).get(3));
					edges.add(t);
				}
				for( int i=0;i<in.size();i++)
				{
					ArrayList<String> t = new ArrayList<String>();
					t.add(in.get(i).get(0));
					t.add(in.get(i).get(1));
					t.add(in.get(i).get(3));
					edges.add(t);
				}
				for( int i=0;i<tmb.size();i++)
				{
					ArrayList<String> t = new ArrayList<String>();
					t.add(tmb.get(i).get(0));
					t.add(tmb.get(i).get(1));
					t.add(tmb.get(i).get(3));
					edges.add(t);
				}
				for( int i=0;i<en.size();i++)  //entity code for creating edges
				{
					ArrayList<String> t = new ArrayList<String>();
					t.add(en.get(i).get(0));
					t.add(en.get(i).get(1));
					edges.add(t);
				}							//entity code end
				
				for( int i=0;i<mid.size();i++)
				{
					ArrayList<String> t = new ArrayList<String>();
					t.add(mid.get(i).get(0));
					t.add(mid.get(i).get(1));
					t.add(mid.get(i).get(3));
					edges.add(t);
				}
				
				session.setAttribute("nodes", nodes);
				session.setAttribute("edges", edges);
				System.out.println("print nodes"+nodes);
				System.out.println("print edges"+edges);
			}
				
				catch(Exception ex)
				{
					
				}
			}
			// end of code	
				

				
				
			
			
			
			
		}
		
		
		response.setContentType("text/html;");
		response.sendRedirect("blog_network.jsp");
		
	}

}
