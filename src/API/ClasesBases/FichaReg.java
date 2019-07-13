
package API.ClasesBases;

public class FichaReg {
    
    private String Cod_Registro;
    private String Fecha_E;
    private String Hora_E;
    private String Fecha_SEst;
    private String Hora_SEst;
    private String Fecha_SReal;
    private String Hora_SReal;

    public FichaReg() {
        this.Cod_Registro = "";
        this.Fecha_E = "";
        this.Hora_E = "";
        this.Fecha_SEst = "";
        this.Hora_SEst = "";
        this.Fecha_SReal = "";
        this.Hora_SReal = "";
    }

    public FichaReg(String Cod_Registro, String Fecha_E, String Hora_E, String Fecha_SEst, String Hora_SEst, String Fecha_SReal, String Hora_SReal) {
        this.Cod_Registro = Cod_Registro;
        this.Fecha_E = Fecha_E;
        this.Hora_E = Hora_E;
        this.Fecha_SEst = Fecha_SEst;
        this.Hora_SEst = Hora_SEst;
        this.Fecha_SReal = Fecha_SReal;
        this.Hora_SReal = Hora_SReal;
    }

    public String getCod_Registro() {
        return Cod_Registro;
    }

    public void setCod_Registro(String Cod_Registro) {
        this.Cod_Registro = Cod_Registro;
    }

    public String getFecha_E() {
        return Fecha_E;
    }

    public void setFecha_E(String Fecha_E) {
        this.Fecha_E = Fecha_E;
    }

    public String getHora_E() {
        return Hora_E;
    }

    public void setHora_E(String Hora_E) {
        this.Hora_E = Hora_E;
    }

    public String getFecha_SEst() {
        return Fecha_SEst;
    }

    public void setFecha_SEst(String Fecha_SEst) {
        this.Fecha_SEst = Fecha_SEst;
    }

    public String getHora_SEst() {
        return Hora_SEst;
    }

    public void setHora_SEst(String Hora_SEst) {
        this.Hora_SEst = Hora_SEst;
    }

    public String getFecha_SReal() {
        return Fecha_SReal;
    }

    public void setFecha_SReal(String Fecha_SReal) {
        this.Fecha_SReal = Fecha_SReal;
    }

    public String getHora_SReal() {
        return Hora_SReal;
    }

    public void setHora_SReal(String Hora_SReal) {
        this.Hora_SReal = Hora_SReal;
    }
  
    
    
}
