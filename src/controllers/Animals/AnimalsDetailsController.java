package controllers.Animals;

import API.ClasesBases.Vacuna;
import com.jfoenix.controls.JFXButton;
import javafx.animation.Interpolator;
import javafx.animation.KeyFrame;
import javafx.animation.KeyValue;
import javafx.animation.Timeline;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.control.Alert;
import javafx.scene.control.ButtonType;
import javafx.scene.control.Label;
import javafx.scene.image.ImageView;
import javafx.scene.layout.*;
import javafx.stage.StageStyle;
import javafx.util.Duration;
import main.Main;

import java.io.IOException;
import java.net.URL;
import java.util.Optional;
import java.util.ResourceBundle;

public class AnimalsDetailsController implements Initializable
{

    @FXML private JFXButton animalsBackBtn;
    @FXML private ImageView animalImage;
    @FXML private Label animalLabel;
    @FXML private JFXButton editButton;
    @FXML private JFXButton deleteButton;
    @FXML private JFXButton saveButton;
    @FXML private JFXButton cancelButton;
    @FXML private StackPane contentPane;
    @FXML private VBox vBox;
    @FXML private HBox hBox1;
    @FXML private HBox hBox2;

    private Timeline timeline;
    private Parent[] mobileChild = new Parent[3];
    private boolean edit;
    private int selected;


    public void showBack(ActionEvent event) {
        try{
            Parent root = FXMLLoader.load(getClass().getResource("../../GUI/Animals/Animals.fxml"));
            ((Pane)((Parent)Main.myStage.getScene().getRoot().getChildrenUnmodifiable().get(1)).getChildrenUnmodifiable().get(1)).getChildren().setAll(root);
        }catch (Exception e){
            e.printStackTrace();
        }

    }

    public void editAnimal(ActionEvent event) {
        edit = true;
        saveButton.setVisible(true);
        cancelButton.setVisible(true);
        hBox1.getChildren().setAll(saveButton,cancelButton);
        RaceListController.staticAddBtn.setVisible(true);
        WeaknessListController.staticAddBtn.setVisible(true);
        VacunasDetailsController.staticAddBtn.setVisible(true);
        ((HBox)((BorderPane)mobileChild[0]).getBottom()).getChildren().add(VacunasDetailsController.staticAddBtn);
        ((HBox)((BorderPane)mobileChild[1]).getBottom()).getChildren().add(RaceListController.staticAddBtn);
        ((HBox)((BorderPane)mobileChild[2]).getBottom()).getChildren().add(WeaknessListController.staticAddBtn);
    }

    public void deleteAnimal(ActionEvent event) {
        Alert alert = new Alert(Alert.AlertType.CONFIRMATION);
        alert.initStyle(StageStyle.TRANSPARENT);
        alert.setHeaderText(null);
        alert.setTitle("Confirmacion");
        alert.setContentText("¿Está seguro que desea eliminar a este animal?");
        Optional<ButtonType> result = alert.showAndWait();
        if (result.get() == ButtonType.OK){
            // ... user chose OK
        } else {
        }

    }

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        timeline = new Timeline();
        selected = 1;
        edit = false;
        hBox2.getChildren().removeAll();
        saveButton.setVisible(false);
        cancelButton.setVisible(false);

        try{
            mobileChild[0] = FXMLLoader.load(getClass().getResource("../../GUI/Animals/VacunasDetails.fxml"));
            mobileChild[1] = FXMLLoader.load(getClass().getResource("../../GUI/Animals/RaceDetails.fxml"));
            mobileChild[2] = FXMLLoader.load(getClass().getResource("../../GUI/Animals/WeaknessDetails.fxml"));
        }catch(IOException e){
            e.printStackTrace();
        }finally {
            contentPane.getChildren().setAll(mobileChild[1]);
        }
    }

    @FXML private void changeView(ActionEvent event){
        if(selected != Integer.parseInt(String.valueOf(((JFXButton)event.getSource()).getId().charAt(3)))){
            switch(Integer.parseInt(String.valueOf(((JFXButton)event.getSource()).getId().charAt(3)))){
                case 1:
                    selected = 1;
                    break;
                case 2:
                    selected = 2;
                    break;
                case 3:
                    selected = 3;
                    break;
            }
            if(!contentPane.getChildren().get(0).equals(mobileChild[selected-1])){
                contentPane.getChildren().add(mobileChild[selected-1]);
                mobileChild[selected-1].translateYProperty().setValue(532);
                KeyValue kv = new KeyValue(mobileChild[selected-1].translateYProperty(),0, Interpolator.EASE_IN);
                KeyFrame kf = new KeyFrame(Duration.seconds(1),kv);
                timeline.getKeyFrames().setAll(kf);
                timeline.setOnFinished(actionEvent -> contentPane.getChildren().setAll(mobileChild[selected-1]));
                timeline.setCycleCount(1);
                timeline.play();
            }
        }
    }
}
