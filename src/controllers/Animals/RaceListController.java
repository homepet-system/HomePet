package controllers.Animals;

import com.jfoenix.controls.JFXListView;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.layout.HBox;

import java.net.URL;
import java.util.ResourceBundle;

public class RaceListController implements Initializable {

    @FXML private JFXListView<Integer> raceListView;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        for(int i = 0; i <100; i++){
            raceListView.getItems().add(i);
        }
    }
}
