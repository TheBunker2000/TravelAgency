package database;

import java.sql.*;
import java.util.*;

/**
 * Classe che implementa una ConnectionPool
 * Il costruttore accetta i parametri per creare una connessione al database.
 */
public class DBConnector {

    private static final List<Connection> free;

    static {
        free = new LinkedList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            System.err.print(e.getMessage());
        }
    }
    

    private static Connection createConnection() throws SQLException {
        String ip = "localhost";
        String port = "3306";
        String fallback_port = "13306";
        String db = "TravelAgency";
        String username = "esame";
        String password = "Esame2022!";
        String params = "";
       
        Connection connection;
        
        try {
        	connection = DriverManager.getConnection("jdbc:mysql://" + ip + ":" + port + "/" + db + params,username, password);
        } catch(SQLException ex) {
        	connection = DriverManager.getConnection("jdbc:mysql://" + ip + ":" + fallback_port + "/" + db + params,username, password);
        }
        connection.setAutoCommit(true);
        return connection;
    }

    public static synchronized Connection getConnection() throws SQLException {
        Connection connection = null;
        if (!free.isEmpty()) {
            connection = free.get(0);
            DBConnector.free.remove(0);

            try {
            	if (connection != null && connection.isClosed()) {
                    connection = DBConnector.getConnection();
                }
            } catch (SQLException ex) {
                if (connection != null) {
                    connection.close();
                }
                connection = DBConnector.getConnection();
            }
        } else {
            connection = DBConnector.createConnection();
        }

        return connection;

    }

    public static synchronized void releaseConnection(Connection connection){
        DBConnector.free.add(connection);
    }


}
