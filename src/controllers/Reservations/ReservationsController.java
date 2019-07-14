package controllers.Reservations;

import API.ClasesBases.Reserva;
import API.ClasesDao.ReservaDAO;
import com.jfoenix.controls.JFXListView;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;

import java.net.URL;
import java.util.ResourceBundle;

public class ReservationsController implements Initializable {

    @FXML private TableView<Reserva> reservationTable;
    @FXML private TableColumn<Reserva, String> colNroReserva;
    @FXML private TableColumn<Reserva, String> colFechaReserva;
    @FXML private TableColumn<Reserva, String> colFechaPautada;
    @FXML private TableColumn<Reserva, Integer> colMonto;
    @FXML private TableColumn<Reserva, String> colHomepet;

    ObservableList<Reserva> reservaList = FXCollections.observableArrayList();

    @Override
    public void initialize(URL location, ResourceBundle resources) {

        /*ReservaDAO dao = new ReservaDAO();

        reservaList.addAll(dao.obtener());*/

        colNroReserva.setCellValueFactory(new PropertyValueFactory<>("cod_reserva"));
        colFechaReserva.setCellValueFactory(new PropertyValueFactory<>("fecha_reser"));
        colFechaPautada.setCellValueFactory(new PropertyValueFactory<>("fecha_act_r"));
        colMonto.setCellValueFactory(new PropertyValueFactory<>("monto_total"));
        colHomepet.setCellValueFactory(new PropertyValueFactory<>("rif_homepet"));

//        reservationTable.setItems(reservaList);
    }
}
