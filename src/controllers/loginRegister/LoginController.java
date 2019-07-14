package controllers.loginRegister;

import com.jfoenix.controls.JFXButton;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import main.Main;

import java.io.IOException;

public class LoginController {

    @FXML private JFXButton iniciarSesion;

    @FXML public void iniciarSesion(ActionEvent event){
        Parent parent = null;
        try {
            parent = FXMLLoader.load(getClass().getResource("../../GUI/Home.fxml"));
        } catch (IOException e) {
            e.printStackTrace();
        }
        Main.myStage.setScene(new Scene(parent));
        Main.myStage.show();
    }

}
