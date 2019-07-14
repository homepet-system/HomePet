package API.ClasesBases;

public class Modalidad {
    
    private String Cod_Factura;
    private String Fecha;
    private int Monto;
    private String Tipo_M;
    private String Numero;

    public Modalidad() {
        this.Cod_Factura = "";
        this.Fecha = "";
        this.Monto = 0;
        this.Tipo_M = "";
        this.Numero = "";
    }

    public Modalidad(String Cod_Factura, String Fecha, int Monto, String Tipo_M, String Numero) {
        this.Cod_Factura = Cod_Factura;
        this.Fecha = Fecha;
        this.Monto = Monto;
        this.Tipo_M = Tipo_M;
        this.Numero = Numero;
    }

    public String getCod_Factura() {
        return Cod_Factura;
    }

    public void setCod_Factura(String Cod_Factura) {
        this.Cod_Factura = Cod_Factura;
    }

    public String getFecha() {
        return Fecha;
    }

    public void setFecha(String Fecha) {
        this.Fecha = Fecha;
    }

    public int getMonto() {
        return Monto;
    }

    public void setMonto(int Monto) {
        this.Monto = Monto;
    }

    public String getTipo_M() {
        return Tipo_M;
    }

    public void setTipo_M(String Tipo_M) {
        this.Tipo_M = Tipo_M;
    }

    public String getNumero() {
        return Numero;
    }

    public void setNumero(String Numero) {
        this.Numero = Numero;
    }
    
    
    
}
