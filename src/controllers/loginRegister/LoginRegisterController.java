package controllers.loginRegister;

import com.jfoenix.controls.JFXButton;
import javafx.animation.TranslateTransition;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.StackPane;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.paint.CycleMethod;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;
import javafx.scene.shape.Rectangle;
import javafx.util.Duration;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

public class LoginRegisterController implements Initializable {

    @FXML private VBox contentBox;
    @FXML private StackPane stackMobile;
    @FXML private  AnchorPane anchorPane;
    @FXML private Rectangle rectangle;
    @FXML private JFXButton registerBtn;
    @FXML private JFXButton loginBtn;

    private Parent parent;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        try{
            parent = FXMLLoader.load(getClass().getResource("../../GUI/Login-Register/Login.fxml"));
            contentBox.getChildren().addAll(parent);
        }catch (IOException e){
            e.printStackTrace();
        }
    }

    @FXML public void showRegister(ActionEvent event) {
        TranslateTransition t = new TranslateTransition(Duration.seconds(1),stackMobile);
        t.setToX(400);
        t.play();
        t.setOnFinished(e -> {
            try {
                parent = FXMLLoader.load(getClass().getResource("../../GUI/Login-Register/Register.fxml"));
                contentBox.getChildren().removeAll();
                contentBox.getChildren().setAll(parent);
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        });
    }

    @FXML public void showLogin(ActionEvent event){
        TranslateTransition t = new TranslateTransition(Duration.seconds(1),stackMobile);
        t.setToX(-20);
        t.play();
        t.setOnFinished(e -> {
            try {
                parent = FXMLLoader.load(getClass().getResource("../../GUI/Login-Register/Login.fxml"));
                contentBox.getChildren().removeAll();
                contentBox.getChildren().setAll(parent);
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        });
    }
}
