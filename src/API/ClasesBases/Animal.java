
package API.ClasesBases;

public class Animal {
    
    private String cod_animal;
    private String descripcion;

    public Animal() {
        this.cod_animal = "";
        this.descripcion = "";
    }

    public Animal(String cod_animal, String descripcion) {
        this.cod_animal = cod_animal;
        this.descripcion = descripcion;
    }

    public String getCod_animal() {
        return cod_animal;
    }

    public void setCod_animal(String cod_animal) {
        this.cod_animal = cod_animal;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
    
    
    
    
}
