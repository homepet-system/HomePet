package API.ClasesDao;

import API.ClasesBases.FichaReg;
import API.conexion.conexionclass;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FichaRegDAO {

	private final String SQL_INSERT = "INSERT INTO Ficha_Registro (Cod_Registro, Fecha_E, Hora_E, Fecha_SEst, Hora_SEst, Fecha_SReal, Hora_SReal) VALUES (?,?,?,?,?,?,?)";
	private final String SQL_SELECT = "SELECT Cod_Registro, Fecha_E, Hora_E, Fecha_SEst, Hora_SEst, Fecha_SReal, Hora_SReal FROM Ficha_Registro ORDER BY Cod_Registro";
	private final String SQL_DELETE = "DELETE FROM Ficha_Registro WHERE Cod_Registro=?";
	private final String SQL_UPDATE = "UPDATE Ficha_Registro SET Cod_Registro=?, Fecha_E=?, Hora_E=?, Fecha_SEst=?, Hora_SEst=?, Fecha_SReal=?, Hora_SReal=? WHERE Cod_Registro=?";

	public boolean registrar(FichaReg fichareg) {
		boolean registrar = false;

		Connection conn=null;
		PreparedStatement stmt =null;
		int rows =0;
		try {
			conn = conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_INSERT);
			int index =1;
			stmt.setString(index++,fichareg.getCod_Registro());
			stmt.setString(index++,fichareg.getFecha_E());
			stmt.setString(index++,fichareg.getHora_E());
			stmt.setString(index++,fichareg.getFecha_SEst());
			stmt.setString(index++,fichareg.getHora_SEst());
			stmt.setString(index++,fichareg.getFecha_SReal());
			stmt.setString(index++,fichareg.getHora_SReal());
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

	public List<FichaReg> obtener() {
		Connection conn =null;
		PreparedStatement stmt= null;
		ResultSet rs=null;
		List<FichaReg> lista= new ArrayList<FichaReg>();
		try {
			conn= conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_SELECT);
			rs=stmt.executeQuery();
			while (rs.next()) {
				FichaReg c=new FichaReg();
				c.setCod_Registro(rs.getString(1));
				c.setFecha_E(rs.getString(2));
				c.setHora_E(rs.getString(3));
				c.setFecha_SEst(rs.getString(4));
				c.setHora_SEst(rs.getString(5));
				c.setFecha_SReal(rs.getString(6));
				c.setHora_SReal(rs.getString(7));
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


	public boolean actualizar(FichaReg fichareg) {
		boolean actualizar=false;
		Connection conn= null;
		PreparedStatement stmt= null;
		int rows =0;
		try {
			conn=conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_UPDATE);
			int index =1;
			stmt.setString(index++,fichareg.getCod_Registro());
			stmt.setString(index++,fichareg.getFecha_E());
			stmt.setString(index++,fichareg.getHora_E());
			stmt.setString(index++,fichareg.getFecha_SEst());
			stmt.setString(index++,fichareg.getHora_SEst());
			stmt.setString(index++,fichareg.getFecha_SReal());
			stmt.setString(index++,fichareg.getHora_SReal());
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


	public boolean eliminar(FichaReg fichareg) {
		boolean eliminar=false;
		Connection conn= null;
		PreparedStatement stmt= null;
		int rows = 0;
		try {
			conn=conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_DELETE);
			stmt.setString(1, fichareg.getCod_Registro());
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
