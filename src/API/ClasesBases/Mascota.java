
package API.ClasesBases;


public class Mascota {
    
    private String cod_mascota;
    private String nombre;
    private String fecha_nac;
    private String tipo_animal;
    private String sexo;
    private String cedula_dueño;
    private String cod_raza;
    private String cedula_vet;


    public Mascota() {
        this.cod_mascota = "";
        this.cod_raza = "";
        this.nombre = "";
        this.tipo_animal = "";
        this.sexo ="";
        this.cedula_dueño = "";
        this.cedula_vet = "";
        this.fecha_nac = null;
    }

    public Mascota(String cod_mascota, String cod_raza, String nombre, String tipo_animal, String sexo, String cedula_dueño, String cedula_vet, String fecha_nac) {
        this.cod_mascota = cod_mascota;
        this.cod_raza = cod_raza;
        this.nombre = nombre;
        this.tipo_animal = tipo_animal;
        this.sexo = sexo;
        this.cedula_dueño = cedula_dueño;
        this.cedula_vet = cedula_vet;
        this.fecha_nac = fecha_nac;
    }

    public String getCod_mascota() {
        return cod_mascota;
    }

    public void setCod_mascota(String cod_mascota) {
        this.cod_mascota = cod_mascota;
    }

    public String getCod_raza() {
        return cod_raza;
    }

    public void setCod_raza(String cod_raza) {
        this.cod_raza = cod_raza;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTipo_animal() {
        return tipo_animal;
    }

    public void setTipo_animal(String tipo_animal) {
        this.tipo_animal = tipo_animal;
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public String getCedula_dueño() {
        return cedula_dueño;
    }

    public void setCedula_dueño(String cedula_dueño) {
        this.cedula_dueño = cedula_dueño;
    }

    public String getCedula_vet() {
        return cedula_vet;
    }

    public void setCedula_vet(String cedula_vet) {
        this.cedula_vet = cedula_vet;
    }

    public String getFecha_nac() {
        return fecha_nac;
    }

    public void setFecha_nac(String fecha_nac) {
        this.fecha_nac = fecha_nac;
    }
    
    
    
    
}
