package controllers;

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
import javafx.scene.layout.HBox;
import javafx.scene.layout.StackPane;
import javafx.util.Duration;
import main.Main;


import java.awt.*;
import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

public class HomePetDetailsController implements Initializable {

    //Panes
    @FXML private StackPane trasitionPane;

    //Buttons
    @FXML private JFXButton homepetBackBtn;
    @FXML private JFXButton editButton;
    @FXML private JFXButton deleteButton;
    @FXML private JFXButton saveButton;
    @FXML private JFXButton cancelButton;

    //Boxes
    @FXML private HBox hBox1;
    @FXML private HBox hBox2;

    private int currentBtn;

    private Parent[] parent = new Parent[4];
    private Timeline timeline ;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        hBox2.getChildren().remove(0,2);
        currentBtn = 1;
        timeline = new Timeline();
        try{
            parent[0] = FXMLLoader.load(getClass().getResource("../GUI/HomePet/Details/Details-Encargado.fxml"));
            parent[1] = FXMLLoader.load(getClass().getResource("../GUI/HomePet/Details/Details-Animals.fxml"));
            parent[2] = FXMLLoader.load(getClass().getResource("../GUI/HomePet/Details/Details-Services.fxml"));
            parent[3] = FXMLLoader.load(getClass().getResource("../GUI/HomePet/Details/Details-Products.fxml"));
        }catch(IOException e){
            e.printStackTrace();
        }
        trasitionPane.getChildren().add(parent[0]);
    }

     public void changeView(ActionEvent event){
        if(currentBtn != Integer.parseInt(String.valueOf(((JFXButton)event.getSource()).getId().charAt(3)))){
            switch(Integer.parseInt(String.valueOf(((JFXButton)event.getSource()).getId().charAt(3)))){
                case 1:
                    currentBtn = 0;
                    break;
                case 2:
                    currentBtn = 1;
                    break;
                case 3:
                    currentBtn = 2;
                    break;
                case 4:
                    currentBtn = 3;
                    break;
            }
            if(!trasitionPane.getChildren().get(0).equals(parent[currentBtn])){
                trasitionPane.getChildren().add(parent[currentBtn]);
                parent[currentBtn].translateYProperty().setValue(532);
                KeyValue kv = new KeyValue(parent[currentBtn].translateYProperty(),0, Interpolator.EASE_IN);
                KeyFrame kf = new KeyFrame(Duration.seconds(1),kv);
                timeline.getKeyFrames().setAll(kf);
                timeline.setOnFinished(actionEvent -> trasitionPane.getChildren().setAll(parent[currentBtn]));
                timeline.setCycleCount(1);
                timeline.play();
            }
        }

    }

    @FXML public void edit(ActionEvent event) {
    }

    @FXML public void back(ActionEvent event){

    }
}
