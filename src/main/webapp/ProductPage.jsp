<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean class="model.bean.TravelPackageBean" id="travelPackage" scope="request"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Prodotto</title>

	<!-- Risorse per il bootstrap -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>

	<!-- Risorse per il JQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />


</head>
<body class="d-flex flex-column h-100 min-vh-100">
	<%@ include file="Header.jsp"%>

	<section class="flex-shrink-0" style="background-color: #eee;">
		<div class="container h-100 my-4">
			<div
				class="row d-flex justify-content-center align-items-center h-100">
				<div class="col-lg-12 col-xl-11">
					<div class="card text-black" style="border-radius: 25px;">
						<div class="card-body p-md-5">
							<div class="row justify-content-center">
								<!-- Corpo della card -->
								<div class="col-7">
									<!-- Lato immagine -->
									<div class="row" style="gap: 10px" id="package-gallery">
											<img class="img-fluid"
											src="https://infrastrutture.tk:12000/images/<%=travelPackage.getNome()%>01.jpg"/> 
										<div class="d-flex justify-content-between" style="gap: 10px">
											<div class="col">
												<img class="img-fluid"
													src="https://infrastrutture.tk:12000/images/<%=travelPackage.getNome()%>02.jpg" />
											</div>
											<div class="col">
												<img class="img-fluid"
													src="https://infrastrutture.tk:12000/images/<%=travelPackage.getNome()%>03.jpg" />
											</div>
											<div class="col">
												<img class="img-fluid"
													src="https://infrastrutture.tk:12000/images/<%=travelPackage.getNome()%>04.jpg" />
											</div>
										</div>
									</div>

								</div>
								<div class="col">
									<!-- Lato testo -->
									<div class="row">
										<h1><%=travelPackage.getNome()%></h1>
									</div>
									<div class="row">
										<p><%=travelPackage.getDescrizione()%></p>
									</div>
									<div class="row">
										<div class="d-inline-flex" style="gap: 10px;">
										<span class="material-symbols-outlined">airplane_ticket</span>
										<b><%=travelPackage.isVoloIncluso() ? "Volo incluso" : "Volo non incluso"%></b></div>
									</div>
									<div class="row">
										<div class="d-inline-flex" style="gap: 10px;">
										<span class="material-symbols-outlined">restaurant_menu</span>
										<b><%=travelPackage.getPensione()%></b>
										</div>
									</div>
								</div>

								<div class="row my-3">
									<div class="accordion" id="dettagliViaggio">
										<div class="accordion-item">
											<h2 class="accordion-header" id="headingOne">
												<button class="accordion-button" type="button"
													data-bs-toggle="collapse" data-bs-target="#collapseOne"
													aria-expanded="true" aria-controls="collapseOne">
													Dettagli Volo</button>
											</h2>
											<div id="collapseOne"
												class="accordion-collapse collapse show"
												aria-labelledby="headingOne"
												data-bs-parent="#accordionExample">
												<div class="accordion-body">
													<%= travelPackage.isVoloIncluso() ? travelPackage.getDettagliVolo() : "Dettagli volo non disponibili" %>
												</div>
											</div>
										</div>
										<div class="accordion-item">
											<h2 class="accordion-header" id="headingTwo">
												<button class="accordion-button collapsed" type="button"
													data-bs-toggle="collapse" data-bs-target="#collapseTwo"
													aria-expanded="false" aria-controls="collapseTwo">
													Dettagli Pernottamento</button>
											</h2>
											<div id="collapseTwo" class="accordion-collapse collapse"
												aria-labelledby="headingTwo"
												data-bs-parent="#accordionExample">
												<div class="accordion-body">
													<%= travelPackage.getDettagliPernottamento() %>
												</div>
											</div>
										</div>

									</div>


								</div>
							</div>

							<div class="row my-3 mx-2">
							<% Boolean isOrdine = (Boolean) request.getAttribute("isOrdine");
								if(!isOrdine){
									if(loggedUser.getUsername() == null || loggedUser.getTipo()==0){ %>
								<form class="row justify-content-between" action="AddToCart"
									method="post">
									<div class="col-6">
										<label for="NumeroPersone" class="sr-only">Numero di Persone</label>
											 <input type="number" id="npersone" name="NumeroPersone" onchange="onChangeNumeroPersone()"
											placeholder="1" min="1" max="15" class="form-control my-2" required> 
											<label for="DataPartenza" class="sr-only">Data di Partenza</label> 
											<input type="date" name="DataPartenza" class="form-control my-2" required> 
											<input type="hidden" name="CodicePacchetto" value="<%=travelPackage.getCodice()%>">
									</div>
									<div class="col-6">

										<div class="row">
											<h2 class="text-end">Costo totale</h2>
											<h5 class="text-end" id="totale">0,00</h5>
										</div>
										<div class="row float-end mt-4">
										
											<button type="submit" class="btn btn-primary btn-md" style="width: fit-content;">
											<div class="d-flex align-items-center">
												<span class="material-symbols-outlined">shopping_cart</span>
										Aggiungi al carrello
												</div>
											</button>
											
										</div>
									

									</div>
								</form>
								<% }
								} %>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<%@ include file="Footer.jsp"%>
	<script>
		var totale = document.getElementById("totale");

		var costo = <%=travelPackage.getCosto()%>;
		
		totale.innerText = "€" + costo.toLocaleString(undefined, {
			minimumFractionDigits : 2
		});

		var onChangeNumeroPersone = function() {
			var nPersone = document.getElementById("npersone").value;
			var costoTotale = costo * nPersone;
			totale.innerText = "€" + costoTotale.toLocaleString(undefined, {
				minimumFractionDigits : 2
			});
		}
	</script>
</body>
</html>