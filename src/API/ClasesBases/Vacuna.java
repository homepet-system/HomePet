package API.ClasesBases;


public class Vacuna {
    
    private String Cod_Vacuna;
    private String Nombre_Vacuna;
    private String Descripcion_Vacuna;

    public Vacuna() {
        this.Cod_Vacuna = "";
        this.Nombre_Vacuna = "";
        this.Descripcion_Vacuna = "";
    }   
    
    public Vacuna(String Cod_Vacuna, String Nombre_Vacuna, String Descripcion_Vacuna) {
        this.Cod_Vacuna = Cod_Vacuna;
        this.Nombre_Vacuna = Nombre_Vacuna;
        this.Descripcion_Vacuna = Descripcion_Vacuna;
    }

    public String getCod_Vacuna() {
        return Cod_Vacuna;
    }

    public void setCod_Vacuna(String Cod_Vacuna) {
        this.Cod_Vacuna = Cod_Vacuna;
    }

    public String getNombre_Vacuna() {
        return Nombre_Vacuna;
    }

    public void setNombre_Vacuna(String Nombre_Vacuna) {
        this.Nombre_Vacuna = Nombre_Vacuna;
    }

    public String getDescripcion_Vacuna() {
        return Descripcion_Vacuna;
    }

    public void setDescripcion_Vacuna(String Descripcion_Vacuna) {
        this.Descripcion_Vacuna = Descripcion_Vacuna;
    }
    
    
    
    
}
