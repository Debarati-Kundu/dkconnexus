<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
	<head>
	<title>Welcome to Connexus!</title>
<!--  	<link type="text/css" rel="stylesheet" href="/stylesheets/main.css">  -->
	</head>
  <body>
  
  
<%
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    if (user != null) {
      pageContext.setAttribute("user", user);
%>
<!-- <h1> Connex.us</h1> -->
<link type="text/css" rel="stylesheet" href="/stylesheets/main1.css">
<h3 style="text-align: center;">Hello, ${fn:escapeXml(user.nickname)}! Thanks for using Connexus </h3>
<p style="position: absolute; top:0px; left:1200px;"><a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">Sign out</a></p>

<div id="nav">
	<ul style="text-align: center;">
		<li class="first active"> <a href="dkconnexus.jsp">Manage</a> </li>
		<li> <a href="create.jsp">Create</a> </li>
		<li> <a href="view_stream.jsp">View</a> </li>
		<li> <a href="search.jsp">Search</a> </li>
		<li> <a href="trending.jsp">Trending</a>
		</li> <li class="last"> <a href="social.jsp">Social</a></li>
	</ul>
	<br class="clear" />
</div>
<h4 style="text-align: center;">Streams I own </h4>
<table align="center">
  <tr>
    <th color="#FFFFFF">Name</th>
    <th color="#FFFFFF">Last New Picture</th>
    <th color="#FFFFFF">Number of Pictures</th>
    <th color="#FFFFFF">Delete</th>
  </tr>
  <tr>
    <td>Stream 1</td>
    <td>Date 1</td>
    <td>Some text</td>
    <td>
    	<form>
			<input type="checkbox">
		</form>
	</td> 
  </tr>
  <tr>
    <td>Stream 2</td>
    <td>Date 2</td>
    <td>Some other text</td>
    <td>
    	<form>
			<input type="checkbox">
		</form>
	</td> 
  </tr>
</table>
<div class="center">
	<form name="input" action="html_form_action.asp" method="get" align="center">
		<input type="submit" value="Delete selected items">
	</form>
</div>

<br></br>
<h4 style="text-align: center;">Streams I subscribe to </h4>
<table align="center">
  <tr>
    <th color="#FFFFFF">Name</th>
    <th color="#FFFFFF">Last New Picture</th>
    <th color="#FFFFFF">Number of Pictures</th>
    <th color="#FFFFFF">Views</th>
    <th color="#FFFFFF">Unsubscribe</th>
  </tr>
  <tr>
    <td>Stream 1</td>
    <td>Date 1</td>
    <td>Some text</td>
    <td>Some number</td>
    <td>
    	<form>
			<input type="checkbox">
		</form>
	</td> 
  </tr>
  <tr>
    <td>Stream 2</td>
    <td>Date 2</td>
    <td>Some other text</td>
    <td>Some other number</td>
    <td>
    	<form>
			<input type="checkbox">
		</form>
	</td> 
  </tr>
</table>
<div class="center">
	<form name="input" action="html_form_action.asp" method="get" align="center">
		<input type="submit" value="Unsubscribe checked streams">
	</form>
</div>



<%
    } else {
%>
<link type="text/css" rel="stylesheet" href="/stylesheets/main.css">
<h1 style="text-align: center;">Welcome to Connexus!</h1>
<h2 style="text-align: center;">Share the world</h2>
<p style="text-align: center; " ref="/stylesheets/main.css"enter;">Please
<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
with your Google credentials.</p>
<%
    }
%>
  </body>
</html>