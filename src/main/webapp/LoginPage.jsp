<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Accesso</title>

<!-- risorse per il bootstrap -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>

<!-- Risorse per il JQuery -->
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

	<!-- Mostra popup con messaggio -->
	function showErrorModal(msg) {
		console.log(msg);
		$("#error-modal-text").text(msg);
		$("#errorModal").modal('show');
	}
	
	function redirectHomepage(){
		window.location.href = (window.location.origin + "/TravelAgency/HomepageServlet")
	}
	
$(document).ready(function() {
		<!-- Registrazione callback onclick -->
		$("#submitButton").click(function(e) {
			
			
			<!-- Richiesta di POST alla servlet -->
			console.log("Sending POST request to LoginServlet");
			
			$.ajax({
				type : "POST",
				beforeSend: function () {
					$("#spinner-login").show();	    
				  },
				  complete: function () {
					  $("#spinner-login").hide();
				  },
				data : {
					un : $("#inputUsername").val(),
					pw : $("#inputPassword").val(),
				},
				timeout: 10000,
				url : "${pageContext.request.contextPath}/LoginServlet",
				success: function() {redirectHomepage()},
				error: function() {showErrorModal("Credenziali errate")}
			});
		
			e.preventDefault();
			
		});
	});
	

</script>


<style>
.form-signin {
	width: 100%;
	max-width: 330px;
	padding: 15px;
	margin: 0 auto;
}
</style>

</head>

<body class="d-flex flex-column h-100 min-vh-100">

	<%@ include file="Header.jsp"%>
	<%@ include file="ErrorModal.jsp"%>

	<section class="flex-shrink-0 flex-grow-1" style="background-color: #eee;">
		<div class="container h-100 my-4">
			<div
				class="row d-flex justify-content-center align-items-center h-100">
				<div class="col-lg-12 col-xl-11">
					<div class="card text-black" style="border-radius: 25px;">
						<div class="card-body p-md-5">
							<div class="row justify-content-center">
								<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50"
									fill="currentColor" class="bi bi-person-circle"
									viewBox="0 0 16 16">
 				 <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z" />
  					<path fill-rule="evenodd"
										d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z" />
					</svg>
								<form class="form-signin" action="LoginServlet" method="post">
									<h1 class="h3 mb-3 font-weight-normal">Eseguire l'accesso</h1>
									<label for="inputUsername" class="sr-only">Username</label> <br>
									<input type="text" id="inputUsername" name="un"
										class="form-control" placeholder="Username" required autofocus>
									<br> <label for="inputPassword" class="sr-only">Password</label>
									<br> <input type="password" id="inputPassword" name="pw"
										class="form-control" placeholder="Password" required>
									<br>
									<div class="d-flex flex-column">
										<div class="d-flex flex-column mx-auto mt-2">
										<button class="btn btn-lg btn-primary btn-block"
											id="submitButton" type="submit"> 
											<span class="spinner-border spinner-border-sm" id="spinner-login" role="status" aria-hidden="true" style="display:none"></span>
												Accedi</button>
										</div>
										<div class="d-flex flex-column mx-auto mt-2">
											<p>Oppure, se non sei registrato</p>
											<a href="SignUpPage.jsp"
												class="btn btn-lg btn-primary btn-block">Registrati</a>
										</div>
									</div>

								</form>
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