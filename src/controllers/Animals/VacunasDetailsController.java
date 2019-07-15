package controllers.Animals;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.layout.HBox;

import java.net.URL;
import java.util.ResourceBundle;

public class VacunasDetailsController implements Initializable {


    @FXML private HBox hBox;
    @FXML private Button addBtn;
    public static Button staticAddBtn;
    private boolean edit;


    @Override
    public void initialize(URL location, ResourceBundle resources) {
        staticAddBtn = addBtn;
        edit = false;
        hBox.getChildren().remove(addBtn);
        staticAddBtn.setVisible(false);
    }

    @FXML public void addVacuna(ActionEvent event){

    }
}
