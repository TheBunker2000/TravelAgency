package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.TravelPackageBean;
import model.dao.TravelPackageDAO;


@WebServlet("/PackagesListServlet")
public class PackagesListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public PackagesListServlet() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String nome = request.getParameter("Nome");
		ArrayList<TravelPackageBean> packageList = new ArrayList<TravelPackageBean>();
		try {
			packageList =(ArrayList<TravelPackageBean>)(new TravelPackageDAO()).doRetrieveAllValidPackages();
			ArrayList<TravelPackageBean> packageListCopy = new ArrayList<TravelPackageBean>(packageList);
			
			if(nome != null){
				for(TravelPackageBean tp : packageListCopy){
					if(!tp.getCittà().equalsIgnoreCase(nome) && !tp.getNome().equalsIgnoreCase(nome)){
						packageList.remove(tp);
					}
				}
			}
			
			request.setAttribute("packageList", packageList);
			RequestDispatcher rd = request.getRequestDispatcher("/PackagesList.jsp");
			rd.forward(request, response);
		} catch (SQLException e) {
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
