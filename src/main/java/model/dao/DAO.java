package model.dao;

import java.sql.SQLException;
import java.util.Collection;

public interface DAO<T,K> {

	public T doRetrieveByKey(K codice) throws SQLException;
	public Collection<T> doRetrieveAll() throws SQLException;
	public void doSave(T product) throws SQLException;
	public void doUpdate(T product) throws SQLException;
	public boolean doDelete(K codice) throws SQLException;
	
}
