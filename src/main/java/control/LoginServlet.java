package control;

import model.bean.UserBean;
import model.dao.UserDAO;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    

	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("un");
        String password = request.getParameter("pw");
        String redirectedPage;
        UserBean loggedUser = null;

        try {
            loggedUser = (new UserDAO()).doCheckLogin(username, password);
            
            if (loggedUser != null){
                request.getSession().setAttribute("loggedUser", loggedUser);
                redirectedPage = "/HomepageServlet";    
            } else {
            	throw new ServletException();
            }
        } catch (SQLException ex){
        	redirectedPage = "LoginPage.jsp";
            ex.printStackTrace();
        }
        
        
        
    }
}
