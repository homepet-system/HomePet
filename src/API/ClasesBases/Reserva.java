
package API.ClasesBases;


public class Reserva {
    
    private String cod_reserva;
    private String fecha_reser;
    private String fecha_act_r;
    private int monto_abonado;
    private int monto_total;
    private String rif_homepet;

    public Reserva() {
        this.cod_reserva = "";
        this.fecha_reser = null;
        this.fecha_act_r = null;
        this.monto_abonado = 0;
        this.monto_total = 0;
        this.rif_homepet = null;
    }

    public Reserva(String cod_reserva, String fecha_reser, String fecha_act_r, int monto_abonado, int monto_total, String rif_homepet) {
        this.cod_reserva = cod_reserva;
        this.fecha_reser = fecha_reser;
        this.fecha_act_r = fecha_act_r;
        this.monto_abonado = monto_abonado;
        this.monto_total = monto_total;
        this.rif_homepet = rif_homepet;
    }

    public String getCod_reserva() {
        return cod_reserva;
    }

    public void setCod_reserva(String cod_reserva) {
        this.cod_reserva = cod_reserva;
    }

    public String getFecha_reser() {
        return fecha_reser;
    }

    public void setFecha_reser(String fecha_reser) {
        this.fecha_reser = fecha_reser;
    }

    public String getFecha_act_r() {
        return fecha_act_r;
    }

    public void setFecha_act_r(String fecha_act_r) {
        this.fecha_act_r = fecha_act_r;
    }

    public int getMonto_abonado() {
        return monto_abonado;
    }

    public void setMonto_abonado(int monto_abonado) {
        this.monto_abonado = monto_abonado;
    }

    public int getMonto_total() {
        return monto_total;
    }

    public void setMonto_total(int monto_total) {
        this.monto_total = monto_total;
    }

    public String getRif_homepet() {
        return rif_homepet;
    }

    public void setRif_homepet(String rif_homepet) {
        this.rif_homepet = rif_homepet;
    }
}
