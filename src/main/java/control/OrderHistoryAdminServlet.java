package control;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.OrdineBean;
import model.dao.OrdineDAO;


@WebServlet("/OrderHistoryAdminServlet")
public class OrderHistoryAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public OrderHistoryAdminServlet() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		try {
			Collection<OrdineBean> ordini = (new OrdineDAO()).doRetrieveAll();
			ArrayList<OrdineBean> ordiniListCopy = new ArrayList<OrdineBean>(ordini);
			
			String username = request.getParameter("username");
		 	String dataInizio = request.getParameter("DataInizio");
		 	String dataFine = request.getParameter("DataFine");
		 	
		 	if(dataInizio != null && dataFine != null){
		 		LocalDate dataInizioD = LocalDate.parse(dataInizio);
		 	 	LocalDate dataFineD = LocalDate.parse(dataFine);
		 	 	LocalDate tempDate;
		 	 	
		 	 	for(OrdineBean ord : ordiniListCopy){
		 	 		tempDate = ord.getDataPrenotazione();
		 	 		
			if(!tempDate.plusDays(1).isAfter(dataInizioD) || !tempDate.minusDays(1).isBefore(dataFineD)){
				ordini.remove(ord);
			}
				}
		 	}else if(username != null){
		 		for(OrdineBean ord : ordiniListCopy){
		 			if(!ord.getCliente().equalsIgnoreCase(username)){
		 				ordini.remove(ord);
		 			}		
		 		}
			}
		 	RequestDispatcher rd = request.getRequestDispatcher("/OrderHistoryAdmin.jsp");
		 	request.setAttribute("ordini", ordini);
		 	rd.forward(request, response);
		 	
		} catch (SQLException e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}	
		
	 	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
