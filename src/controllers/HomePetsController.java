package controllers;

import com.jfoenix.controls.JFXButton;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.image.ImageView;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Pane;
import javafx.scene.layout.VBox;
import javafx.scene.text.Font;
import main.Main;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

public class HomePetsController implements Initializable {

    @FXML private VBox vBox;
    @FXML private HBox hBox;
    @FXML private JFXButton homePetButton;
    @FXML private JFXButton addBtn;
    private Pane contenido;
    private Parent parent;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        hBox.getChildren().clear();
        createBtn(11);
    }

    private void createBtn(int n){
        int numHBoxes = (int)(n+1)/4;
        int j = 0, k;
        double maxHeight = vBox.getPrefHeight();
        HBox parent;
        HBox[] hBoxes = new HBox[numHBoxes];
        JFXButton button;
        boolean bool = true;

        for(int i = 0; i <numHBoxes;i++){
            hBoxes[i] = new HBox();
            hBoxes[i].setPrefHeight(hBox.getPrefHeight());
            hBoxes[i].setPrefWidth(hBox.getPrefWidth());
            hBoxes[i].setMaxHeight(hBox.getPrefHeight());
            hBoxes[i].setMaxWidth(hBox.getPrefWidth());
            hBoxes[i].setMinWidth(hBox.getPrefWidth());
            hBoxes[i].setMinHeight(hBox.getPrefHeight());
            hBoxes[i].setAlignment(hBox.getAlignment());
            hBoxes[i].setPadding(hBox.getPadding());
            hBoxes[i].setSpacing(hBox.getSpacing());
            if(vBox.getHeight()+hBoxes[i].getHeight() > maxHeight){
                vBox.setPrefHeight(vBox.getPrefHeight()+hBoxes[i].getPrefHeight());
            }
            vBox.getChildren().add(hBoxes[i]);
        }


        while(j < numHBoxes){
            if(j == 0){
                parent = hBox;
                bool = true;
            }else {
                parent = hBoxes[j-1];
            }
            k = 0;
            while(k < 4){
                if(j == 0 && bool){
                    button = homePetButton;
                    bool = false;
                }else {
                    ImageView img = new ImageView();
                    img.setFitHeight(((ImageView)homePetButton.getGraphic()).getFitHeight());
                    img.setFitWidth(((ImageView)homePetButton.getGraphic()).getFitWidth());
                    img.setPreserveRatio(false);
                    button = new JFXButton(String.valueOf(k),img);
                    button.setPrefHeight(homePetButton.getPrefHeight());
                    button.setPrefWidth(homePetButton.getPrefWidth());
                    button.setMaxHeight(homePetButton.getPrefHeight());
                    button.setMaxWidth(homePetButton.getPrefWidth());
                    button.setMinWidth(homePetButton.getPrefWidth());
                    button.setMinHeight(homePetButton.getPrefHeight());
                    button.getStyleClass().addAll(homePetButton.getStyleClass());
                    button.getStyleClass().remove(2);
                    button.setGraphicTextGap(homePetButton.getGraphicTextGap());
                    button.setContentDisplay(homePetButton.getContentDisplay());
                    button.setWrapText(homePetButton.isWrapText());
                    button.setTextAlignment(homePetButton.getTextAlignment());
                    button.setFont(new Font("Raleway",20));
                }
                parent.getChildren().add(button);
                k++;
            }
            j++;
        }
        hBoxes[numHBoxes-1].getChildren().add(addBtn);
    }

    @FXML public void showDetails(ActionEvent event){
        try{
            parent = FXMLLoader.load(getClass().getResource("../GUI/HomePet/HomePets-Details.fxml"));
            contenido = (Pane) Main.myStage.getScene().getRoot().getChildrenUnmodifiable().get(1);
            contenido = (Pane)contenido.getChildrenUnmodifiable().get(1);
            contenido.getChildren().setAll(parent);
        }catch (IOException e){
            e.printStackTrace();
        }
    }
}
