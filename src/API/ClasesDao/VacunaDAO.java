
package API.ClasesDao;

import API.ClasesBases.Vacuna;
import API.conexion.conexionclass;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VacunaDAO {

	private final String SQL_INSERT = "Insert INTO Vacunas (Cod_Vacuna, Nombre_Vacuna, Descripcion_Vacuna) VALUES (?,?,?)";
	private final String SQL_SELECT = "SELECT Cod_Vacuna, Nombre_Vacuna, Descripcion_Vacuna FROM Vacunas ORDER BY Cod_Vacuna";
	private final String SQL_DELETE = "DELETE FROM Vacunas WHERE Cod_Vacuna=?";
	private final String SQL_UPDATE = "UPDATE Vacunas SET Cod_Vacuna=?, Nombre_Vacuna=?, Descripcion_Vacuna=? WHERE Nombre_Enfermedad=?";

	public boolean registrar(Vacuna vacuna) {
		boolean registrar = false;

		Connection conn=null;
		PreparedStatement stmt =null;
		int rows =0;
		try {
			conn = conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_INSERT);
			int index =1;
			stmt.setString(index++,vacuna.getCod_Vacuna());
			stmt.setString(index++,vacuna.getNombre_Vacuna());
			stmt.setString(index++,vacuna.getDescripcion_Vacuna());
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

	public List<Vacuna> obtener() {
		Connection conn =null;
		PreparedStatement stmt= null;
		ResultSet rs=null;
		List<Vacuna> lista= new ArrayList<Vacuna>();
		try {
			conn= conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_SELECT);
			rs=stmt.executeQuery();
			while (rs.next()) {
				Vacuna c=new Vacuna();
				c.setCod_Vacuna(rs.getString(1));
				c.setNombre_Vacuna(rs.getString(2));
				c.setDescripcion_Vacuna(rs.getString(3));
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


	public boolean actualizar(Vacuna vacuna) {
		boolean actualizar=false;
		Connection conn= null;
		PreparedStatement stmt= null;
		int rows =0;
		try {
			conn=conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_UPDATE);
			int index =1;
			stmt.setString(index++,vacuna.getCod_Vacuna());
			stmt.setString(index++,vacuna.getNombre_Vacuna());
			stmt.setString(index++,vacuna.getDescripcion_Vacuna());
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


	public boolean eliminar(Vacuna vacuna) {
		boolean eliminar=false;
		Connection conn= null;
		PreparedStatement stmt= null;
		int rows = 0;
		try {
			conn=conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_DELETE);
			stmt.setString(1, vacuna.getCod_Vacuna());
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
