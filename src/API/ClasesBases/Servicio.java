
package API.ClasesBases;

public class Servicio {
    
    private String cod_srv;
    private String nombre;
    private String descripcion;

    public Servicio() {
        this.cod_srv = "";
        this.nombre = "";
        this.descripcion = "";
    }

    public Servicio(String cod_srv, String nombre, String descripcion) {
        this.cod_srv = cod_srv;
        this.nombre = nombre;
        this.descripcion = descripcion;
    }

    public String getCod_srv() {
        return cod_srv;
    }

    public void setCod_srv(String cod_srv) {
        this.cod_srv = cod_srv;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
    
    
    
    
}
