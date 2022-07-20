package control;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.bean.*;
import model.dao.*;

@WebServlet("/SendOrderServlet")
public class SendOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SendOrderServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();

		CartBean cart = (CartBean) session.getAttribute("cart");
		UserBean user = (UserBean) session.getAttribute("loggedUser");

		// 1. creazione bean ordine
		OrdineBean ordine = new OrdineBean();
		ordine.setCliente(user.getUsername());
		ordine.setDataPrenotazione(LocalDate.now());
		ordine.setCostoTotale(cart.getTotalCost());

		List<CartItemBean> pacchettiOrdine = cart.getPackages();

		int idOrdine = -1;
		// 2. inseirmento ordine e salvataggio last inserted ID
		try {
			
			idOrdine = (new OrdineDAO()).doSaveAndRetrieveId(ordine);
			ordine.setCodice(idOrdine);

			for (CartItemBean cartItem : pacchettiOrdine) {
				
				// 4. creazione di tupla della tabella comprende
				ComprendeBean comprendeItem = new ComprendeBean();
				comprendeItem.setCodiceOrdine(ordine.getCodice());
				comprendeItem.setCodicePacchetto(cartItem.getCodicePacchetto());
				comprendeItem.setDataCreazione(cartItem.getDataCreazionePacchetto());
				comprendeItem.setDataPartenza(cartItem.getDataPartenza());
				comprendeItem.setNumPersone(cartItem.getNumPersone());
				comprendeItem.setCosto(cartItem.getTotale());

				// transazione per inserimento tupla di comprende
				(new ComprendeDAO()).doSave(comprendeItem);
				
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		cart.removeAllItems();
		session.setAttribute("cart", cart);
		response.sendRedirect(request.getContextPath()+"/OrderHistory.jsp");

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	}	
}
