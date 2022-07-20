<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.bean.*"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Creazione nuovo pacchetto viaggio</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="${pageContext.request.contextPath}/libs/jquery.min.js"></script>

<!-- Risorse per il Modal -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="asset/CSS/ConfirmationModalStyle.css">
<link rel="stylesheet" href="asset/CSS/ErrorModalStyle.css">
<script>
	
	<!-- Validazione del form -->
	function validateForm(){	
		var isValid = true;
		
		let elements = document.getElementById("packageForm").elements;
		
		console.log("Checking for empty forms...");
		for (let element of elements){	
			
			if(element.id != "voloIncluso" && element.id != "submitButton"){
				if(element.value.match(/^\s+$/) || element.value == "" ){
					
					showAlert("il campo " + element.id + " non può essere vuoto");
					console.log(element.id);
					isValid = false;
				}
			}	
		};
		
		console.log("Checking for valid package name...");
		var element = elements["inputName"];
		
		if(!element.value.match(/^[A-zÀ-ú]+$/)){
			showAlert("Il campo nome può contenere solo caratteri alfanumerici");
			isValid = false;
		}
		
		
		element = elements["inputCosto"];
		if(!element.value.match(/^[0-9]+[.[0-9]+]?$/)){
			showAlert("Il campo può contenere solo cifre separate da un punto");
			isValid = false; 
		}
		
		element = elements["inputDurata"];
		if(!element.value.match(/^\d+$/)){
			showAlert("Il campo può contenere solo cifre");
			isValid = false;
		}else if(element.value > 30 || element.value < 2 ){
			showAlert("La durata deve essere maggiore di 1 e minore di 30 giorni");
			isValid = false;
		}
		
		return isValid;
		
	}

	<!-- Mostra alert con messaggio -->
	function showAlert(msg){
		$("#alert").html("Errore!" + '<br>' + msg);
		$("#alert").show();
	}
	
	<!-- Mostra popup con messaggio -->
	function showConfirmationModal(msg) {
		console.log(msg);
		$("#confirmation-modal-text").text(msg);
		$("#confirmationModal").modal('show');
	}
	
	function showErrorModal(msg) {
		console.log(msg);
		$("#error-modal-text").text(msg);
		$("#errorModal").modal('show');
	}

	$(document).ready(function() {
		
		$("#confirmation-modal-submit").click(function(e){
			window.location.href = (window.location.origin + "/TravelAgency/HomepageServlet")
		});
		
		
		<!-- Registrazione callback onclick -->
		$("#submitButton").click(function(e) {
			<!-- Validazione form -->
			if(validateForm() == false)
				return false;
			
			<!-- Richiesta di POST alla servlet -->
			console.log("Sending POST request to NewPackageServlet");
			
			var formData = new FormData($("#packageForm")[0]);
			
			$.ajax({
				type : "POST",
				beforeSend: function () {
					$("#spinner-login").show();	    
				  },
				  complete: function () {
					  $("#spinner-login").hide();
				  },
				data : formData,
				processData: false,
				contentType: false,
				url : "${pageContext.request.contextPath}/NewPackageServlet",
				timeout: 10000,
				success: function() {showConfirmationModal("Pacchetto creato con successo")},
				error: function() {showErrorModal("Errore creazione pacchetto")}
			});
			
			
			$.ajax({
				type: "POST",
				data: formData,
				processData: false,
				contentType: false,
				url : "https://infrastrutture.tk:12000/images/" + $("#inputName").val(),
				timeout: 10000,
				error: function() {showErrorModal("Error creazione pacchetto (caricamento immagini)")}
			});
			
			e.preventDefault();
		});
	});
	
	

</script>

</head>

<body class="d-flex flex-column h-100 min-vh-100">
	<%@ include file="Header.jsp"%>
	<%@ include file="ConfirmationModal.jsp"%>
	<%@ include file="ErrorModal.jsp"%>
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

									<p class="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">Crea
										un nuovo pacchetto di viaggio!</p>

									<form class="mx-1 mx-md-4" id="packageForm"
										enctype="multipart/form-data">

										<div class="d-flex flex-row align-items-center mb-4">
											<i class="fas fa-user fa-lg me-3 fa-fw"></i>
											<div class="form-outline flex-fill mb-0">
												<input type="text" id="inputName" name="name"
													placeholder="Nome destinazione" class="form-control"
													required autofocus /> <label class="form-label"
													for="inputName">Nome</label>
											</div>
										</div>

										<div class="d-flex flex-row align-items-center mb-4">
											<i class="fas fa-key fa-lg me-3 fa-fw"></i>
											<div class="form-outline flex-fill mb-0">
												<textarea id="inputDescrizione" name="descrizione"
													maxlength="1000"
													placeholder="Inserisci la descrizione del pacchetto qui"
													class="form-control" required></textarea>
												<label class="form-label" for="inputDescrizione">Descrizione</label>
											</div>
										</div>

										<div class="d-flex flex-row align-items-center mb-4">
											<i class="fas fa-key fa-lg me-3 fa-fw"></i>
											<div class="form-outline flex-fill mb-0">
												<input id="voloIncluso" name="voloIncluso" type="checkbox">
												<label class="form-label" for="voloIncluso">Volo
													Incluso?</label>
											</div>
										</div>

										<div class="d-flex flex-row align-items-center mb-4">
											<i class="fas fa-key fa-lg me-3 fa-fw"></i>
											<div class="form-outline flex-fill mb-0">
												<textarea id="inputDettagliVolo" name="dettagliVolo"
													maxlength="500"
													placeholder="Inserisci eventuali dettagli sul volo qui"
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
													placeholder="Inserisci dettagli sul pernottamento qui"
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
													placeholder="499.99" class="form-control" required /> <label
													class="form-label" for="inputCosto">Costo</label>
											</div>
										</div>

										<div class="d-flex flex-row align-items-center mb-4">
											<i class="fas fa-lock fa-lg me-3 fa-fw"></i>
											<div class="form-outline flex-fill mb-0">
												<input type="text" id="inputCittà" name="citta"
													placeholder="Salerno" class="form-control" required /> <label
													class="form-label" for="inputCittà">Città</label>
											</div>
										</div>

										<div class="d-flex flex-row align-items-center mb-4">
											<i class="fas fa-lock fa-lg me-3 fa-fw"></i>
											<div class="form-outline flex-fill mb-0">
												<input type="text" id="inputNazione" name="nazione"
													placeholder="Italia" class="form-control" required /> <label
													class="form-label" for="inputNazione">Nazione</label>
											</div>
										</div>


										<div class="d-flex flex-row align-items-center mb-4">
											<i class="fas fa-lock fa-lg me-3 fa-fw"></i>
											<div class="form-outline flex-fill mb-0">
												<input type="number" id="inputDurata" name="durata"
													placeholder="Durata in giorni" class="form-control"
													required /> <label class="form-label" for="inputNazione">Durata
													viaggio</label>
											</div>
										</div>

										<div class="d-flex flex-row align-items-center mb-4">
											<i class="fas fa-lock fa-lg me-3 fa-fw"></i>
											<div class="form-outline flex-fill mb-0">
												<input class="form-control" type="file" id="inputImage"
													name="inputImmagini[]" accept="image/jpg" multiple /> <label
													class="form-label" for="inputImage">Scegli le foto
													per il pacchetto</label>

											</div>
										</div>


										<div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
											
											<button class="btn btn-lg btn-primary btn-block" id="submitButton" type="button"> 
												<span class="spinner-border spinner-border-sm" id="spinner-login" role="status" aria-hidden="true" style="display:none"></span>
					 							  Crea</button>
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