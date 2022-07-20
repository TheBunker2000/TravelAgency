<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="travelPackage" class="model.bean.TravelPackageBean" scope="request" />
<%@ page import="model.bean.*"%>
<%@ page import="model.dao.*"%>
<%
String checkedOrNot = "";
%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Modifica un pacchetto viaggio</title>

<script
	src="${pageContext.request.contextPath}/libs/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/asset/CSS/ConfirmationModalStyle.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/asset/CSS/ErrorModalStyle.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>


<script>
	function setPlaceholderValues() {
		if ($("#inputDescrizione").val() == "") {
			var placeholderDescrizione = $('#inputDescrizione').attr(
					'placeholder');
			$("#inputDescrizione").val(placeholderDescrizione);
		}
		if ($("#inputDettagliVolo").val() == "") {
			var placeholderDescrizione = $('#inputDettagliVolo').attr(
					'placeholder');
			$("#inputDettagliVolo").val(placeholderDescrizione);
		}
		if ($("#inputDettagliPernottamento").val() == "") {
			var placeholderDescrizione = $('#inputDettagliPernottamento').attr(
					'placeholder');
			$("#inputDettagliPernottamento").val(placeholderDescrizione);
		}
		if ($("#inputCosto").val() == "") {
			var placeholderDescrizione = $('#inputCosto').attr('placeholder');
			$("#inputCosto").val(placeholderDescrizione);
		}
		if ($("#inputDurata").val() == "") {
			var placeholderDescrizione = $('#inputDurata').attr('placeholder');
			$("#inputDurata").val(placeholderDescrizione);
		}
	}

	$(document).ready(function() {
						setPlaceholderValues();
						$("#submitButton").click(function(e) {

							var formData = new FormData(
							$("#packageForm")[0]);

					 		console.log("Sending POST request...")

								$.ajax({
									type : "POST",
									beforeSend: function () {
										$("#spinner-login").show();	    
									  },
									  complete: function () {
										  $("#spinner-login").hide();
									  },
									data : formData,
									processData : false,
									contentType : false,
									url : "${pageContext.request.contextPath}/ModifyPackageServlet",
									timeout: 10000,
									success : function() {
										$("#confirmation-modal-text").text("Pacchetto modificato correttamente.");
										$("#confirmationModal").modal('show');
									},
									error : function() {
										$("#error-modal-text").text("Errore nella modifica del pacchetto.");
										$("#errorModal").modal('show');
									}
								});
					 						
					 						if(formData.get("inputImmagini[]").size != 0){
					 							
					 						console.log("Sending images")
					 		
											$.ajax({
														type : "POST",
														data : formData,
														processData : false,
														contentType : false,
														url : "https://infrastrutture.tk:12000/images/"
																+ $(
																		"#inputName")
																		.val(),
														timeout: 10000,
														error : function() {
															showErrorModal("Error creazione pacchetto (caricamento immagini)")
														}
													});
											
					 						}

											e.preventDefault();
										});
					});

	$(document).ready(function() {
						$("#confirmation-modal-submit").click(function(e) {
						window.location.href = (window.location.origin + "/TravelAgency/PackagesListServlet")
						});
	});
</script>

</head>

