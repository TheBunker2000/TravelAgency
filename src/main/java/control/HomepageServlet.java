package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.TravelPackageBean;
import model.dao.TravelPackageDAO;

/**
 * Servlet implementation class HomepageServlet
 */
@WebServlet("/HomepageServlet")
public class HomepageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public HomepageServlet() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		ArrayList<TravelPackageBean> packageList = new ArrayList<TravelPackageBean>();
		try {
			packageList =(ArrayList<TravelPackageBean>)(new TravelPackageDAO()).doRetrieveAllValidPackages();
			List<TravelPackageBean> shortPackageList = packageList.subList(0, 6);
			
			request.setAttribute("packageList", shortPackageList);
			RequestDispatcher rd = request.getRequestDispatcher("/Homepage.jsp");
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
