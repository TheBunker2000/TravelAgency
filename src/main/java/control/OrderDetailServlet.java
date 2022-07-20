package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.ComprendeBean;
import model.bean.OrdineBean;
import model.dao.ComprendeDAO;
import model.dao.OrdineDAO;


@WebServlet("/OrderDetailServlet")
public class OrderDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public OrderDetailServlet() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String codice = request.getParameter("Codice");
		if (codice != null) {
			Integer codiceInt = Integer.parseInt(codice);
			try {
				OrdineBean ordine = (new OrdineDAO()).doRetrieveByKey(codiceInt);
				Collection<ComprendeBean> comprendeCollection = (new ComprendeDAO()).doRetrieveAllByOrder(codiceInt);
				request.setAttribute("ordine", ordine);
				request.setAttribute("comprendeCollection", comprendeCollection);
				RequestDispatcher rd = request.getRequestDispatcher("/OrderDetail.jsp");
				rd.forward(request, response);
				
			} catch (SQLException e) {
				e.printStackTrace();
				response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

			}
			
		} else {
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
