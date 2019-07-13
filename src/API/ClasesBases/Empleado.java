
package API.ClasesBases;


import java.util.Calendar;


public class Empleado {
    
    private String cedula;
    private String nombre;
    private int sueldo;
    private String direccion;
    private String rif;
    private String telefono;

    public Empleado() {
        this.cedula = "";
        this.nombre = "";
        this.sueldo = 0;
        this.direccion = "";
        this.rif = "";
        this.telefono="";
    }

    public Empleado(String cedula, String nombre, int sueldo, String direccion, String rif, String telefono) {
        this.cedula = cedula;
        this.nombre = nombre;
        this.sueldo = sueldo;
        this.direccion = direccion;
        this.rif = rif;
        this.telefono=telefono;

    }

    public String getCedula() {
        return cedula;
    }

    public void setCedula(String cedula) {
        this.cedula = cedula;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getSueldo() {
        return sueldo;
    }

    public void setSueldo(int sueldo) {
        this.sueldo = sueldo;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }


    public String getRif() {
        return rif;
    }

    public void setRif(String rif) {
        this.rif = rif;
    }
    
    
}
