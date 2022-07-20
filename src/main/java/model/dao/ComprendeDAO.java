package model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.Collection;

import database.DBConnector;
import model.bean.ComprendeBean;

public class ComprendeDAO implements DAO<ComprendeBean, Integer> {
	
	@Override
	public void doSave(ComprendeBean product) throws SQLException{
        Connection conn = null;
        PreparedStatement ps = null;

        String insertSQL = "INSERT INTO Comprende(CodicePacchetto, CodiceOrdine, NumPersone, DataPartenza, Costo, DataCreazionePacchetto) VALUES(?,?,?,?,?,?)";

        try {
            conn = DBConnector.getConnection();
            ps = conn.prepareStatement(insertSQL);

            ps.setInt(1, product.getCodicePacchetto());
            ps.setInt(2, product.getCodiceOrdine());
            ps.setInt(3, product.getNumPersone());
            ps.setDate(4, Date.valueOf(product.getDataPartenza()));
            ps.setDouble(5, product.getCosto());
            ps.setTimestamp(6, Timestamp.valueOf(product.getDataCreazione()));

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

	public Collection<ComprendeBean> doRetrieveAllByOrder(Integer codice) {
		
		Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
		
        Collection<ComprendeBean> comprendeCollection = new ArrayList<ComprendeBean>();
        
        String query="SELECT * FROM Comprende WHERE CodiceOrdine = ?";
        
        
        try {
            con = DBConnector.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, codice);
           
            rs = ps.executeQuery();
            
            while(rs.next()) {
            	
            	ComprendeBean comprendeItem = new ComprendeBean();
            	
            	comprendeItem.setCodiceOrdine(rs.getInt("CodiceOrdine"));
            	comprendeItem.setCodicePacchetto(rs.getInt("CodicePacchetto"));
            	comprendeItem.setCosto(rs.getDouble("Costo"));
            	comprendeItem.setDataPartenza(rs.getDate("DataPartenza").toLocalDate());
            	comprendeItem.setNumPersone(rs.getInt("NumPersone"));
            	comprendeItem.setDataCreazione(rs.getTimestamp("DataCreazionePacchetto").toLocalDateTime());
            	
            	comprendeCollection.add(comprendeItem);
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
        return comprendeCollection;
	}

	@Override
	public ComprendeBean doRetrieveByKey(Integer codice) throws SQLException {
		throw new UnsupportedOperationException();
	}

	@Override
	public Collection<ComprendeBean> doRetrieveAll() throws SQLException {
		throw new UnsupportedOperationException();
	}

	@Override
	public void doUpdate(ComprendeBean product) throws SQLException {
		throw new UnsupportedOperationException();
	}

	@Override
	public boolean doDelete(Integer codice) throws SQLException {
		throw new UnsupportedOperationException();
	}
	
}