<body class="d-flex flex-column h-100">

	<%@ include file="Header.jsp"%>
	<%@ include file="ErrorModal.jsp"%>
	<%@ include file="ConfirmationModal.jsp"%>
	<%
	if (loggedUser.getUsername() == null || loggedUser.getTipo() == 0) {
		response.sendRedirect(request.getContextPath() + "/LoginPage.jsp");
		return;
	}
	%>
	<section class="flex-shrink-0" style="background-color: #eee;">
		<div class="container h-100 my-4">
			<div
				class="row d-flex justify-content-center align-items-center h-100">
				<div class="col-lg-12 col-xl-11">
					<div class="card text-black" style="border-radius: 25px;">
						<div class="card-body p-md-5">
							<div class="row justify-content-center">
								<div class="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1">
									<div class="alert alert-danger" id="alert" role="alert"
										style="display: none;">Errore!</div>
									<p class="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">
										Modifica il pacchetto
										<%=travelPackage.getNome()%></p>

									<form class="mx-1 mx-md-4" id="packageForm"
										enctype="multipart/form-data">
										<input type="hidden" id="inputName" value="<%=travelPackage.getNome()%>"/>
										<div class="d-flex flex-row align-items-center mb-4">
											<i class="fas fa-key fa-lg me-3 fa-fw"></i>
											<div class="form-outline flex-fill mb-0">
												<textarea id="inputDescrizione" name="descrizione"
													maxlength="1000" placeholder="<%=travelPackage.getDescrizione()%>"
													class="form-control" required></textarea>
												<label class="form-label" for="inputDescrizione">Descrizione</label>
											</div>
										</div>

										<div class="d-flex flex-row align-items-center mb-4">
											<i class="fas fa-key fa-lg me-3 fa-fw"></i>
											<div class="form-outline flex-fill mb-0">
												<input id="voloIncluso" name="voloIncluso" type="checkbox" 
													<%=checkedOrNot = (travelPackage.isVoloIncluso()) ? "checked" : ""%>>
												<label class="form-label" for="inputDescrizione">Volo
													Incluso?</label>
											</div>
										</div>

										<div class="d-flex flex-row align-items-center mb-4">
											<i class="fas fa-key fa-lg me-3 fa-fw"></i>
											<div class="form-outline flex-fill mb-0">
												<textarea id="inputDettagliVolo" name="dettagliVolo"
													maxlength="500" placeholder="<%=travelPackage.getDettagliVolo()%>"
													class="form-control"></textarea>
												<label class="form-label" for="inputDettagliVolo">Dettagli
													Volo</label>
											</div>
										</div>

										<div class="d-flex flex-row align-items-center mb-4">
											<i class="fas fa-key fa-lg me-3 fa-fw"></i>
											<div class="form-outline flex-fill mb-0">
												<textarea id="inputDettagliPernottamento"
													name="dettagliPernottamento" maxlength="500"
													placeholder="<%=travelPackage.getDettagliPernottamento()%>"
													class="form-control" required></textarea>
												<label class="form-label" for="inputDettagliPernottamento">Dettagli
													Pernottamento</label>
											</div>
										</div>

										<div class="d-flex flex-row align-items-center mb-4">
											<i class="fas fa-key fa-lg me-3 fa-fw"></i>
											<div class="form-outline flex-fill mb-0">
												<select id="pensione" name="pensione" required>
													<option value="Pensione Completa">Pensione
														Completa</option>
													<option value="Mezza Pensione">Mezza Pensione</option>
													<option value="Colazione">Colazione</option>
												</select> <label class="form-label" for="pensione">Trattamento</label>
											</div>
										</div>

										<div class="d-flex flex-row align-items-center mb-4">
											<i class="fas fa-envelope fa-lg me-3 fa-fw"></i>
											<div class="form-outline flex-fill mb-0">
												<input type="text" id="inputCosto" name="costo"
													placeholder="<%=travelPackage.getCosto()%>" class="form-control"
													required /> <label class="form-label" for="inputCosto">Costo</label>
											</div>
										</div>

										<div class="d-flex flex-row align-items-center mb-4">
											<i class="fas fa-lock fa-lg me-3 fa-fw"></i>
											<div class="form-outline flex-fill mb-0">
												<input type="number" id="inputDurata" name="durata"
													placeholder="<%=travelPackage.getDurata()%>" class="form-control"
													required /> <label class="form-label" for="inputNazione">Durata
													viaggio</label>
											</div>
										</div>

										<div class="d-flex flex-row align-items-center mb-4">
											<i class="fas fa-lock fa-lg me-3 fa-fw"></i>
											<div class="form-outline flex-fill mb-0">
												<input class="form-control" type="file" id="inputImage"
													name="inputImmagini[]" accept="image/jpg" multiple /> <label
													class="form-label" for="inputImage">Scegli foto
													aggiuntive per il pacchetto</label> <input type="hidden"
													name="codicePacchetto" value="<%=travelPackage.getCodice()%>">
											</div>
										</div>


										<div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
											
												<button class="btn btn-lg btn-primary btn-block"
											id="submitButton" type="button"> 
											<span class="spinner-border spinner-border-sm" id="spinner-login" role="status" aria-hidden="true" style="display:none"></span>
												Modifica</button>
										</div>

									</form>

								</div>
								<div
									class="col-md-10 col-lg-6 col-xl-7 d-flex align-items-center order-1 order-lg-2">

									<img src="asset/images/signUp.jpg" class="img-fluid"
										alt="Sample image">

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
