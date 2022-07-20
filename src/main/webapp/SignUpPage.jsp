<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registrazione</title>

	<!-- Risorse per il Bootstrap -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
	
	<!-- Risorse per il JQuery -->
	<script src="${pageContext.request.contextPath}/libs/jquery.min.js"></script>

	<!-- Risorse per il Modal -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="asset/CSS/ConfirmationModalStyle.css">
	<link rel="stylesheet" href="asset/CSS/ErrorModalStyle.css">

	
<script>

	<!-- Validazione del form -->
	function validateForm(){	
		let elements = document.getElementById("signUpForm").elements;
	
		for (var i = 0, element; element = elements[i++];) {
			if((element.id == "inputUsername") || (element.id == "inputPassword")){
			if(element.value.match(/\s+/)){
				showAlert("il campo " + element.name + " non può contenere spazi");
				return false; 
			}else if((element.value.length > 15) && element.id != "inputEmail"){
				showAlert("il campo " + element.name + " può contenere massimo 15 caratteri");
				return false;
			}
			}
			if((element.id == "inputName") || (element.id == "inputCognome")){
				if(!element.value.match(/^[A-z]+ *[A-z]*$/)){
					showAlert("il campo " + element.name + " può essere composto solo da lettere");
					return false;
				}
			}
			if(element.id == "inputEmail"){
				if(!element.value.match(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/)){
					console.log(element.value)
					showAlert("il campo email è in un formato non consentito");
					return false;
				}
			}
		}
		
		return true;
		
	}

	<!-- Mostra alert con messaggio -->
	function showAlert(msg){
		$("#alert").text(msg)
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
			window.location.href = (window.location.origin + "/TravelAgency/LoginPage.jsp")
		});
		
		<!-- Registrazione callback onclick -->
		$("#submitButton").click(function(e) {
			
			<!-- Validazione form -->
			if(validateForm() == false)
				return false;
			
			<!-- Richiesta di POST alla servlet -->
			console.log("Sending POST request to SignUpServlet");
			
			$.ajax({
				type : "POST",
				beforeSend: function () {
					$("#spinner-login").show();	    
				  },
				  complete: function () {
					  $("#spinner-login").hide();
				  },
				data : {
					Username : $("#inputUsername").val(),
					Nome : $("#inputNome").val(),
					Cognome: $("#inputCognome").val(),
					Email : $("#inputEmail").val(),
					Password : $("#inputPassword").val(),
					tipoCliente : $("input[name=tipoCliente]:checked").val()
				},
				url : "${pageContext.request.contextPath}/SignUpServlet",
				timeout: 10000,
				success: function() {showConfirmationModal("Utente registrato con successo")},
				error: function() {showErrorModal("Username già utilizzato!")}
				
			});
			
			e.preventDefault();
			
		});
	});
	
</script>

</head>
<body class="d-flex flex-column h-100 min-vh-100">

<%@ include file="Header.jsp"%>
<%@ include file="ConfirmationModal.jsp" %>
<%@ include file="ErrorModal.jsp" %> 

<section class="flex-shrink-0" style="background-color: #eee;">
    <div class="container h-100 my-4">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-lg-12 col-xl-11">
        <div class="card text-black" style="border-radius: 25px;">
          <div class="card-body p-md-5">
            <div class="row justify-content-center">
           <div class="alert alert-danger" id="alert" role="alert" style="display: none;">
  				messaggio di errore
			</div>
              <div class="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1">
		
                <p class="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">Registrazione</p>

                <form class="mx-1 mx-md-4" id="signUpForm" name="signUpForm">
                
                <div class="d-flex flex-row align-items-center mb-4">
                    <i class="fas fa-user fa-lg me-3 fa-fw"></i>
                    <div class="form-outline flex-fill mb-0">
                      <input type="text" name="Username" id="inputUsername" placeholder="Username" class="form-control" required autofocus/>
                      <label class="form-label" for="inputUsername">Username</label>
                    </div>
                  </div>

                  <div class="d-flex flex-row align-items-center mb-4">
                    <i class="fas fa-user fa-lg me-3 fa-fw"></i>
                    <div class="form-outline flex-fill mb-0">
                      <input type="text" name="Nome" id="inputNome" placeholder="Mario" class="form-control" required/>
                      <label class="form-label" for="inputName">Nome</label>
                    </div>
                  </div>
                  
                  <div class="d-flex flex-row align-items-center mb-4">
                    <i class="fas fa-key fa-lg me-3 fa-fw"></i>
                    <div class="form-outline flex-fill mb-0">
                      <input type="text" name="Cognome" id="inputCognome" placeholder="Rossi" class="form-control" required />
                      <label class="form-label" for="inputCognome">Cognome</label>
                    </div>
                  </div>

                  <div class="d-flex flex-row align-items-center mb-4">
                    <i class="fas fa-envelope fa-lg me-3 fa-fw"></i>
                    <div class="form-outline flex-fill mb-0">
                      <input type="email" name="Email" id="inputEmail" placeholder="mariorossi@example.com" class="form-control" required />
                      <label class="form-label" for="inputEmail">Indirizzo Email</label>
                    </div>
                  </div>

                  <div class="d-flex flex-row align-items-center mb-4">
                    <i class="fas fa-lock fa-lg me-3 fa-fw"></i>
                    <div class="form-outline flex-fill mb-0">
                      <input type="password" name="Password" id="inputPassword" placeholder="Password" class="form-control" required />
                      <label class="form-label" for="inputPassword">Password</label>
                    </div>
                  </div>
                  
                  <div class="form-check">

                    <input class="form-check-input" id="cliente" type="radio" name="tipoCliente" value="0" checked />
                    <label class="form-check-label" for="cliente">Cliente</label>
                    </div>
                    <div class="form-check">
                    <input class="form-check-input" id="amministratore" type="radio" name="tipoCliente" value="1" />
                    <label class="form-check-label" for="amministratore">Amministratore</label>
                  </div>

                  <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                  	<button class="btn btn-lg btn-primary btn-block" id="submitButton" type="button"> 
						<span class="spinner-border spinner-border-sm" id="spinner-login" role="status" aria-hidden="true" style="display:none"></span>
					     Registrati</button>
                  </div>

                </form>

              </div>
              <div class="col-md-10 col-lg-6 col-xl-7 d-flex align-items-center order-1 order-lg-2">

                <img src="asset/images/signUp.jpg" class="img-fluid" alt="Sample image">

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