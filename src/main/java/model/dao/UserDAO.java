package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;

import database.DBConnector;
import model.bean.UserBean;

public class UserDAO implements DAO<UserBean,String> {

	@Override
	public UserBean doRetrieveByKey(String codice) throws SQLException {

		Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
		
        UserBean user = new UserBean();
        
        String query="SELECT * FROM Utente WHERE Username = ?";
        
        
        try {
            con = DBConnector.getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, codice);
           
            rs = ps.executeQuery();
            
            while(rs.next()) {
            	user.setTipo(rs.getInt("Tipo"));
            	user.setUsername(rs.getString("Username"));
            	user.setNome(rs.getString("Nome"));
            	user.setCognome(rs.getString("Cognome"));
            	user.setEmail(rs.getString("IndirizzoEmail"));
            	user.setPassword(rs.getString("Pw"));
            	
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                DBConnector.releaseConnection(con);
                if (ps != null) ps.close();
            } catch(SQLException ex){
                ex.printStackTrace();
            }
            
       }
        return user;
        
	}

	@Override
	public Collection<UserBean> doRetrieveAll() throws SQLException {
		
		Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        
        String query="SELECT * FROM Utente";

		Collection<UserBean> collection = new ArrayList<UserBean>();
		
		 try {
	            con = DBConnector.getConnection();
	            st = con.createStatement();
	            rs= st.executeQuery(query);
	          
				while(rs.next()) {
					UserBean user = new UserBean();
				
		        	user.setTipo(rs.getInt("Tipo"));
		        	user.setUsername(rs.getString("Username"));
		        	user.setNome(rs.getString("Nome"));
		        	user.setCognome(rs.getString("Cognome"));
		        	user.setEmail(rs.getString("Email"));
		        	user.setPassword(null);
		        	
				collection.add(user);
				}
		}catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                DBConnector.releaseConnection(con);
                if (st != null) st.close();
            } catch(SQLException ex){
                ex.printStackTrace();
            }
            
       }
		return collection;
	
	}

	@Override
	public void doSave(UserBean user) throws SQLException {
		Connection con = null;
        PreparedStatement ps = null;
        
        String query="INSERT INTO Utente(Tipo, Username, Nome, Cognome, IndirizzoEmail, Pw) VALUES(?,?,?,?,?,MD5(?))";
            con = DBConnector.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, user.getTipo());
            ps.setString(2,user.getUsername());
            ps.setString(3, user.getNome());
            ps.setString(4, user.getCognome());
            ps.setString(5, user.getEmail());
            ps.setString(6, user.getPassword());
           
            ps.executeUpdate();
            
        
            try {
                DBConnector.releaseConnection(con);
                if (ps != null) ps.close();
            } catch(SQLException ex){
                ex.printStackTrace();
            }
            
       }
        
	@Override
	public void doUpdate(UserBean user) throws SQLException {

		Connection con = null;
        PreparedStatement ps = null;
        
        String query="UPDATE Utente SET Username = ?, Nome = ?, Cognome = ?, indirizzoEmail = ?, Pw = MD5(?)";
        
        
        try {
            con = DBConnector.getConnection();
            ps = con.prepareStatement(query);
            
            ps.setString(1,user.getUsername());
            ps.setString(2, user.getNome());
            ps.setString(3, user.getCognome());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPassword());
           
            ps.executeUpdate();

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                DBConnector.releaseConnection(con);
                if (ps != null) ps.close();
            } catch(SQLException ex){
                ex.printStackTrace();
            }
            
       }
        
	}

	@Override
	public boolean doDelete(String codice) throws SQLException {
		
		throw new UnsupportedOperationException();
			
}

    public UserBean doCheckLogin(String username, String password) throws SQLException {
        Connection con = null;
        PreparedStatement ps = null;
        int match = 0;

        String query =  "SELECT COUNT(*) FROM Utente WHERE Username = ? and Pw = MD5(?)";

            con = DBConnector.getConnection();
            ps = con.prepareStatement(query);

            ps.setString(1,username);
            ps.setString(2,password);

            ResultSet rs = ps.executeQuery();
            while(rs.next()){
               match = rs.getInt(1);
            }

            if(match == 1){
                return this.doRetrieveByKey(username);
            }

            try {
                DBConnector.releaseConnection(con);
                if (ps != null) ps.close();
            } catch(SQLException ex){
                ex.printStackTrace();
            }
            
       return null;
    }
}
