package control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.bean.CartBean;

@WebServlet("/DeleteCartItemServlet")
public class DeleteCartItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DeleteCartItemServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String codice = request.getParameter("codicePacchetto");
		HttpSession session = request.getSession();
		
		if(codice!=null){
			Integer codiceInt = Integer.parseInt(codice);
			CartBean cart = (CartBean) session.getAttribute("cart");
			
			if(codiceInt==-1) {
				cart.removeAllItems();
			}else {
				cart.removeItem(codiceInt);
			}
		}	
	 	response.sendRedirect(request.getContextPath() + "/ShoppingCart.jsp");

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	}

}
