
package API.ClasesDao;

import API.ClasesBases.Empleado;
import API.conexion.conexionclass;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EmpleadoDAO {

	private final String SQL_INSERT = "INSERT INTO Empleados (Cedula, Nombre_Completo, Sueldo, Direccion, RIF_Homepet, Telefono) VALUES (?,?,?,?,?,?)";
	private final String SQL_SELECT = "SELECT Cedula, Nombre_Completo, Sueldo, Direccion, RIF_Homepet, Telefono FROM Empleados ORDER BY Cedula";
	private final String SQL_DELETE = "DELETE FROM Empleadso WHERE Cedula=?";
	private final String SQL_UPDATE = "UPDATE Empleados SET Cedula=?, Nombre_Completo=?, Sueldo=?, Direccion=?, RIF_Homepet=?, Telefono=? WHERE Cedula=?";


	public boolean registrar(Empleado empleado) {
		boolean registrar = false;

		Connection conn=null;
		PreparedStatement stmt =null;
		int rows =0;
		try {
			conn = conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_INSERT);
			int index =1;
			stmt.setString(index++,empleado.getCedula());
			stmt.setString(index++,empleado.getNombre());
			stmt.setInt(index++,empleado.getSueldo());
			stmt.setString(index++,empleado.getDireccion());
			stmt.setString(index++,empleado.getRif());
			stmt.setString(index++,empleado.getTelefono());
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

	public List<Empleado> obtener() {
		Connection conn =null;
		PreparedStatement stmt= null;
		ResultSet rs=null;
		List<Empleado> lista= new ArrayList<Empleado>();
		try {
			conn= conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_SELECT);
			rs=stmt.executeQuery();
			while (rs.next()) {
				Empleado c=new Empleado();
				c.setCedula(rs.getString(1));
				c.setNombre(rs.getString(2));
				c.setSueldo(rs.getInt(3));
				c.setDireccion(rs.getString(4));
				c.setRif(rs.getString(5));
				c.setTelefono(rs.getString(6));
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


	public boolean actualizar(Empleado empleado) {
		boolean actualizar=false;
		Connection conn= null;
		PreparedStatement stmt= null;
		int rows =0;
		try {
			conn=conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_UPDATE);
			int index =1;
			stmt.setString(index++,empleado.getCedula());
			stmt.setString(index++,empleado.getNombre());
			stmt.setInt(index++,empleado.getSueldo());
			stmt.setString(index++,empleado.getDireccion());
			stmt.setString(index++,empleado.getRif());
			stmt.setString(index++,empleado.getTelefono());
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


	public boolean eliminar(Empleado empleado) {
		boolean eliminar=false;
		Connection conn= null;
		PreparedStatement stmt= null;
		int rows = 0;
		try {
			conn=conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_DELETE);
			stmt.setString(1, empleado.getCedula());
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
