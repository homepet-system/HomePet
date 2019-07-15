
package API.ClasesDao;

import API.ClasesBases.Modalidad;
import API.conexion.conexionclass;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class ModalidadDAO {

	private final String SQL_INSERT = "INSERT INTO Modalidades(Cod_Factura, Fecha, Monto, Tipo_M, Numero) VALUES (?,?,?,?,?);";
	private final String SQL_SELECT = "SELECT Cod_Factura, Fecha, Monto, Tipo_M, Numero FROM Modalidades ORDER BY Cod_Factura";
	private final String SQL_DELETE = "DELETE FROM Modalidades WHERE Cod_Factura";
	private final String SQL_UPDATE = "UPDATE Modalidades SET Cod_Factura=?, Fecha=?, Monto=?, Tipo_M=?, Numero=? WHERE Cod_Factura";

	public boolean registrar(Modalidad modalidad) {
		boolean registrar = false;

		Connection conn=null;
		PreparedStatement stmt =null;
		int rows =0;
		try {
			conn = conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_INSERT);
			int index =1;
			stmt.setString(index++,modalidad.getCod_Factura());
			stmt.setString(index++,modalidad.getFecha());
			stmt.setInt(index++,modalidad.getMonto());
			stmt.setString(index++,modalidad.getTipo_M());
			stmt.setString(index++,modalidad.getNumero());
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

	public List<Modalidad> obtener() {
		Connection conn =null;
		PreparedStatement stmt= null;
		ResultSet rs=null;
		List<Modalidad> lista= new ArrayList<Modalidad>();
		try {
			conn= conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_SELECT);
			rs=stmt.executeQuery();
			while (rs.next()) {
				Modalidad c=new Modalidad();
				c.setCod_Factura(rs.getString(1));
				c.setFecha(rs.getString(2));
				c.setMonto(rs.getInt(3));
				c.setTipo_M(rs.getString(4));
				c.setNumero(rs.getString(5));
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


	public boolean actualizar(Modalidad modalidad) {
		boolean actualizar=false;
		Connection conn= null;
		PreparedStatement stmt= null;
		int rows =0;
		try {
			conn=conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_UPDATE);
			int index =1;
			stmt.setString(index++,modalidad.getCod_Factura());
			stmt.setString(index++,modalidad.getFecha());
			stmt.setInt(index++,modalidad.getMonto());
			stmt.setString(index++,modalidad.getTipo_M());
			stmt.setString(index++,modalidad.getNumero());
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


	public boolean eliminar(Modalidad modalidad) {
		boolean eliminar=false;
		Connection conn= null;
		PreparedStatement stmt= null;
		int rows = 0;
		try {
			conn=conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_DELETE);
			stmt.setString(1, modalidad.getCod_Factura());
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
