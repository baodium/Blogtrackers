<%@page import="java.util.*"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>



<%
   File file ;
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
   String path=application.getRealPath("/").replace('\\', '/')+"profile_images/";
   path = path.replace("build/", "");
   String filePath = path;//"c:/apache-tomcat/";
 

   String contentType = request.getContentType();

   if ((contentType.indexOf("multipart/form-data") >= 0)) {

      DiskFileItemFactory factory = new DiskFileItemFactory();
      factory.setSizeThreshold(maxMemSize);
      factory.setRepository(new File("c:\\temp"));
      ServletFileUpload upload = new ServletFileUpload(factory);
      
     
      upload.setSizeMax( maxFileSize );
     // String t_number=request.getParameter("t_number_");
      try{ 
         List fileItems = upload.parseRequest(request);
         Iterator i = fileItems.iterator();
          String username = session.getAttribute("username").toString();
          String file_name= username+".jpg";
         while ( i.hasNext () ) 
         {
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () )  {
                String fieldName = fi.getFieldName();
                String fileName = fi.getName();
                boolean isInMemory = fi.isInMemory();
                long sizeInBytes = fi.getSize();
               // t_number=t_number+".jpg";

                file = new File( filePath + username+".jpg") ;
                fi.write( file ) ;
                out.println("Uploaded Filename: " + filePath + file_name + "<br>");
                
           }
         }
         
         response.sendRedirect("profile.jsp");
         
      }catch(Exception ex) {
         out.println("<p>No file uploaded</p>"); 
      }
   }else{
       out.println("<p>No file uploaded</p>"); 
    response.sendRedirect("index.jsp"); 
   }

%>
