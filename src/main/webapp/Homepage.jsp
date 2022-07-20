<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="model.dao.*" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<jsp:useBean id="packageList" type="java.util.List<model.bean.TravelPackageBean>" scope="request" />
<head>
<meta charset="UTF-8">
<title>TravelAgency</title>

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src= "https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>



<style>

	.carousel {overflow:hidden}
	
</style>

	<script>
	$(function() {

		  $('.card-img-top').each(function() {
		  
		    var $img = $(this);
		    $img.hover(function() {
		    
		      $img.stop(true, true).animate({
		        opacity: '0.5'
		      });
		    
		    }, function() {
		    
		      $img.stop(true, true).animate({
		       opacity: '100.0'
		      });
		    
		    });
		  
		  });

		});
		      
	
	</script>

</head>
<body class="d-flex flex-column h-100 min-vh-100">
	<%@ include file="Header.jsp"%>

	<!-- Carousel -->
	<div id="carouselExampleIndicators" class="carousel slide"
		data-bs-ride="true">
		<div class="carousel-indicators">
			<button type="button" data-bs-target="#carouselExampleIndicators"
				data-bs-slide-to="0" class="active" aria-current="true"
				aria-label="Slide 1"></button>
			<button type="button" data-bs-target="#carouselExampleIndicators"
				data-bs-slide-to="1" aria-label="Slide 2"></button>
			<button type="button" data-bs-target="#carouselExampleIndicators"
				data-bs-slide-to="2" aria-label="Slide 3"></button>
		</div>
		<div class="carousel-inner">

			<div class="carousel-item active">
				<img src="asset/images/copertina1.jpg" class="d-block w-100" width="600"
					height="500" alt="...">
			</div>
			<div class="carousel-item">
				<img src="asset/images/copertina2.jpg" class="d-block w-100"
					width="600" height="500" alt="...">
			</div>
			<div class="carousel-item">
				<img src="asset/images/copertina3.jpg" class="d-block w-100"
					width="400" height="500" alt="...">
			</div>
		</div>
		<button class="carousel-control-prev" type="button"
			data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Next</span>
		</button>
	</div>
	
	<br>
	<br>


<div class="row row-cols-1 row-cols-md-3 g-4 mx-2">
<%
for(TravelPackageBean tp : packageList){
%>
	<div class="col">
    <div class="card">
      <img src="https://infrastrutture.tk:12000/images/<%=tp.getNome()%>01.jpg" class="card-img-top" alt="Immagine non disponibile" >
      <div class="card-body">
        <h5 class="card-title"><%=tp.getNome() %></h5>
           <p class="card-text" ><%= (tp.getDescrizione().length() > 401 ?  tp.getDescrizione().substring(0,400) : tp.getDescrizione()) + "..." %></p>
           <a href="ProductPageServlet?Codice=<%=tp.getCodice()%>" class="btn btn-primary">Più informazioni</a>
      </div>
     
     
    </div>
  </div>
	
<% 	
}
%>
</div>

<div class="d-flex justify-content-center">
	<a class="btn btn-primary" href="PackagesListServlet" role="button">Visualizza gli altri pacchetti</a>
</div>



	<%@ include file="Footer.jsp"%>
</body>
</html>