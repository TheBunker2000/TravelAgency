<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ page import="model.dao.*"%>
<%@ page import="java.util.Collection"%>



<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Riepilogo ordini</title>

	<!-- Risorse per il Bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
	
	<!-- Risorse per il JQuery -->
	<script src="${pageContext.request.contextPath}/libs/jquery.min.js"></script>
	
	<style type="text/css">
		@import url('https://fonts.googleapis.com/css?family=Assistant');
body {
  background: #eee;
}

thead {
  background: #dddcdc;
}
.badge-success {
    color: #fff;
    background-color: #28a745;
}
.badge {
    display: inline-block;
    padding: 0.25em 0.4em;
    font-size: 75%;
    font-weight: 700;
    line-height: 1;
    text-align: center;
    white-space: nowrap;
    vertical-align: baseline;
    border-radius: 0.25rem;
    transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}
</style>

<script>
	$(document).ready(function() {
	    $(".clickable-row").click(function() {
	        window.location = $(this).data("href");
	    });
	});
</script>	

</head>
<body class="d-flex flex-column h-100 min-vh-100">
	<%@ include file="Header.jsp"%>
	
	<%
	Collection<OrdineBean> ordini;
 	if( loggedUser == null || loggedUser.getTipo()==1){
 		response.sendRedirect(request.getContextPath() + "/LoginPage.jsp");
 		return;
 	}else{
 		ordini = (new OrdineDAO()).doRetrieveAllOrdersFromUser(loggedUser.getUsername());	
 	}
	%>
	 <%if(ordini.size()>0){ %>
		<div class="container mt-5">
                    <div class="d-flex justify-content-center">
                        <table class="table table-hover">
                            <thead>
                                <tr>                                 
                                    <th scope="col">Numero ordine</th>
                                    <th scope="col">stato</th>
                                    <th scope="col">Totale</th>
                                    <th scope="col">Data ordine	</th>                           
                                </tr>
                            </thead>
                            <tbody>
                            <% for(OrdineBean ordine : ordini){ %>
                                <tr class="clickable-row" data-href="<%=request.getContextPath()%>/OrderDetailServlet?Codice=<%=ordine.getCodice()%>">                                   
                                    <td>#SO-<%=ordine.getCodice()%></td>
                                    <td><span class="badge badge-success">Completato</span></td>
                                    <td>€<%=ordine.getCostoTotale()%></td>
                                    <td><%=ordine.getDataPrenotazione()%></td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
    </div>
    
	<%}else{ %>
	
	<h3 style="text-align:center">Non c'è ancora niente qui, <a href="HomepageServlet">effettua prima un ordine!</a></h3>
	
	<% } %>
	
	
	
	<%@ include file="Footer.jsp"%>
</body>
</html>