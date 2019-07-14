package controllers.Pets;

import API.supportClasses.ButtonsCreator;
import com.jfoenix.controls.JFXButton;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Pane;
import javafx.scene.layout.VBox;
import main.Main;

import java.net.URL;
import java.util.ArrayList;
import java.util.ResourceBundle;

public class PetsController implements Initializable {

    //Boxes
    @FXML private VBox vBox;
    @FXML private HBox hBox;

    //Buttons
    @FXML private JFXButton petBtn;
    @FXML private JFXButton addBtn;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        hBox.getChildren().remove(1);
        ArrayList<String> arrayList = new ArrayList<>();
        for(int i=0; i<11;i++){
            arrayList.add(String.valueOf(i));
        }
        if(arrayList.size() >= 4){
            ButtonsCreator.createBtnMore4(arrayList.size(),arrayList,hBox,vBox,petBtn,addBtn,100);
        }else {

            ButtonsCreator.createBtnLess4(arrayList.size(),arrayList,hBox,petBtn,addBtn,100);
        }

        EventHandler<ActionEvent> eh = new EventHandler<ActionEvent>() {
            @Override
            public void handle(ActionEvent event) {
                try{
                    Parent root = FXMLLoader.load(getClass().getResource("../../GUI/Pets/Pets-Details.fxml"));
                    Parent parent = (Parent) Main.myStage.getScene().getRoot().getChildrenUnmodifiable().get(1);
                    parent = (Parent)parent.getChildrenUnmodifiable().get(1);
                    ((Pane)parent).getChildren().setAll(root);
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        };
        ButtonsCreator.setBtns(arrayList.size(), vBox, eh);
    }

}
