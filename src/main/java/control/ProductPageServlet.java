package control;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.TravelPackageBean;
import model.dao.TravelPackageDAO;


@WebServlet("/ProductPageServlet")
public class ProductPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public ProductPageServlet() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DateTimeFormatter formatter = DateTimeFormatter.ISO_DATE_TIME;
		TravelPackageBean tp;
		String codice = request.getParameter("Codice");
		if(codice == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			
		}else {
			Integer codiceInt = Integer.parseInt(codice);
			String timestamp = request.getParameter("Creazione");
			
			try {
				if (timestamp == null) {
					tp = new TravelPackageDAO().doRetrievePackageByPackageKey(codiceInt);
					request.setAttribute("isOrdine", false);
					
				}else{
					LocalDateTime dataCreazione = LocalDateTime.parse(timestamp, formatter);
					tp = new TravelPackageDAO().doRetrieveByKey(codiceInt, dataCreazione);
					request.setAttribute("isOrdine", true);

				}
				request.setAttribute("travelPackage", tp);
				RequestDispatcher rd = request.getRequestDispatcher("/ProductPage.jsp");
				rd.forward(request, response);
			}catch(SQLException e) {
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
				e.printStackTrace();
			}
			
	
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
