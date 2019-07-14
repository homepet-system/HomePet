package controllers.Animals;

import com.jfoenix.controls.JFXButton;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.control.Label;
import javafx.scene.image.ImageView;
import javafx.scene.layout.Pane;
import javafx.scene.layout.StackPane;
import javafx.scene.layout.VBox;
import main.Main;

public class AnimalsDetailsController {

    @FXML
    private JFXButton animalsBackBtn;

    @FXML
    private ImageView animalImage;

    @FXML
    private Label nombreAnimalLabel;

    @FXML
    private JFXButton editButton;

    @FXML
    private JFXButton deleteButton;

    @FXML
    private StackPane contentPane;

    @FXML
    private VBox mobilePane;


    public void showBack(ActionEvent event) {
        try{
            Parent root = FXMLLoader.load(getClass().getResource("../../GUI/Animals/Animals.fxml"));
            ((Pane)((Parent)Main.myStage.getScene().getRoot().getChildrenUnmodifiable().get(1)).getChildrenUnmodifiable().get(1)).getChildren().setAll(root);
        }catch (Exception e){
            e.printStackTrace();
        }

    }

    public void editAnimal(ActionEvent event) {
    }

    public void deleteAnimal(ActionEvent event) {
    }
}
