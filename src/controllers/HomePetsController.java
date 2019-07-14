package controllers;

import API.supportClasses.ButtonsCreator;
import com.jfoenix.controls.JFXButton;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.geometry.Pos;
import javafx.scene.Parent;
import javafx.scene.control.ContentDisplay;
import javafx.scene.control.ScrollPane;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Pane;
import javafx.scene.layout.VBox;
import javafx.scene.text.Font;
import javafx.scene.text.TextAlignment;
import main.Main;

import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;
import java.util.ResourceBundle;

public class HomePetsController implements Initializable {

    //Buttons
    @FXML private JFXButton homepetBtn;
    @FXML private JFXButton addBtn;

    //Boxes
    @FXML private HBox hBox;
    @FXML private VBox vBox;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        hBox.getChildren().remove(1);
        ArrayList<String> arrayList = new ArrayList<>();
        arrayList.add("1");
        arrayList.add("2");
        arrayList.add("3");/*
        arrayList.add("4");
        arrayList.add("5");
        arrayList.add("6");
        arrayList.add("7");
        arrayList.add("8");*/
        if(arrayList.size()>=4){
            ButtonsCreator.createBtnMore4(arrayList.size(),arrayList,hBox,vBox,homepetBtn,addBtn,125);
        }else {
            ButtonsCreator.createBtnLess4(arrayList.size(),arrayList,hBox,homepetBtn,addBtn,125);
        }

        EventHandler<ActionEvent> eh = new EventHandler<ActionEvent>() {
            @Override
            public void handle(ActionEvent event) {
                try{
                    Parent root = FXMLLoader.load(getClass().getResource("../GUI/HomePet/HomePets-Details.fxml"));
                    Parent parent = (Parent)Main.myStage.getScene().getRoot().getChildrenUnmodifiable().get(1);
                    parent = (Parent)parent.getChildrenUnmodifiable().get(1);
                    ((Pane)parent).getChildren().setAll(root);
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        };

        ButtonsCreator.setBtns(arrayList.size(), vBox, eh);
    }



    @FXML public void registerHomepet(ActionEvent event){
        try{
            Parent root = FXMLLoader.load(getClass().getResource("../GUI/HomePet/HomePet-Register.fxml"));
            Parent parent = (Parent)Main.myStage.getScene().getRoot().getChildrenUnmodifiable().get(1);
            parent = (Parent)parent.getChildrenUnmodifiable().get(1);
            ((Pane)parent).getChildren().add(1,root);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
