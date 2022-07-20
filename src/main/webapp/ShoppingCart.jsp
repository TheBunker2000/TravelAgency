<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Carrello</title>

	<!-- Risorse per il bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

<style type="text/css">
@media (min-width: 1025px) {
.h-custom {
height: 100vh !important;
}
}

.card-registration .select-input.form-control[readonly]:not([disabled]) {
font-size: 1rem;
line-height: 2.15;
padding-left: .75em;
padding-right: .75em;
}

.card-registration .select-arrow {
top: 13px;
}

.bg-grey {
background-color: #eae8e8;
}

@media (min-width: 992px) {
.card-registration-2 .bg-grey {
border-top-right-radius: 16px;
border-bottom-right-radius: 16px;
}
}

@media (max-width: 991px) {
.card-registration-2 .bg-grey {
border-bottom-left-radius: 16px;
border-bottom-right-radius: 16px;
}
}
</style>
</head>
<body class="d-flex flex-column h-100 min-vh-100">
<%@ include file="Header.jsp"%>
<%@ include file="ConfirmationModal.jsp" %>

<jsp:useBean id="cart" class="model.bean.CartBean" scope="session"/>

<section class="flex-shrink-0 flex-grow-1" style="background-color: #eee;">
  <div class="container h-100 my-4">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-12">
        <div class="card card-registration card-registration-2" style="border-radius: 15px;">
          <div class="card-body p-0">
            <div class="row g-0">
              <div class="col-lg-8">
                <div class="p-5">
                  <div class="d-flex justify-content-around tween align-items-center mb-5">
                    <h1 class="fw-bold mb-0 text-black">Carrello</h1>
                    <h5 class="mb-0 text-muted"><%=cart.getPackages().size()%> pacchetti</h5>
                     
                     <% if(cart.getPackages().size()!=0){ %>         
                    <h6 class="mb-0 text-muted">Svuota carrello 
                    <a href="DeleteCartItemServlet?codicePacchetto=-1" class="btn btn-danger">
                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
  					<path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
  					<path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
					</svg>
					</a> 
					</h6>
					<% } %>
           
                  </div>
               
				<!-- ITEM HTML -->
				<% if(cart.getPackages().size()!=0){
					for(CartItemBean c : cart.getPackages()) { %>                  
                  <hr class="my-4">
					
                  <div class="row mb-4 d-flex justify-content-between align-items-center">
                    <div class="col-md-2 col-lg-2 col-xl-2">
                      <img
                        src="asset/images/<%=c.getCittàPacchetto().toLowerCase()%>01.jpg"
                        class="img-fluid rounded-3" alt="immagine pacchetto">
                    </div>
                    <div class="col-md-3 col-lg-3 col-xl-3">
                      <h6 class="text-muted"><%= c.getCittàPacchetto() %></h6>
                      <h6 class="text-black mb-0"><%= c.getNomePacchetto() %></h6>
                    </div>
                    <div class="col d-flex">
		              	Data partenza: <%= c.getDataPartenza().format(DateTimeFormatter.ofPattern("dd/MM/yyyy"))%>
		            </div>
                    <div class="col-md-3 col-lg-2 col-xl-2 offset-lg-1">
                      <h6 class="mb-0">€ <%= c.getTotale() %></h6>
                    </div>
                    <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                    <form id="removeItemForm" action="DeleteCartItemServlet" method="get">
                    <input type="hidden" name="codicePacchetto" value="<%=c.getCodicePacchetto()%>">
                    <button class="btn btn-danger" type="submit" id="removeFromCart">
                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
  						<path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
  						<path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
					</svg>
					</button>
					</form>
					
                      <a href="#!" class="text-muted"><i class="fas fa-times"></i></a>
                    </div>
                  </div>
                  
					<% }
					} 
					%>
					


                  <hr class="my-4">
					
                  <div class="pt-5">
                    <h6 class="mb-0"><a href="HomepageServlet" class="text-body" style="text-decoration: none ; font-weight: bold">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8z"/>
</svg>Torna alla home</a></h6>
                  </div>
                </div>
              </div>
              <div class="col-lg-4 bg-grey">
                <div class="p-5">
                  <h3 class="fw-bold mb-5 mt-2 pt-1">Riepilogo</h3>
                  <hr class="my-4">

					<div class="d-flex flex-column mb-4">
                  <%for(CartItemBean cartItem : cart.getPackages()){
                  %>
                  <div class="d-inline-flex justify-content-between">
                    <div><h5><%=cartItem.getNomePacchetto().toUpperCase()%> x<%=cartItem.getNumPersone()%></h5></div>
                    <div><h5>€<%=cartItem.getTotale()%></h5></div>
                   </div>
                    <%  
                  }
                  %>
                  </div>
                  <hr class="my-4">
                  <div class="d-flex justify-content-between mb-5">
                    <h5 class="text-uppercase">Costo totale</h5>
                    <h5>€<%=cart.getTotalCost()%></h5>
                  </div>
						
					<%if(loggedUser.getUsername()!=null){
						if(cart.getPackages().size()>0){ %>
							<a href="SendOrderServlet" class="btn btn-dark btn-block btn-lg"  data-mdb-ripple-color="dark">Acquista</a>
					<% } %>
					
					<% }else{ %>
						<a href="LoginPage.jsp" class="btn btn-dark btn-block btn-lg"  data-mdb-ripple-color="dark">Accedi</a>
					<% } %>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<%@ include file="Footer.jsp"%>
</body>
</html>