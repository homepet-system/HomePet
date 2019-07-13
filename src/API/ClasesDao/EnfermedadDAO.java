
package API.ClasesDao;

import API.ClasesBases.Enfermedad;
import API.conexion.conexionclass;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class EnfermedadDAO {

	private final String SQL_INSERT = "INSERT INTO Enfermedades (Nombre_Enfermedad, Descripcion_Enfermedad, Gravedad) VALUES (?,?,?)";
	private final String SQL_SELECT = "SELECT Nombre_Enfermedad, Descripcion_Enfermedad, Gravedad FROM Enfermedades ORDER BY Nombre_Enfermedad";
	private final String SQL_DELETE = "DELETE FROM Enfermedades WHERE Nombre_Enfermedad=?";
	private final String SQL_UPDATE = "UPDATE Enfermedades SET Nombre_Enfermedad=?, Descripcion_Enfermedad=?, Gravedad=? WHERE Nombre_Enfermedad=?";

	public boolean registrar(Enfermedad enfermedad) {
		boolean registrar = false;

		Connection conn=null;
		PreparedStatement stmt =null;
		int rows =0;
		try {
			conn = conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_INSERT);
			int index =1;
			stmt.setString(index++,enfermedad.getNombre_Enfermedad());
			stmt.setString(index++,enfermedad.getDescripcion_Enfermedad());
			stmt.setString(index++,enfermedad.getGravedad());
			stmt.setString(index++,enfermedad.getCura());
			rows=stmt.executeUpdate();
			registrar=true;
			stmt.close();
			conn.close();
		} catch (SQLException e) {
			System.out.println("Error: Clase HomepetDAO, método registrar");
			e.printStackTrace();
		}
		return registrar;
	}

	public List<Enfermedad> obtener() {
		Connection conn =null;
		PreparedStatement stmt= null;
		ResultSet rs=null;
		List<Enfermedad> lista= new ArrayList<Enfermedad>();
		try {
			conn= conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_SELECT);
			rs=stmt.executeQuery();
			while (rs.next()) {
				Enfermedad c=new Enfermedad();
				c.setNombre_Enfermedad(rs.getString(1));
				c.setNombre_Enfermedad(rs.getString(2));
				c.setDescripcion_Enfermedad(rs.getString(3));
				c.setCura(rs.getString(4));
				lista.add(c);
			}
			stmt.close();
			rs.close();
			conn.close();
		} catch (SQLException e) {
			System.out.println("Error: Clase AnimalDao, método obtener");
			e.printStackTrace();
		}

		return lista;
	}


	public boolean actualizar(Enfermedad enfermedad) {
		boolean actualizar=false;
		Connection conn= null;
		PreparedStatement stmt= null;
		int rows =0;
		try {
			conn=conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_UPDATE);
			int index =1;
			stmt.setString(index++,enfermedad.getNombre_Enfermedad());
			stmt.setString(index++,enfermedad.getDescripcion_Enfermedad());
			stmt.setString(index++,enfermedad.getGravedad());
			stmt.setString(index++,enfermedad.getCura());
			rows=stmt.executeUpdate();
			stmt.close();
			conn.close();
			actualizar=true;
		} catch (SQLException e) {
			System.out.println("Error: Clase AnimalDao, método actualizar");
			e.printStackTrace();
		}
		return actualizar;
	}


	public boolean eliminar(Enfermedad enfermedad) {
		boolean eliminar=false;
		Connection conn= null;
		PreparedStatement stmt= null;
		int rows = 0;
		try {
			conn=conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_DELETE);
			stmt.setString(1, enfermedad.getNombre_Enfermedad());
			rows = stmt.executeUpdate();
			stmt.close();
			conn.close();
			eliminar=true;
		} catch (SQLException e) {
			System.out.println("Error: Clase AnimalDao, método eliminar");
			e.printStackTrace();
		}
		return eliminar;
	}

}
