<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="packageList" type="java.util.ArrayList<model.bean.TravelPackageBean>" scope="request" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pacchetti</title>

	<!-- Risorse per il bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
	
	<!-- Risorse per il JQuery -->
	<script src="${pageContext.request.contextPath}/libs/jquery.min.js"></script>

	<!-- Risorse per il Modal -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="asset/CSS/QuestionModalStyle.css">
	<script src= "https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	

</head>
<body class="d-flex flex-column min-vh-100">

<%@ include file="Header.jsp"%>

<section class="flex-shrink-0 flex-grow-1">
<div class="my-4">
<div class="row row-cols-1 row-cols-md-3 g-4 mx-2">

<% if (packageList.isEmpty()){ %>
	<p> Nessun pacchetto trovato</p>
<% } for(TravelPackageBean tp : packageList){ %>
	<div class="col">
    <div class="card">
      <img src="https://infrastrutture.tk:12000/images/<%=tp.getNome()%>01.jpg" class="card-img-top" alt="Immagine non disponibile">
      <div class="card-body">
        <h5 class="card-title"><%=tp.getNome() %></h5>
           <p class="card-text" ><%= (tp.getDescrizione().length() > 401 ?  tp.getDescrizione().substring(0,400) : tp.getDescrizione()) + "..." %></p>
      <!-- >
      <div class="d-flex justify-content-center"> -->
      <% 
     	 if(loggedUser == null || loggedUser.getTipo()==0){
      %>
      <a href="ProductPageServlet?Codice=<%=tp.getCodice()%>" class="btn btn-primary" role="button">Più informazioni</a>
      
      <%
		}
     	 else{ %>
     	
      	<form action="DeletePackageServlet" method="get"><input type="hidden" name="Codice" value="<%=tp.getCodice()%>">
      	<a href="ProductPageServlet?Codice=<%=tp.getCodice()%>" class="btn btn-primary" role="button">Più informazioni</a>
      	<a href="ModifyPackageServlet?Codice=<%=tp.getCodice()%>" class="btn btn-secondary" role="button">Modifica</a>
      	
	      	<div id="deleteModal-<%=tp.getCodice()%>" class="modal fade">
		<div class="modal-dialog modal-question">
			<div class="modal-content">
				<div class="modal-header flex-column">
					<div class="icon-box">
						<i class="material-icons">&#xE5CD;</i>
					</div>						
					<h4 class="modal-title w-100">Sei sicuro?</h4>
				</div>
				<div class="modal-body">
					<p id="question-modal-text">Vuoi veramente eliminare il pacchetto <%=tp.getNome()%>? L'operazione non può essere annullata.</p>
				</div>
				<div class="modal-footer justify-content-center">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annulla</button>
					<button type="submit" class="btn btn-danger" id="question-modal-submit">Elimina</button>
				</div>
			</div>
		</div>
	</div> 
          
      	<button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal-<%=tp.getCodice()%>" role="button">Elimina</button>
      	</form>
      	
      <%
      } 
      %>
      </div>
    </div>
  </div>
	
<% 	
}
%>
</div>
</div>
</section>

<%@ include file="Footer.jsp"%>
</body>
</html>