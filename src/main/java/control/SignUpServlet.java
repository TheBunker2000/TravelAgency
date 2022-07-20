package control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.UserBean;
import model.dao.UserDAO;

@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SignUpServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		throw new UnsupportedOperationException();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		UserBean newUser = new UserBean();
		
		synchronized(newUser) {
			
			newUser.setUsername(request.getParameter("Username"));
			newUser.setNome(request.getParameter("Nome"));
			newUser.setCognome(request.getParameter("Cognome"));
			newUser.setEmail(request.getParameter("Email"));
			newUser.setPassword(request.getParameter("Password"));
			newUser.setTipo(Integer.parseInt(request.getParameter("tipoCliente")));
			
			try {
				(new UserDAO()).doSave(newUser);
				
			} catch (SQLException e) {
				e.printStackTrace();
				throw new ServletException();
			}
			
		}
	}

}
