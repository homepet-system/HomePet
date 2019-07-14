
package API.ClasesDao;

import API.ClasesBases.Raza;
import API.conexion.conexionclass;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RazaDAO {

    private final String SQL_INSERT = "INSERT INTO Razas(Cod_animal,Cod_Raza,Nombre,Pais_Origen,Descripcion,Talla,Cntxt_Frt,Nivel_Int,Color_Plj,Rango_Altura,Rango_Peso) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
    private final String SQL_SELECT = "SELECT Cod_animal,Cod_Raza,Nombre,Pais_Origen,Descripcion,Talla,Cntxt_Frt,Nivel_Int,Color_Plj,Rango_Altura,Rango_Peso Descripcion FROM Animal ORDER BY Cod_animal,Cod_Raza";
    private final String SQL_DELETE = "DELETE FROM Razas WHERE Cod_Raza=?";
    private final String SQL_UPDATE = "UPDATE Razas SET Cod_animal=?,Cod_Raza=?,Nombre=?,Pais_Origen=?,Descripcion=?,Talla=?,Cntxt_Frt=?,Nivel_Int=?,Color_Plj=?,Rango_Altura=?,Rango_Peso=? WHERE Cod_Raza=?";

    public boolean registrar(Raza raza) {
        boolean registrar = false;

        Connection conn=null;
        PreparedStatement stmt =null;
        int rows =0;
        try {
            conn = conexionclass.conectar();
            stmt=conn.prepareStatement(SQL_INSERT);
            int index =1;
            stmt.setString(index++,raza.getCod_animal());
            stmt.setString(index++,raza.getCod_Raza());
            stmt.setString(index++,raza.getNombre());
            stmt.setString(index++,raza.getPais_Origen());
            stmt.setString(index++,raza.getDescripcion());
            stmt.setString(index++,raza.getTalla());
            stmt.setString(index++,raza.getCntxt_Frt());
            stmt.setString(index++,raza.getNivel_Int());
            stmt.setString(index++,raza.getColor_Plj());
            stmt.setString(index++,raza.getRango_Altura());
            stmt.setString(index++,raza.getRango_Peso());
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

    public List<Raza> obtener() {
        Connection conn =null;
        PreparedStatement stmt= null;
        ResultSet rs=null;
        List<Raza> lista= new ArrayList<Raza>();
        try {
            conn= conexionclass.conectar();
            stmt=conn.prepareStatement(SQL_SELECT);
            rs=stmt.executeQuery();
            while (rs.next()) {
                Raza c=new Raza();
                c.setCod_animal(rs.getString(1));
                c.setCod_Raza(rs.getString(2));
                c.setNombre(rs.getString(3));
                c.setPais_Origen(rs.getString(4));
                c.setDescripcion(rs.getString(5));
                c.setTalla(rs.getString(6));
                c.setDescripcion(rs.getString(7));
                c.setCntxt_Frt(rs.getString(8));
                c.setNivel_Int(rs.getString(9));
                c.setRango_Altura(rs.getString(10));
                c.setRango_Peso(rs.getString(11));
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


    public boolean actualizar(Raza raza) {
        boolean actualizar=false;
        Connection conn= null;
        PreparedStatement stmt= null;
        int rows =0;
        try {
            conn=conexionclass.conectar();
            stmt=conn.prepareStatement(SQL_UPDATE);
            int index =1;
            stmt.setString(index++,raza.getCod_animal());
            stmt.setString(index++,raza.getCod_Raza());
            stmt.setString(index++,raza.getNombre());
            stmt.setString(index++,raza.getPais_Origen());
            stmt.setString(index++,raza.getDescripcion());
            stmt.setString(index++,raza.getTalla());
            stmt.setString(index++,raza.getCntxt_Frt());
            stmt.setString(index++,raza.getNivel_Int());
            stmt.setString(index++,raza.getColor_Plj());
            stmt.setString(index++,raza.getRango_Altura());
            stmt.setString(index++,raza.getRango_Peso());
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


    public boolean eliminar(Raza raza) {
        boolean eliminar=false;
        Connection conn= null;
        PreparedStatement stmt= null;
        int rows = 0;
        try {
            conn=conexionclass.conectar();
            stmt=conn.prepareStatement(SQL_DELETE);
            stmt.setString(1, raza.getCod_Raza());
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
