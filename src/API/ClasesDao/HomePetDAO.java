
package API.ClasesDao;

import API.ClasesBases.HomePet;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import API.conexion.conexionclass;
import java.sql.PreparedStatement;

public class HomePetDAO {

	private final String SQL_INSERT = "INSERT INTO Homepets(RIF, Nombre, Ciudad, Sector, Cod_Animal, Capacidad) VALUES (?,?,?,?,?,?)";
	private final String SQL_SELECT = "SELECT rif,nombre,ciudad,sector,cod_animal,Capacidad FROM HomePets ORDER BY Rif";
	private final String SQL_DELETE = "DELETE FROM HomePets WHERE Rif=?";
	private final String SQL_UPDATE = "UPDATE HomePets SET rif=?,nombre=?,ciudad=?,sector=?,cod_animal=?,Capacidad=?";


	public boolean registrar(HomePet homepet) {
		boolean registrar = false;

		Connection conn=null;
		PreparedStatement stmt =null;
		int rows =0;
		try {
			conn = conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_INSERT);
			int index =1;
			stmt.setString(index++,homepet.getRif());
			stmt.setString(index++,homepet.getNombre());
			stmt.setString(index++,homepet.getCiudad());
			stmt.setString(index++,homepet.getSector());
			stmt.setString(index++,homepet.getCod_animal());
			stmt.setInt(index++,homepet.getCapacidad());
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

	public List<HomePet> obtener() {
		Connection conn =null;
		PreparedStatement stmt= null;
		ResultSet rs=null;
		List<HomePet> lista= new ArrayList<HomePet>();
		try {
			conn= conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_SELECT);
			rs=stmt.executeQuery();
			while (rs.next()) {
				HomePet c=new HomePet();
				c.setRif(rs.getString(1));
				c.setNombre(rs.getString(2));
				c.setCiudad(rs.getString(3));
				c.setSector(rs.getString(4));
				c.setCod_animal(rs.getString(5));
				c.setCapacidad(rs.getInt(6));
				lista.add(c);
			}
			stmt.close();
			rs.close();
			conn.close();
		} catch (SQLException e) {
			System.out.println("Error: Clase homepet, método obtener");
			e.printStackTrace();
		}

		return lista;
	}


	public boolean actualizar(HomePet homepet) {
		boolean actualizar=false;
		Connection conn= null;
		PreparedStatement stmt= null;
		int rows =0;
		try {
			conn=conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_UPDATE);
			int index =1;
			stmt.setString(index++,homepet.getRif());
			stmt.setString(index++,homepet.getNombre());
			stmt.setString(index++,homepet.getCiudad());
			stmt.setString(index++,homepet.getSector());
			stmt.setString(index++,homepet.getCod_animal());
			stmt.setInt(index++,homepet.getCapacidad());
			rows=stmt.executeUpdate();
			stmt.close();
			conn.close();
			actualizar=true;
		} catch (SQLException e) {
			System.out.println("Error: Clase homepet, método actualizar");
			e.printStackTrace();
		}
		return actualizar;
	}


	public boolean eliminar(HomePet homepet) {
		boolean eliminar=false;
		Connection conn= null;
		PreparedStatement stmt= null;
		int rows = 0;
		try {
			conn=conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_DELETE);
			stmt.setString(1, homepet.getRif());
			rows = stmt.executeUpdate();
			stmt.close();
			conn.close();
			eliminar=true;
		} catch (SQLException e) {
			System.out.println("Error: Clase homepet, método eliminar");
			e.printStackTrace();
		}
		return eliminar;
	}

}
    

