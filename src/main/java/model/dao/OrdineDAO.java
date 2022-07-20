package model.dao;

import java.sql.*;
import java.sql.Date;
import java.util.*;

import database.DBConnector;
import model.bean.OrdineBean;

public class OrdineDAO implements DAO<OrdineBean, Integer> {
    
    @Override
    public OrdineBean doRetrieveByKey(Integer codice) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        
        OrdineBean ordine = new OrdineBean();

        String selectSQL = "SELECT * FROM Ordine O WHERE O.Codice = ?";

        try {
            conn = DBConnector.getConnection();
            ps = conn.prepareStatement(selectSQL);
            ps.setInt(1, codice);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                ordine.setCodice(rs.getInt("Codice"));
                ordine.setCliente(rs.getString("Cliente"));
                ordine.setDataPrenotazione(rs.getDate("DataPrenotazione").toLocalDate());
                ordine.setCostoTotale(rs.getDouble("CostoTotale"));
            }
        } finally {
            try {
                if (ps != null)
                    ps.close();
            } finally {
                DBConnector.releaseConnection(conn);
            }
        }
                
        return ordine;
    }

    public Collection<OrdineBean> doRetrieveAllOrdersFromUser(String username) throws SQLException{
	    Connection conn = null;
	    PreparedStatement ps = null;
	    
	    Collection<OrdineBean> orders = new ArrayList<>();
	
	    String selectSQL = "SELECT O.* FROM Utente U, Ordine O WHERE U.Username = ? and U.Username = O.Cliente;";
	    
	    try {
	        conn = DBConnector.getConnection();
	        ps = conn.prepareStatement(selectSQL);
	
	        ps.setString(1, username);
	        
	        ResultSet rs = ps.executeQuery();
	
	        while(rs.next()){
	            OrdineBean order = new OrdineBean();
	            order.setCodice(rs.getInt("Codice"));
	            order.setCliente(rs.getString("Cliente"));
	            order.setDataPrenotazione(rs.getDate("DataPrenotazione").toLocalDate());
	            order.setCostoTotale(rs.getDouble("CostoTotale"));
	            orders.add(order);
	        }
	    } finally{
	        try {
	            if (ps != null)
	                ps.close();
	        } finally {
	            DBConnector.releaseConnection(conn);
	        }
	    }
	    return orders;
	}

	@Override
    public Collection<OrdineBean> doRetrieveAll() throws SQLException {

        Connection conn = null;
        Statement st = null;

        Collection<OrdineBean> table = new ArrayList<OrdineBean>();
        
        String selectSQL = "SELECT * FROM Ordine";

        try {
            conn = DBConnector.getConnection();
            st = conn.createStatement();

            ResultSet rs = st.executeQuery(selectSQL);
            
            while(rs.next()){
                OrdineBean ordine = new OrdineBean();
                ordine.setCodice(rs.getInt("Codice"));
                ordine.setCliente(rs.getString("Cliente"));
                ordine.setDataPrenotazione(rs.getDate("DataPrenotazione").toLocalDate());
                ordine.setCostoTotale(rs.getDouble("CostoTotale"));
                table.add(ordine);
            }

        } finally {
            try {
                if (st != null)
                    st.close();
            } finally {
                DBConnector.releaseConnection(conn);
            }
        }

        return table;
    }

    @Override
    public void doSave(OrdineBean product) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;

        String insertSQL = "INSERT INTO Ordine(Cliente, DataPrenotazione, CostoTotale) VALUES(?,?,?);";

        try {
            conn = DBConnector.getConnection();
            ps = conn.prepareStatement(insertSQL);

            ps.setString(1, product.getCliente());
            ps.setDate(2, Date.valueOf(product.getDataPrenotazione()));
            ps.setDouble(3, product.getCostoTotale());
            ps.executeUpdate();
                        
        } finally {
            try {
                if (ps != null)
                    ps.close();
            } finally {
                DBConnector.releaseConnection(conn);
            }
        }
    }

    public Integer doSaveAndRetrieveId(OrdineBean product) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;

        String insertSQL = "INSERT INTO Ordine(Cliente, DataPrenotazione, CostoTotale) VALUES(?,?,?);";

        try {
            conn = DBConnector.getConnection();
            ps = conn.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, product.getCliente());
            ps.setDate(2, Date.valueOf(product.getDataPrenotazione()));
            ps.setDouble(3, product.getCostoTotale());
            ps.executeUpdate();
            
            ResultSet rs = ps.getGeneratedKeys();
            while(rs.next()) {
            	return rs.getInt(1);
            }
        } finally {
            try {
                if (ps != null)
                    ps.close();
            } finally {
                DBConnector.releaseConnection(conn);
            }
        }
		return -1;
    }
    
    @Override
    public void doUpdate(OrdineBean product) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;

        String updateSQL = "UPDATE Ordine SET Codice = ?, Cliente = ?, DataPrenotazione = ?, CostoTotale = ?;";

        try {
            conn = DBConnector.getConnection();
            ps = conn.prepareStatement(updateSQL);

            ps.setInt(1, product.getCodice());
            ps.setString(2, product.getCliente());
            ps.setDate(3, Date.valueOf(product.getDataPrenotazione()));
            ps.setDouble(4, product.getCostoTotale());
            ps.executeUpdate();
            
        } finally {
            try {
                if (ps != null)
                    ps.close();
            } finally {
                DBConnector.releaseConnection(conn);
            }
        }
    }

    @Override
    public boolean doDelete(Integer codice) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;

        String deleteSQL = "DELETE FROM Ordine WHERE Codice = ?;";
        int res = 0;

        try {
            conn = DBConnector.getConnection();
            ps = conn.prepareStatement(deleteSQL);

            ps.setInt(1, codice);
            
            res = ps.executeUpdate();
            
        } finally {
            try {
                if (ps != null)
                    ps.close();
            } finally {
                DBConnector.releaseConnection(conn);
            }
        }
        return res != 0 ? true : false;
    }
}
