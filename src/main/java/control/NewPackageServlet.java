package control;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import model.bean.TravelPackageBean;
import model.dao.TravelPackageDAO;


@WebServlet("/NewPackageServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 *2,
	maxFileSize = 1024 * 1024 * 10, 
	maxRequestSize = 1024 * 1024 * 500)
public class NewPackageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public NewPackageServlet() {
        super();
    }
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); 

	}
    
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
    	TravelPackageBean tp = new TravelPackageBean();
    	
    	synchronized (tp) {
		tp.setNome(request.getParameter("name"));
		tp.setDescrizione(request.getParameter("descrizione"));
		tp.setCosto(Double.parseDouble(request.getParameter("costo")));
		tp.setCittà(request.getParameter("citta"));
		tp.setNazione(request.getParameter("nazione"));
		tp.setDurata(Integer.parseInt(request.getParameter("durata")));
		if(request.getParameter("voloIncluso")!=null) {
			tp.setVoloIncluso(true);
		}else {
			tp.setVoloIncluso(false);
		}
		
		tp.setDettagliVolo(request.getParameter("dettagliVolo"));
		tp.setDettagliPernottamento(request.getParameter("dettagliPernottamento"));
		tp.setPensione(request.getParameter("pensione"));
		
		try {
			(new TravelPackageDAO()).doSave(tp);
		} catch (SQLException e) {
			throw new ServletException();
		} 
			    
	}
    }
	
	
protected void doPostOld(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		TravelPackageBean tp = new TravelPackageBean();
		tp.setNome(request.getParameter("name"));
		tp.setDescrizione(request.getParameter("descrizione"));
		tp.setCosto(Double.parseDouble(request.getParameter("costo")));
		tp.setCittà(request.getParameter("citta"));
		tp.setNazione(request.getParameter("nazione"));
		tp.setDurata(Integer.parseInt(request.getParameter("durata")));
		
		
		tp.setDettagliVolo(request.getParameter("dettagliVolo"));
		tp.setDettagliPernottamento(request.getParameter("dettagliPernottamento"));
		tp.setPensione(request.getParameter("pensione"));
		
		try {
			(new TravelPackageDAO()).doSave(tp);
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		
		
		//response.sendRedirect(request.getContextPath()+"/HomepageServlet");
		
	}

}
