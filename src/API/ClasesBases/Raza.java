
package API.ClasesBases;

public class Raza {

 private String Cod_animal;
 private String Cod_Raza;
 private String Nombre;
 private String Pais_Origen;
 private String Descripcion;
 private String Talla;
 private String Cntxt_Frt;
 private String Nivel_Int;
 private String Color_Plj;
 private String Rango_Altura;
 private String Rango_Peso;

    public Raza() {
        this.Cod_animal = "";
        this.Cod_Raza = "";
        this.Nombre = "";
        this.Pais_Origen = "";
        this.Descripcion = "";
        this.Talla = "";
        this.Cntxt_Frt = "";
        this.Nivel_Int = "";
        this.Color_Plj = "";
        this.Rango_Altura = "";
        this.Rango_Peso = "";
    }

    public Raza(String Cod_animal, String Cod_Raza, String Nombre, String Pais_Origen, String Descripcion, String Talla, String Cntxt_Frt, String Nivel_Int, String Color_Plj, String Rango_Altura, String Rango_Peso) {
        this.Cod_animal = Cod_animal;
        this.Cod_Raza = Cod_Raza;
        this.Nombre = Nombre;
        this.Pais_Origen = Pais_Origen;
        this.Descripcion = Descripcion;
        this.Talla = Talla;
        this.Cntxt_Frt = Cntxt_Frt;
        this.Nivel_Int = Nivel_Int;
        this.Color_Plj = Color_Plj;
        this.Rango_Altura = Rango_Altura;
        this.Rango_Peso = Rango_Peso;
    }

    public String getCod_animal() {
        return Cod_animal;
    }

    public void setCod_animal(String Cod_animal) {
        this.Cod_animal = Cod_animal;
    }

    public String getCod_Raza() {
        return Cod_Raza;
    }

    public void setCod_Raza(String Cod_Raza) {
        this.Cod_Raza = Cod_Raza;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
    }

    public String getPais_Origen() {
        return Pais_Origen;
    }

    public void setPais_Origen(String Pais_Origen) {
        this.Pais_Origen = Pais_Origen;
    }

    public String getDescripcion() {
        return Descripcion;
    }

    public void setDescripcion(String Descripcion) {
        this.Descripcion = Descripcion;
    }

    public String getTalla() {
        return Talla;
    }

    public void setTalla(String Talla) {
        this.Talla = Talla;
    }

    public String getCntxt_Frt() {
        return Cntxt_Frt;
    }

    public void setCntxt_Frt(String Cntxt_Frt) {
        this.Cntxt_Frt = Cntxt_Frt;
    }

    public String getNivel_Int() {
        return Nivel_Int;
    }

    public void setNivel_Int(String Nivel_Int) {
        this.Nivel_Int = Nivel_Int;
    }

    public String getColor_Plj() {
        return Color_Plj;
    }

    public void setColor_Plj(String Color_Plj) {
        this.Color_Plj = Color_Plj;
    }

    public String getRango_Altura() {
        return Rango_Altura;
    }

    public void setRango_Altura(String Rango_Altura) {
        this.Rango_Altura = Rango_Altura;
    }

    public String getRango_Peso() {
        return Rango_Peso;
    }

    public void setRango_Peso(String Rango_Peso) {
        this.Rango_Peso = Rango_Peso;
    }
    
    

  

}
