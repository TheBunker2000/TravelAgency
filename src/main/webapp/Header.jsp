<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="loggedUser" scope="session" class="model.bean.UserBean" />
<%@ page import="model.bean.*"%>

<div class="m-0">
	<nav class="navbar navbar-expand-lg navbar-light bg-light">

		<div class="container-fluid mx-2">

			
			<a class="navbar-brand" href="HomepageServlet">
			<img src="asset/images/logoTravel.jpg" alt="non disponibile">
			</a>
			
			<button class="navbar-toggler " type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarCollapse"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>



			<div class="collapse navbar-collapse px-5" id="navbarCollapse">

				<ul class="navbar-nav">

					<li><a class="nav-link active" href="HomepageServlet"
						target="_self">
							<button type="button" class="btn btn-outline-secondary ">Home</button>
					</a></li>
					<li><a class="nav-link active" href="PackagesListServlet"
						target="_self">
							<button type="button" class="btn btn-outline-secondary">Pacchetti</button>
					</a></li>

				</ul>



				<ul class="navbar-nav mx-auto">
				<li>
				<form class="d-flex" role="search" method="get"
					action="PackagesListServlet">
					<input class="form-control me-2" type="search"
						placeholder="Dove vuoi andare?" aria-label="Search" name="Nome">
					<button type="submit" class="btn btn-outline-secondary">Cerca</button>
				</form>
				</li>
				</ul>
				<ul class="navbar-nav ms-auto">
					<li class="nav-item dropdown">
					
						<!-- Icona Utente --> <a class="nav-link dropdown-toggle" href="#"
						id="navbarDropdown" role="button" data-bs-toggle="dropdown"
						aria-expanded="false">
						<svg xmlns="http://www.w3.org/2000/svg"
								width="22" height="22" fill="currentColor"
								class="bi bi-person-lines-fill" viewBox="0 0 16 16">
						<path
									d="M6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm-5 6s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zM11 3.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5zm.5 2.5a.5.5 0 0 0 0 1h4a.5.5 0 0 0 0-1h-4zm2 3a.5.5 0 0 0 0 1h2a.5.5 0 0 0 0-1h-2zm0 3a.5.5 0 0 0 0 1h2a.5.5 0 0 0 0-1h-2z" />
					</svg>
					<p class="d-lg-none d-inline">Area utente</p> 
					</a> <%
 if (loggedUser.getUsername() == null) {
 %>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="LoginPage.jsp">Accesso</a></li>
							<li><a class="dropdown-item" href="SignUpPage.jsp">Registrati</a></li>
						</ul> <%
 } else if (loggedUser.getTipo() == 1) {
 %>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="NewPackagePage.jsp">Crea
									nuovo pacchetto</a></li>
							<li><a class="dropdown-item" href="PackagesListServlet">Modifica
									pacchetto</a></li>
							<li><a class="dropdown-item" href="OrderHistoryAdminServlet">Consulta
									gli ordini</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="LogoutServlet">Disconnettiti</a></li>
						</ul> <%
 } else {
 %>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="OrderHistory.jsp">Storico
									ordini</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="LogoutServlet">Disconnettiti</a></li>
						</ul> <%
 }
 %>
					</li>
					

					<!-- Icona Cart -->

					<li class="nav-item"><a class="nav-link"
						href="ShoppingCart.jsp"> <%
 CartBean cartHeader = (CartBean) session.getAttribute("cart");
 if (cartHeader == null || cartHeader.getPackages().size() < 1) {
 %> <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
								fill="currentColor" class="bi bi-cart" viewBox="0 0 16 16">
  										<path
									d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l1.313 7h8.17l1.313-7H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z" />
									  </svg> <%
 } else {
 %> <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
								fill="currentColor" class="bi bi-cart-fill" viewBox="0 0 16 16">
  										<path
									d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z" />
									</svg> <%
 }
 %>
				<p class="d-lg-none d-inline">Carrello</p>	</a></li>
				</ul>
			</div>
		</div>
	</nav>

</div>