package controllers.Animals;

import com.jfoenix.controls.JFXListView;
import javafx.animation.Timeline;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.HBox;

import java.net.URL;
import java.util.ResourceBundle;

public class WeaknessListController implements Initializable {

    @FXML private BorderPane border;
    @FXML private JFXListView<String> weaknessListView;
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

    @FXML private void addEnfermedad(ActionEvent event){

    }
}
