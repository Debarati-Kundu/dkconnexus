<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>

<%@ page import="dkconnexus.Stream" %>
<%@ page import="dkconnexus.OfyService" %>
<%@ page import="dkconnexus.ConnexusImage" %>
<%@ page import="java.util.ListIterator" %>
<%@ page import="java.util.Collections" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>

<html>
	<head>
	<title>View individual stream</title>
	<link type="text/css" rel="stylesheet" href="/stylesheets/main1.css"> 
	</head>
	
  <body>
  	<h1 style="text-align: center;">Connex.us</h1>
  	<div id="nav">
	<ul style="text-align: center;">
		<li> <a href="dkconnexus.jsp">Manage</a> </li>
		<li> <a href="create.jsp">Create</a> </li>
		<li> <a href="view_stream.jsp">View</a> </li>
		<li> <a href="search.jsp">Search</a> </li>
		<li> <a href="trending.jsp">Trending</a>
		</li> <li class="last"> <a href="social.jsp">Social</a></li>
	</ul>
	<br class="clear" />
</div>

<%
		BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
		Long streamId = new Long(request.getParameter("streamId"));
		String streamName = request.getParameter("streamName");
%>		
		<h2><%=streamName%></h2>
<%
//		out.println(streamName);

		List<Stream> s = OfyService.ofy().load().type(Stream.class).list();
		for ( Stream str : s ) {
			if ( str.id.equals(streamId) ) {
				str.views++;
				str.lastViewed = new Date();
				OfyService.ofy().save().entity(str).now();
			}
//			System.out.println("numpics " + str.numPics);
		}
		
		List<ConnexusImage> images = OfyService.ofy().load().type(ConnexusImage.class).list();
		Collections.sort(images);
		for ( ConnexusImage img : images ) {
		    if ( img.streamId.equals(streamId) ) {
     		  out.println("<img src=\"" + img.bkUrl + "\">"); // better to not use println for html output, use templating instead
     		}
     	 }
%>

<!-- APT: note how we are adding additional parameters when we create the uploadurl - this way blobstore service
     can pass them on to the upload servlet, so upload knows which stream the image blob corresponds to -->
<h2 style="text-align:left" >Add an image</h2>
	<form action="<%= blobstoreService.createUploadUrl("/upload?streamId=" 
			+ streamId + "&streamName=" + streamName) %>" 
			method = "post" enctype="multipart/form-data">
	     <input type="file" name="myFile"><br> <input type="submit" value="Submit">
   </form>
   <br>

 <form style = "text-align:center" action="add_subscriber.jsp?streamId=<%= streamId %>&streamName=<%= streamName %>"
 method="post">
		<input type="submit" value="Subscribe">
   </form>
  </body>
  </html>
