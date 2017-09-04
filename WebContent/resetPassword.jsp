<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
	
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Email Client</title>
</head>
<body>
<form method="POST" action="Mailer">
<h1>Send Email</h1>
<p>Email:<input type="text" name="email" size="75" ></p>
<p>Subject:<input type="text" name="subject" size="75" ></p>
<p>Message: <textarea name="message" cols="75" rows="6"></textarea></p>

<input type="submit" value="Send">
</form>
</body>
</html>