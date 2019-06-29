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
import javafx.scene.layout.StackPane;
import javafx.util.Duration;
import main.Main;


import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

public class HomePetDetailsController implements Initializable {

    @FXML private StackPane trasitionPane;
    @FXML private JFXButton btn1;
    @FXML private JFXButton btn2;
    @FXML private JFXButton btn3;
    @FXML private JFXButton btn4;
    @FXML private JFXButton btn5;
    private int currentBtn;

    private Parent[] parent = new Parent[5];
    private Timeline timeline ;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        currentBtn = 1;
        timeline = new Timeline();
        try{
            parent[0] = FXMLLoader.load(getClass().getResource("../GUI/Details-Encargado.fxml"));
            parent[1] = FXMLLoader.load(getClass().getResource("../GUI/Details-Animals.fxml"));
            parent[2] = FXMLLoader.load(getClass().getResource("../GUI/Details-Animals.fxml"));
            parent[3] = FXMLLoader.load(getClass().getResource("../GUI/Details-Animals.fxml"));
            parent[4] = FXMLLoader.load(getClass().getResource("../GUI/Details-Animals.fxml"));
        }catch(IOException e){
            e.printStackTrace();
        }
        trasitionPane.getChildren().add(parent[0]);
    }

     public void changeView(ActionEvent event){
        int frontOrBack;
        if(currentBtn != Integer.parseInt(String.valueOf(((JFXButton)event.getSource()).getId().charAt(3)))){
            if(currentBtn < Integer.parseInt(String.valueOf(((JFXButton)event.getSource()).getId().charAt(3)))){
                parent[Integer.parseInt(String.valueOf(((JFXButton)event.getSource()).getId().charAt(3)))-1].translateYProperty().set(-Main.myStage.getScene().getHeight());
                frontOrBack = 1;
            }else{
                parent[Integer.parseInt(String.valueOf(((JFXButton)event.getSource()).getId().charAt(3)))-1].translateYProperty().set(Main.myStage.getScene().getHeight());
                frontOrBack = 2;
            }
            trasitionPane.getChildren().add(parent[Integer.parseInt(String.valueOf(((JFXButton)event.getSource()).getId().charAt(3)))-frontOrBack]);
            KeyValue kv = new KeyValue(parent[Integer.parseInt(String.valueOf(((JFXButton)event.getSource()).getId().charAt(3)))-frontOrBack].translateYProperty(),0, Interpolator.EASE_IN);
            KeyFrame kf = new KeyFrame(Duration.seconds(1),kv);
            timeline.getKeyFrames().clear();
            timeline.getKeyFrames().add(kf);
            timeline.setOnFinished(actionEvent -> trasitionPane.getChildren().setAll(parent[currentBtn-frontOrBack]));
            currentBtn = Integer.parseInt(String.valueOf(((JFXButton)event.getSource()).getId().charAt(3)));
            timeline.play();
        }

    }
}
