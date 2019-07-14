package API.ClasesDao;

import API.ClasesBases.Servicio;
import API.conexion.conexionclass;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ServicioDAO {

	private final String SQL_INSERT = "INSERT INTO Servicios(Cod_Servicio,Nombre,Descripcion) VALUES(?,?,?)";
	private final String SQL_SELECT = "SELECT Cod_Servicio,nombre,Descripcion FROM SERVICIOS ORDER BY Cod_Servicio";
	private final String SQL_DELETE = "DELETE FROM Servicios WHERE Cod_Servicio=?";
	private final String SQL_UPDATE = "UPDATE Servicios SET Cod_Servicio=?,nombre=?,descripcion=? WHERE Cod_Servicio=?";

	public boolean registrar(Servicio servicio) {
		boolean registrar = false;

		Connection conn=null;
		PreparedStatement stmt =null;
		int rows =0;
		try {
			conn = conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_INSERT);
			int index =1;
			stmt.setString(index++,servicio.getCod_srv());
			stmt.setString(index++,servicio.getNombre());
			stmt.setString(index++,servicio.getDescripcion());
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

	public List<Servicio> obtener() {
		Connection conn =null;
		PreparedStatement stmt= null;
		ResultSet rs=null;
		List<Servicio> lista= new ArrayList<Servicio>();
		try {
			conn= conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_SELECT);
			rs=stmt.executeQuery();
			while (rs.next()) {
				Servicio c=new Servicio();
				c.setCod_srv(rs.getString(1));
				c.setNombre(rs.getString(2));
				c.setDescripcion(rs.getString(3));
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


	public boolean actualizar(Servicio servicio) {
		boolean actualizar=false;
		Connection conn= null;
		PreparedStatement stmt= null;
		int rows =0;
		try {
			conn=conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_UPDATE);
			int index =1;
			stmt.setString(index++,servicio.getCod_srv());
			stmt.setString(index++,servicio.getNombre());
			stmt.setString(index++,servicio.getDescripcion());
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


	public boolean eliminar(Servicio servicio) {
		boolean eliminar=false;
		Connection conn= null;
		PreparedStatement stmt= null;
		int rows = 0;
		try {
			conn=conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_DELETE);
			stmt.setString(1,servicio.getCod_srv());
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
