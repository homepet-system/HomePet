
package API.ClasesBases;


public class Alimentacion {

private String Cod_Mascota;
private String Tipo_Comida;
private int Cantidad;
private String Unidad;

    public Alimentacion() {
        this.Cod_Mascota = "";
        this.Tipo_Comida = "";
        this.Cantidad = 0;
        this.Unidad = "";
    }

    public Alimentacion(String Cod_Mascota, String Tipo_Comida, int Cantidad, String Unidad) {
        this.Cod_Mascota = Cod_Mascota;
        this.Tipo_Comida = Tipo_Comida;
        this.Cantidad = Cantidad;
        this.Unidad = Unidad;
    }

    public String getCod_Mascota() {
        return Cod_Mascota;
    }

    public void setCod_Mascota(String Cod_Mascota) {
        this.Cod_Mascota = Cod_Mascota;
    }

    public String getTipo_Comida() {
        return Tipo_Comida;
    }

    public void setTipo_Comida(String Tipo_Comida) {
        this.Tipo_Comida = Tipo_Comida;
    }

    public int getCantidad() {
        return Cantidad;
    }

    public void setCantidad(int Cantidad) {
        this.Cantidad = Cantidad;
    }

    public String getUnidad() {
        return Unidad;
    }

    public void setUnidad(String Unidad) {
        this.Unidad = Unidad;
    }

    
    
    
}
