
package API.ClasesDao;

import API.ClasesBases.Mascota;
import API.conexion.conexionclass;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MascotaDAO {

	private final String SQL_INSERT = "INSERT INTO Mascotas (Cod_Mascota, Nombre, Fecha_Nac, Tipo_Animal, Sexo, Cedula_Duenio, Cod_Raza, Cedula_Vet) VALUES (?,?,?,?,?,?,?,?)";
	private final String SQL_SELECT = "SELECT Cod_Mascotas, Nombre, Fecha_Nac, Tipo_Animal, Sexo, Cedula_Duenio, Cod_Raza, Cedula_Vet FROM Mascotas ORDER BY Cod_masc";
	private final String SQL_DELETE = "DELETE FROM Mascotas WHERE Cod_masc=?";
	private final String SQL_UPDATE = "UPDATE Mascotas SET Cod_Mascota=?, Nombre=?, Fecha_Nac=?, Tipo_Animal=?, Sexo=?, Cedula_Duenio=?, Cod_Raza=?, Cedula_Vet=? WHERE Cod_Mascota=?";

	public boolean registrar(Mascota mascota) {
		boolean registrar = false;

		Connection conn=null;
		PreparedStatement stmt =null;
		int rows =0;
		try {
			conn = conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_INSERT);
			int index =1;
			stmt.setString(index++,mascota.getCod_mascota());
			stmt.setString(index++,mascota.getNombre());
			stmt.setString(index++,mascota.getFecha_nac());
			stmt.setString(index++,mascota.getTipo_animal());
			stmt.setString(index++,mascota.getSexo());
			stmt.setString(index++,mascota.getCedula_dueño());
			stmt.setString(index++,mascota.getCod_raza());
			stmt.setString(index++,mascota.getCedula_vet());
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

	public List<Mascota> obtener() {
		Connection conn =null;
		PreparedStatement stmt= null;
		ResultSet rs=null;
		List<Mascota> lista= new ArrayList<Mascota>();
		try {
			conn= conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_SELECT);
			rs=stmt.executeQuery();
			while (rs.next()) {
				Mascota c=new Mascota();
				c.setCod_mascota(rs.getString(1));
				c.setNombre(rs.getString(2));
				c.setFecha_nac(rs.getString(3));
				c.setTipo_animal(rs.getString(4));
				c.setSexo(rs.getString(5));
				c.setCedula_dueño(rs.getString(6));
				c.setCod_raza(rs.getNString(7));
				c.setCedula_vet(rs.getString(8));
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


	public boolean actualizar( Mascota mascota) {
		boolean actualizar=false;
		Connection conn= null;
		PreparedStatement stmt= null;
		int rows =0;
		try {
			conn=conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_UPDATE);
			int index =1;
			stmt.setString(index++,mascota.getCod_mascota());
			stmt.setString(index++,mascota.getNombre());
			stmt.setString(index++,mascota.getFecha_nac());
			stmt.setString(index++,mascota.getTipo_animal());
			stmt.setString(index++,mascota.getSexo());
			stmt.setString(index++,mascota.getCedula_dueño());
			stmt.setString(index++,mascota.getCod_raza());
			stmt.setString(index++,mascota.getCedula_vet());
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


	public boolean eliminar(Mascota mascota) {
		boolean eliminar=false;
		Connection conn= null;
		PreparedStatement stmt= null;
		int rows = 0;
		try {
			conn=conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_DELETE);
			stmt.setString(1, mascota.getCod_mascota());
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
