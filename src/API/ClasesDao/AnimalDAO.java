
package API.ClasesDao;

import API.ClasesBases.Animal;
import API.conexion.conexionclass;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class AnimalDAO {

	private final String SQL_INSERT = "INSERT INTO Animal(Cod_animal,Descripcion) VALUES(?,?)";
	private final String SQL_SELECT = "SELECT Cod_Animal, Descripcion FROM Animal ORDER BY Cod_Animal";
	private final String SQL_DELETE = "DELETE FROM Animal WHERE Cod_animal=?";
	private final String SQL_UPDATE = "UPDATE Animal SET Cod_animal=?, Descripcion=? WHERE Cod_animal=?";

	public boolean registrar(Animal animal) {
		boolean registrar = false;

		Connection conn=null;
		PreparedStatement stmt =null;
		int rows =0;
		try {
			conn = conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_INSERT);
			int index =1;
			stmt.setString(index++,animal.getCod_animal());
			stmt.setString(index++,animal.getDescripcion());
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

	public List<Animal> obtener() {
		Connection conn =null;
		PreparedStatement stmt= null;
		ResultSet rs=null;
		List<Animal> lista= new ArrayList<Animal>();
		try {
			conn= conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_SELECT);
			rs=stmt.executeQuery();
			while (rs.next()) {
				Animal c=new Animal();
				c.setCod_animal(rs.getString(1));
				c.setDescripcion(rs.getString(2));
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


	public boolean actualizar(Animal animal) {
		boolean actualizar=false;
		Connection conn= null;
		PreparedStatement stmt= null;
		int rows =0;
		try {
			conn=conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_UPDATE);
			int index =1;
			stmt.setString(index++,animal.getCod_animal());
			stmt.setString(index++,animal.getDescripcion());
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


	public boolean eliminar(Animal animal) {
		boolean eliminar=false;
		Connection conn= null;
		PreparedStatement stmt= null;
		int rows = 0;
		try {
			conn=conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_DELETE);
			stmt.setString(1, animal.getCod_animal());
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
