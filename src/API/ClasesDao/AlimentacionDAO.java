
package API.ClasesDao;

import API.ClasesBases.Alimentacion;
import API.conexion.conexionclass;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AlimentacionDAO {

    private final String SQL_INSERT = "INSERT INTO Alimentacion(Cod_Mascota,Tipo_Comida,Cantidad,Unidad) VALUES(?,?,?,?)";
    private final String SQL_SELECT = "SELECT Cod_Mascota,Tipo_Comida,Cantidad,Unidad FROM Alimentacion ORDER BY Tipo_Comida,Cod_Mascota";
    private final String SQL_DELETE = "DELETE FROM Alimentacion WHERE Cod_Mascota";
    private final String SQL_UPDATE = "UPDATE Alimentacion SET Cod_Mascota=?,Tipo_Comida=?,Cantidad=?,Unidad=? WHERE Cod_Mascota";

    public boolean registrar(Alimentacion aliment) {
        boolean registrar = false;

        Connection conn=null;
        PreparedStatement stmt =null;
        int rows =0;
        try {
            conn = conexionclass.conectar();
            stmt=conn.prepareStatement(SQL_INSERT);
            int index =1;
            stmt.setString(index++,aliment.getCod_Mascota());
            stmt.setString(index++,aliment.getTipo_Comida());
            stmt.setInt(index++,aliment.getCantidad());
            stmt.setString(index++,aliment.getUnidad());
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

    public List<Alimentacion> obtener() {
        Connection conn =null;
        PreparedStatement stmt= null;
        ResultSet rs=null;
        List<Alimentacion> lista= new ArrayList<Alimentacion>();
        try {
            conn= conexionclass.conectar();
            stmt=conn.prepareStatement(SQL_SELECT);
            rs=stmt.executeQuery();
            while (rs.next()) {
                Alimentacion c=new Alimentacion();
                c.setCod_Mascota(rs.getString(1));
                c.setTipo_Comida(rs.getString(2));
                c.setCantidad(rs.getInt(3));
                c.setUnidad(rs.getString(4));
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


    public boolean actualizar(Alimentacion aliment) {
        boolean actualizar=false;
        Connection conn= null;
        PreparedStatement stmt= null;
        int rows =0;
        try {
            conn=conexionclass.conectar();
            stmt=conn.prepareStatement(SQL_UPDATE);
            int index =1;
            stmt.setString(index++,aliment.getCod_Mascota());
            stmt.setString(index++,aliment.getTipo_Comida());
            stmt.setInt(index++,aliment.getCantidad());
            stmt.setString(index++,aliment.getUnidad());
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


    public boolean eliminar(Alimentacion aliment) {
        boolean eliminar=false;
        Connection conn= null;
        PreparedStatement stmt= null;
        int rows = 0;
        try {
            conn=conexionclass.conectar();
            stmt=conn.prepareStatement(SQL_DELETE);
            stmt.setString(1, aliment.getCod_Mascota());
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
