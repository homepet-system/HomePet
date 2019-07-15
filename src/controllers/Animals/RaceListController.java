package controllers.Animals;

import API.ClasesBases.Raza;
import com.jfoenix.controls.JFXButton;
import com.jfoenix.controls.JFXListView;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.HBox;

import java.net.URL;
import java.util.List;
import java.util.ResourceBundle;

public class RaceListController implements Initializable {

    @FXML private JFXListView<String> raceListView;
    @FXML private BorderPane border;
    @FXML private Button addBtn;
    @FXML private HBox hBox;
    private List<Raza> races;
    private boolean edit;
    public static Button staticAddBtn;


    @Override
    public void initialize(URL location, ResourceBundle resources) {
        staticAddBtn = addBtn;
        edit = false;
        hBox.getChildren().remove(addBtn);
        staticAddBtn.setVisible(false);
        /*for(int i = 0; i<races.size();i++){
            raceListView.getItems().add(races.get(i).getNombre());*/
        //}
    }

    public void edit(){

    }

}
