<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.dao.*" %>
<jsp:useBean id="ordine" class="model.bean.OrdineBean" scope="request" />
<jsp:useBean id="comprendeCollection" type="java.util.Collection<model.bean.ComprendeBean>" scope="request" />
<%
DateTimeFormatter formatter = DateTimeFormatter.ISO_DATE_TIME;

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dettagli ordine</title>

<!-- risorse per il bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Risorse per il JQuery -->
<script src="${pageContext.request.contextPath}/libs/jquery.min.js"></script>



<style type="text/css">
@media ( min-width : 1025px) {
	.h-custom {
		height: 100vh !important;
	}
}

.card-registration .select-input.form-control[readonly]:not([disabled])
	{
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

@media ( min-width : 992px) {
	.card-registration-2 .bg-grey {
		border-top-right-radius: 16px;
		border-bottom-right-radius: 16px;
	}
}

@media ( max-width : 991px) {
	.card-registration-2 .bg-grey {
		border-bottom-left-radius: 16px;
		border-bottom-right-radius: 16px;
	}
}

.clickable-package {
	-webkit-transition: background 1s;
	-moz-transition: background 1s;
	-o-transition: background 1s;
	transition: background 1s
}

.clickable-package:hover {
	background: #eee
}
</style>

<script>
	$(document).ready(
			function() {
				$(".clickable-package").click(
						function() {

							window.location.href = window.location.origin
									+ $(this).data("href");

						});
			});
</script>
</head>
<body class="d-flex flex-column h-100 min-vh-100">
	<%@ include file="Header.jsp"%>

	<section class="h-100 h-custom" style="background-color: #eee;">
		<div class="container py-5 h-100">
			<div
				class="row d-flex justify-content-center align-items-center h-100">
				<div class="col-12">
					<div class="card card-registration card-registration-2"
						style="border-radius: 15px;">
						<div class="card-body p-0">
							<div class="row g-0">
								<div class="col-lg-8">
									<div class="p-5">
										<div
											class="d-flex justify-content-between align-items-center mb-5">
											<h1 class="fw-bold mb-0 text-black">Ordine</h1>
											<h6 class="mb-0 text-muted"><%=comprendeCollection.size()%>
												pacchetti acquistati
											</h6>
										</div>

										<!-- ITEM HTML -->
										<%
										
										for (ComprendeBean comprendeItem : comprendeCollection) {

											TravelPackageBean tp = (new TravelPackageDAO()).doRetrieveByKey(comprendeItem.getCodicePacchetto(),
											comprendeItem.getDataCreazione());
										%>
										<hr class="my-0">

										<div
											class="clickable-package py-4 mx-0 hover-overlay rounded ripple row d-flex justify-content-between align-items-center"
											data-href="<%=request.getContextPath()%>/ProductPageServlet?Codice=<%=tp.getCodice()%>&Creazione=<%=tp.getDataCreazione().format(formatter)%>">
											
											<div class="col-md-2 col-lg-2 col-xl-2">
												<img
													src="asset/images/<%=tp.getCittà().toLowerCase()%>01.jpg"
													class="img-fluid rounded-3" alt="immagine pacchetto">
											</div>
											<div class="col-md-3 col-lg-3 col-xl-3">
												<h6 class="text-muted"><%=tp.getCittà()%></h6>
												<h6 class="text-black mb-0"><%=tp.getNome()%></h6>
											</div>
											<div class="col d-flex">
												Data partenza:
												<%=comprendeItem.getDataPartenza().format(DateTimeFormatter.ofPattern("dd/MM/yyyy"))%></div>
											<div class="col-md-3 col-lg-2 col-xl-2 offset-lg-1">
												<h6 class="mb-0">
													€
													<%=comprendeItem.getCosto()%></h6>
											</div>
											<div class="col-md-1 col-lg-1 col-xl-1 text-end">
												<a href="#!" class="text-muted"><i class="fas fa-times"></i></a>
											</div>
										</div>

										<%
										}
										%>

										<hr class="my-0">

										<div class="pt-5">
											<h6 class="mb-0">
												<a
													href=<%=loggedUser.getTipo() == 0 ? "OrderHistory.jsp" : "OrderHistoryAdminServlet"%>
													class="text-body"
													style="text-decoration: none; font-weight: bold"> <svg
														xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-arrow-left"
														viewBox="0 0 16 16">
  														<path fill-rule="evenodd"
															d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8z" />
														</svg>Torna alla lista degli ordini
												</a>
											</h6>
										</div>
									</div>
								</div>
								<div class="col-lg-4 bg-grey">
									<div class="p-5">
										<h3 class="fw-bold mb-5 mt-2 pt-1">Riepilogo</h3>
										<hr class="my-4">

										<div class="d-flex flex-column mb-4">
											<%
											for (ComprendeBean comprendeItem : comprendeCollection) {
												TravelPackageBean btp = (new TravelPackageDAO()).doRetrieveByKey(comprendeItem.getCodicePacchetto(),
												comprendeItem.getDataCreazione());
											%>
											<div class="d-inline-flex justify-content-between">
												<div>
													<h5><%=btp.getNome().toUpperCase()%>
														x<%=comprendeItem.getNumPersone()%></h5>
												</div>
												<div>
													<h5>
														€<%=comprendeItem.getCosto()%></h5>
												</div>
											</div>
											<%
											}
											%>
										</div>
										<hr class="my-4">
										<div class="d-flex justify-content-between mb-5">
											<h5 class="text-uppercase">Costo totale</h5>
											<h5>
												€<%=ordine.getCostoTotale()%></h5>
										</div>

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