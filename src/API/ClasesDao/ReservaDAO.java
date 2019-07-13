
package API.ClasesDao;

import API.ClasesBases.Reserva;
import API.conexion.conexionclass;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReservaDAO {

	private final String SQL_INSERT = "INSERT INTO RESERVAS(cod_reserva,Fecha_resrv,Fecha_act_r,Monto_abonado,Monto_total) VALUES(?,?,?,?,?)";
	private final String SQL_SELECT = "SELECT cod_reserva,Fecha_resrv,Fecha_act_r,Monto_abonado,Monto_total FROM Reservas ORDER BY Cod_Reserva";
	private final String SQL_DELETE = "DELETE FROM Reservas WHERE cod_reserva=?";
	private final String SQL_UPDATE = "UPDATE Reservas SET cod_reserva=?,Fecha_resrv=?,Fecha_act_r=?,Monto_abonado=?,Monto_total=?";


	public boolean registrar(Reserva reserva) {
		boolean registrar = false;

		Connection conn=null;
		PreparedStatement stmt =null;
		int rows =0;
		try {
			conn = conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_INSERT);
			int index =1;
			stmt.setString(index++,reserva.getCod_reserva());
			stmt.setString(index++,reserva.getFecha_reser());
			stmt.setString(index++,reserva.getFecha_act_r());
			stmt.setInt(index++,reserva.getMonto_abonado());
			stmt.setInt(index++,reserva.getMonto_total());
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

	public List<Reserva> obtener() {
		Connection conn =null;
		PreparedStatement stmt= null;
		ResultSet rs=null;
		List<Reserva> lista= new ArrayList<Reserva>();
		try {
			conn= conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_SELECT);
			rs=stmt.executeQuery();
			while (rs.next()) {
				Reserva c=new Reserva();
				c.setCod_reserva(rs.getString(1));
				c.setFecha_reser(rs.getString(2));
				c.setFecha_act_r(rs.getString(3));
				c.setMonto_abonado(rs.getInt(4));
				c.setMonto_total(rs.getInt(5));
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


	public boolean actualizar(Reserva reserva) {
		boolean actualizar=false;
		Connection conn= null;
		PreparedStatement stmt= null;
		int rows =0;
		try {
			conn=conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_UPDATE);
			int index =1;
			stmt.setString(index++,reserva.getCod_reserva());
			stmt.setString(index++,reserva.getFecha_reser());
			stmt.setString(index++,reserva.getFecha_act_r());
			stmt.setInt(index++,reserva.getMonto_abonado());
			stmt.setInt(index++,reserva.getMonto_total());
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


	public boolean eliminar(Reserva reserva) {
		boolean eliminar=false;
		Connection conn= null;
		PreparedStatement stmt= null;
		int rows = 0;
		try {
			conn=conexionclass.conectar();
			stmt=conn.prepareStatement(SQL_DELETE);
			stmt.setString(1,reserva.getCod_reserva());
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
