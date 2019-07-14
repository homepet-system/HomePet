package API.ClasesBases;


public class HomePet {
    
    private String rif;
    private String nombre;
    private String ciudad;
    private String sector;
    private String cod_animal;
    private int capacidad;

    public HomePet() {
        rif=nombre=ciudad=sector=cod_animal="";
        capacidad=0;
    }

    public HomePet(String rif, String nombre, String ciudad, String sector, String cod_animal, int capacidad) {
        this.rif = rif;
        this.nombre = nombre;
        this.ciudad = ciudad;
        this.sector = sector;
        this.cod_animal = cod_animal;
        this.capacidad = capacidad;
    }

    public String getRif() {
        return rif;
    }

    public void setRif(String rif) {
        this.rif = rif;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getSector() {
        return sector;
    }

    public void setSector(String sector) {
        this.sector = sector;
    }

    public String getCod_animal() {
        return cod_animal;
    }

    public void setCod_animal(String cod_animal) {
        this.cod_animal = cod_animal;
    }

    public int getCapacidad() {
        return capacidad;
    }

    public void setCapacidad(int capacidad) {
        this.capacidad = capacidad;
    }
    
    
    	@Override
	public String toString() {
		return this.rif+", "+this.nombre+", "+this.sector+", "+this.cod_animal+", "+this.ciudad;
	}
    
    
    
}
