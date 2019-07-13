
package API.ClasesBases;

public class Enfermedad {
    
    private String Nombre_Enfermedad;
    private String Descripcion_Enfermedad;
    private String Gravedad;
    private String Cura;

    public Enfermedad() {
        this.Nombre_Enfermedad = "";
        this.Descripcion_Enfermedad = "";
        this.Gravedad = "";
        this.Cura = "";
    }

    public Enfermedad(String Nombre_Enfermedad, String Descripcion_Enfermedad, String Gravedad, String Cura) {
        this.Nombre_Enfermedad = Nombre_Enfermedad;
        this.Descripcion_Enfermedad = Descripcion_Enfermedad;
        this.Gravedad = Gravedad;
        this.Cura = Cura;
    }

    public String getNombre_Enfermedad() {
        return Nombre_Enfermedad;
    }

    public void setNombre_Enfermedad(String Nombre_Enfermedad) {
        this.Nombre_Enfermedad = Nombre_Enfermedad;
    }

    public String getDescripcion_Enfermedad() {
        return Descripcion_Enfermedad;
    }

    public void setDescripcion_Enfermedad(String Descripcion_Enfermedad) {
        this.Descripcion_Enfermedad = Descripcion_Enfermedad;
    }

    public String getGravedad() {
        return Gravedad;
    }

    public void setGravedad(String Gravedad) {
        this.Gravedad = Gravedad;
    }

    public String getCura() {
        return Cura;
    }

    public void setCura(String Cura) {
        this.Cura = Cura;
    }
    
    
    
   
}
