<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Errore interno del server</title>

	<!-- Risorse per il bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
	
</head>
<body class="d-flex flex-column h-100 min-vh-100">
<%@ include file="Header.jsp"%>

<h1 style = " text-align : center">Ci scusiamo per l'inconveniente, c'è stato un errore, <a href="HomepageServlet">torna alla homepage</a></h1>

<%@ include file="Footer.jsp"%>
</body>
</html>