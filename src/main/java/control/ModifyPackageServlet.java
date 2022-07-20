package control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.TravelPackageBean;
import model.dao.TravelPackageDAO;

@WebServlet("/ModifyPackageServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024
		* 500)
public class ModifyPackageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ModifyPackageServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			String codice = request.getParameter("Codice");
			if(codice!=null) {
				Integer codiceInt = Integer.parseInt(codice);
				TravelPackageBean travelPackage = (new TravelPackageDAO()).doRetrievePackageByPackageKey(codiceInt);
				RequestDispatcher rd = request.getRequestDispatcher("/ModifyPackagePage.jsp");
				request.setAttribute("travelPackage", travelPackage);
				rd.forward(request, response);
			}else {
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
		} catch(SQLException ex){
			ex.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
		
		
		
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String codice = request.getParameter("codicePacchetto");
		Integer codiceInt = 0;
		if (codice == null || codice.isBlank() || codice.isEmpty()) {
			System.out.println(codice);
			throw new ServletException();
		} else {
			codiceInt = Integer.parseInt(codice);
			System.out.println(codice);
		}

		try {
			TravelPackageBean tp = (new TravelPackageDAO()).doRetrievePackageByPackageKey(codiceInt);
			synchronized (tp) {
				tp.setDescrizione(request.getParameter("descrizione"));
				tp.setCosto(Double.parseDouble(request.getParameter("costo")));
				tp.setDurata(Integer.parseInt(request.getParameter("durata")));
				if (request.getParameter("voloIncluso") != null) {
					tp.setVoloIncluso(true);
				} else {
					tp.setVoloIncluso(false);
				}
				tp.setDettagliVolo(request.getParameter("dettagliVolo"));
				tp.setDettagliPernottamento(request.getParameter("dettagliPernottamento"));
				tp.setPensione(request.getParameter("pensione"));
				(new TravelPackageDAO()).doUpdate(tp);
			}
		} catch (SQLException e) {
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}

		
	}

}
