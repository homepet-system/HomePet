
package API.conexion;

import javafx.scene.control.Alert;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class conexionclass {

	private static final String URL = "jdbc:postgresql://localhost:5432/Homepetdb";
	private static final String USER = "postgres";
	private static final String PASSWORD = "";

	public static Connection conectar() {
		Connection con = null;
		try {
			Class.forName("org.postgresql.Driver");
			con = DriverManager.getConnection(URL, USER,PASSWORD);
			if (con != null) {
				Alert information = new Alert(Alert.AlertType.INFORMATION);
				information.setTitle("Conexion Exitosa");
				information.setHeaderText(null);
				information.setContentText("Se ha conetado exitosamente");
			}
		} catch (SQLException e) {
			Alert information = new Alert(Alert.AlertType.INFORMATION);
			information.setTitle("Conexion Fallida");
			information.setHeaderText(null);
			information.setContentText("No se ha podido conectar a la base de datos");
			e.printStackTrace();
		} catch (ClassNotFoundException ex) {
			Logger.getLogger(conexionclass.class.getName()).log(Level.SEVERE, null, ex);
		}
		return con;
	}

}
