package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;
import java.time.LocalDateTime;
import database.DBConnector;
import model.bean.TravelPackageBean;

public class TravelPackageDAO implements DAO<TravelPackageBean, Integer> {


	
	@Override
	public TravelPackageBean doRetrieveByKey(Integer codice) throws SQLException {
		throw new UnsupportedOperationException();
	}

	public TravelPackageBean doRetrieveByKey(Integer codicePacchetto, LocalDateTime dataCreazione) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		TravelPackageBean tp = new TravelPackageBean();

		String query = "SELECT * FROM PacchettoViaggio WHERE Codice = ? AND DataCreazione = ?";
		
		try {
			con = DBConnector.getConnection();
			ps = con.prepareStatement(query);
			ps.setInt(1, codicePacchetto);
			ps.setTimestamp(2, Timestamp.valueOf(dataCreazione));

			rs = ps.executeQuery();

			while (rs.next()) {
				
					tp.setCodice(rs.getInt("Codice"));
					tp.setCosto(rs.getFloat("Costo"));
					tp.setNome(rs.getString("Nome"));
					tp.setDescrizione(rs.getString("Descrizione"));
					tp.setCittà(rs.getString("Citta"));
					tp.setNazione(rs.getString("Nazione"));
					tp.setDurata(rs.getInt("Durata"));
					tp.setVoloIncluso(rs.getBoolean("VoloIncluso"));
					tp.setDettagliVolo(rs.getString("DettagliVolo"));
					tp.setDettagliPernottamento(rs.getString("DettagliPernottamento"));
					tp.setPensione(rs.getString("Pensione"));
					tp.setDataCreazione(rs.getTimestamp("DataCreazione").toLocalDateTime());
					tp.setValido(rs.getBoolean("Valido"));
			
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {
				DBConnector.releaseConnection(con);
				if (ps != null)
					ps.close();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}

		}
		return tp;

	}

	// restituisce tra le versioni di pacchettoviaggio quella valida
	public TravelPackageBean doRetrievePackageByPackageKey(Integer codice) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		TravelPackageBean tp = new TravelPackageBean();

		String query = "SELECT * FROM PacchettoViaggio WHERE Codice = ?";
		
		try {
			con = DBConnector.getConnection();
			ps = con.prepareStatement(query);
			ps.setInt(1, codice);

			rs = ps.executeQuery();

			while (rs.next()) {
				if(rs.getBoolean("Valido")) {
					tp.setCodice(rs.getInt("Codice"));
					tp.setCosto(rs.getFloat("Costo"));
					tp.setNome(rs.getString("Nome"));
					tp.setDescrizione(rs.getString("Descrizione"));
					tp.setCittà(rs.getString("Citta"));
					tp.setNazione(rs.getString("Nazione"));
					tp.setDurata(rs.getInt("Durata"));
					tp.setVoloIncluso(rs.getBoolean("VoloIncluso"));
					tp.setDettagliVolo(rs.getString("DettagliVolo"));
					tp.setDettagliPernottamento(rs.getString("DettagliPernottamento"));
					tp.setPensione(rs.getString("Pensione"));
					tp.setDataCreazione(rs.getTimestamp("DataCreazione").toLocalDateTime());
					tp.setValido(rs.getBoolean("Valido"));
				}
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {
				DBConnector.releaseConnection(con);
				if (ps != null)
					ps.close();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}

		}
		return tp;

	}

	
	public Collection<TravelPackageBean> doRetrieveAllValidPackages() throws SQLException {
		Collection<TravelPackageBean> packages = this.doRetrieveAll();
		return packages.stream().filter(tp -> tp.isValido()).collect(Collectors.toList());
	}
	
	@Override
	public Collection<TravelPackageBean> doRetrieveAll() throws SQLException {

		Connection con = null;
		Statement st = null;
		ResultSet rs = null;

		String query = "SELECT * FROM PacchettoViaggio";

		Collection<TravelPackageBean> collection = new ArrayList<TravelPackageBean>();

		try {
			con = DBConnector.getConnection();
			st = con.createStatement();
			rs = st.executeQuery(query);

			while (rs.next()) {
				TravelPackageBean tp = new TravelPackageBean();

				tp.setCodice(rs.getInt("Codice"));
				tp.setCosto(rs.getFloat("Costo"));
				tp.setNome(rs.getString("Nome"));
				tp.setDescrizione(rs.getString("Descrizione"));
				tp.setCittà(rs.getString("Citta"));
				tp.setNazione(rs.getString("Nazione"));
				tp.setDurata(rs.getInt("Durata"));
				tp.setVoloIncluso(rs.getBoolean("VoloIncluso"));
				tp.setDettagliVolo(rs.getString("DettagliVolo"));
				tp.setDettagliPernottamento(rs.getString("DettagliPernottamento"));
				tp.setPensione(rs.getString("Pensione"));
				tp.setDataCreazione(rs.getTimestamp("DataCreazione").toLocalDateTime());
				tp.setValido(rs.getBoolean("Valido"));
				
				collection.add(tp);

			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {
				DBConnector.releaseConnection(con);
				if (st != null)
					st.close();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}

		}
		return collection;

	}

	@Override
	public void doSave(TravelPackageBean tp) throws SQLException {

		Connection con = null;
		PreparedStatement ps = null;

		String query = "INSERT INTO PacchettoViaggio(Codice, Costo, Nome, Descrizione, Citta, Nazione, Durata, VoloIncluso, DettagliVolo, DettagliPernottamento, Pensione, Valido) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			con = DBConnector.getConnection();
			ps = con.prepareStatement(query);
			
			ps.setInt(1, tp.getCodice());
			ps.setDouble(2, tp.getCosto());
			ps.setString(3, tp.getNome());
			ps.setString(4, tp.getDescrizione());
			ps.setString(5, tp.getCittà());
			ps.setString(6, tp.getNazione());
			ps.setInt(7, tp.getDurata());
			ps.setBoolean(8, tp.isVoloIncluso());
			ps.setString(9, tp.getDettagliVolo());
			ps.setString(10, tp.getDettagliPernottamento());
			ps.setString(11, tp.getPensione());
			ps.setBoolean(12, true);
			// non va messo data creazione così prende il default in automatico
			// se faccio un inserimento di un nuovo pacchetto
			// automaticamente quello è il primo pacchetto valido 

			ps.executeUpdate();

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {
				DBConnector.releaseConnection(con);
				if (ps != null)
					ps.close();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}

		}

	}

	@Override
	public void doUpdate(TravelPackageBean tp) throws SQLException {
		try {
			this.doDelete(tp.getCodice());
			this.doSave(tp);
		} catch (Exception ex) {
			ex.printStackTrace();
		} 

	}

	@Override
	public boolean doDelete(Integer codice) throws SQLException {
		// devono essere invalidate tutte le istanze di pacchetto
		Connection con = null;
		PreparedStatement ps = null;
		int res = 0;
		
		String query = "UPDATE PacchettoViaggio SET Valido = false WHERE Codice = ?";

		try {
			con = DBConnector.getConnection(); 
			ps = con.prepareStatement(query);
			ps.setInt(1, codice);
			res = ps.executeUpdate();
			
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {
				DBConnector.releaseConnection(con);
				if (ps != null)
					ps.close();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}

		}

		return res != 0 ? true : false;
	}

}

