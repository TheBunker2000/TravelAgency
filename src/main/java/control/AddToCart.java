package control;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.bean.CartBean;
import model.bean.CartItemBean;
import model.bean.TravelPackageBean;
import model.bean.UserBean;
import model.dao.TravelPackageDAO;

@WebServlet("/AddToCart")
public class AddToCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public AddToCart() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		HttpSession session = request.getSession();
		String redirectedPage = null;
		
		UserBean user = (UserBean) session.getAttribute("loggedUser");
	 	if( user == null || user.getTipo()==1){
	 		redirectedPage="/LoginPage.jsp";
	 	}else{
	 	
		 	CartBean cart = (CartBean) session.getAttribute("cart");
		 	if(cart == null) {
		 		cart = new CartBean();
		 	}
		 	
		 	TravelPackageBean tp = new TravelPackageBean();
		 	try {
				tp = (new TravelPackageDAO()).doRetrievePackageByPackageKey(Integer.parseInt(request.getParameter("CodicePacchetto")));
			} catch (SQLException e) {
				e.printStackTrace();
			}
		 	
		 	CartItemBean cartItem = new CartItemBean();
		 	
		 	cartItem.setCodicePacchetto(tp.getCodice());
		 	cartItem.setDataCreazionePacchetto(tp.getDataCreazione());
		 	cartItem.setNumPersone(Integer.parseInt(request.getParameter("NumeroPersone")));	
		 	cartItem.setDataPartenza(LocalDate.parse(request.getParameter("DataPartenza")));
		 	cartItem.setCittàPacchetto(tp.getCittà());
		 	cartItem.setNomePacchetto(tp.getNome());
		 	cartItem.setTotale(tp.getCosto()*cartItem.getNumPersone());
		 	
		 	if(!cart.isAlreadyBooked(cartItem)) {
			 	cart.addItem(cartItem); 	
			 	session.setAttribute("cart", cart);
		 	}
		 
		 	redirectedPage = "/ShoppingCart.jsp";
	 	}
	 	response.sendRedirect(request.getContextPath() + redirectedPage);
	
	}

}
