<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<jsp:useBean id="ordini" type="java.util.ArrayList<model.bean.OrdineBean>" scope="request"/>  
<%@ page import="java.time.*"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
	
	$(document).ready(function() {
	    $("#dateAnchor").click(function() {
	    	if($("#UsernameForm").is(":visible")){
	    		$("#UsernameForm").hide();
	    	}
	        $("#DateForm").show();
	    });
	});
	
	$(document).ready(function() {
	    $("#usernameAnchor").click(function() {
	    	if($("#DateForm").is(":visible")){
	    		$("#DateForm").hide();
	    	}
	        $("#UsernameForm").show();
	    });
	});
</script>
		
</head>
<body class="d-flex flex-column h-100 min-vh-100">
	<%@ include file="Header.jsp"%>
	
	<%if( loggedUser == null || loggedUser.getTipo()==0){
 		response.sendRedirect(request.getContextPath() + "/LoginPage.jsp");
 		return;
 	} %>
	
	 <%if(ordini.size()>0){ %>
		<div class="container mt-5">
       
        <div class="d-flex justify-content-center">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th scope="col">Numero ordine</th>
                                    <th scope="col">Cliente</th>
                                    <th scope="col">stato</th>
                                    <th scope="col">Totale</th>
                                    <th scope="col">Data ordine	</th>
                                </tr>
                            </thead>
                            <tbody>
                            <% for(OrdineBean ordine : ordini){ %>
                                <tr class="clickable-row" data-href="<%=request.getContextPath()%>/OrderDetailServlet?Codice=<%=ordine.getCodice()%>">                                  
                                    <td>#SO-<%=ordine.getCodice()%></td>
                                    <td><%=ordine.getCliente()%></td>
                                    <td><span class="badge badge-success">Completato</span></td>
                                    <td>€<%=ordine.getCostoTotale()%></td>
                                    <td><%=ordine.getDataPrenotazione()%></td>                                    
                                </tr>
                                <% } %>
                            </tbody>
                        </table>                
        </div>
        <!-- div flexbox form -->
        <div class="d-flex flex-row">
	        <div class="dropdown p-2">
				  <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
				    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-filter" viewBox="0 0 16 16">
	  				<path d="M6 10.5a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1-.5-.5zm-2-3a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zm-2-3a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5z"/>
					</svg> Filtra per
				  </a>
				  <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
				    <li><a class="dropdown-item" id="dateAnchor" href="#">Data</a></li>
				    <li><a class="dropdown-item" id="usernameAnchor" href="#">Username</a></li>
				    <li><hr class="dropdown-divider"></li>
				    <li><a class="dropdown-item" href="OrderHistoryAdminServlet">Azzera i filtri</a></li>
				    
				  </ul>
				</div>
				
				<div class="p-2">
				<form id="DateForm" action="OrderHistoryAdminServlet" method="get" Style="Display: none">
					<label for="DataInizio" class="sr-only">Da:</label> 
					<input type="date" name="DataInizio" class="form-control my-2" required>
					<label for="DataFine" class="sr-only">A:</label> 
					<input type="date" name="DataFine" class="form-control my-2" required>
					<button type="submit" class="btn btn-primary">Ricerca</button> 
				</form>
				</div>
				<div class="p-2">
				<form id="UsernameForm" action="OrderHistoryAdminServlet" method="get" Style="Display: none">
					<label for="DataInizio" class="sr-only">Ricerca per username:</label> 
					<input type="text" name="username" class="form-control my-2" required>
					<button type="submit" class="btn btn-primary">Ricerca</button>
				</form>
				</div>
				
     </div>
    </div>
    
	<%}else{ %>
	
	<h3 style="text-align:center"> Nessun utente ha ancora effettuato un ordine</h3>
	
	<% } %>
	
	
	
	
	<%@ include file="Footer.jsp"%>
</body>
</html>