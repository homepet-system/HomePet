package controllers;

import com.jfoenix.controls.JFXButton;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.geometry.Pos;
import javafx.scene.control.ContentDisplay;
import javafx.scene.control.ScrollPane;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.AnchorPane;
import javafx.scene.text.Font;
import javafx.scene.text.TextAlignment;

import java.net.URL;
import java.util.ResourceBundle;

public class HomePetsController implements Initializable {

    @FXML private ScrollPane scrollPane;
    @FXML private AnchorPane anchorPane;
    @FXML private JFXButton btnView;
    @FXML private JFXButton addBtn;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        anchorPane.setPrefWidth(anchorPane.getPrefWidth()+10);
        createBtn(8);
        System.out.println(anchorPane.getChildren().get(0).getId());
    }

    private void createBtn(int n){
        int numDivisiones = (n)/4;
        int x = 11;
        int y = 8;
        int actual = 1;
        ImageView img;

        System.out.println("Primer paso");
            for(int j = 0; j<numDivisiones; j++){
                x = 11;
                System.out.println("Paso "+j);
                for(int k = 0; k<4;k++){
                    System.out.println("Paso paso "+k);
                    JFXButton btn = new JFXButton(String.valueOf(actual));
                    btn.getStyleClass().addAll("secundary","secundary-text","card");
                    img = new ImageView(new Image("img/Users/85.jpg"));
                    img.setPreserveRatio(false);
                    img.setFitWidth(165);
                    img.setFitHeight(120);
                    btn.setPrefWidth(175);
                    btn.setMaxWidth(175);
                    btn.setMinWidth(175);
                    btn.setPrefHeight(200);
                    btn.setMaxHeight(200);
                    btn.setMinHeight(200);
                    btn.setGraphic(img);
                    btn.setGraphicTextGap(15);
                    btn.setContentDisplay(ContentDisplay.TOP);
                    btn.alignmentProperty().set(Pos.TOP_CENTER);
                    btn.setFont(new Font("Raleway",18));
                    btn.setWrapText(true);
                    btn.textAlignmentProperty().set(TextAlignment.CENTER);
                    btn.setId("value-" + actual);
                    btn.setLayoutX(x);
                    btn.setLayoutY(y);
                    anchorPane.getChildren().add(actual-1,btn);
                    x +=188;
                    actual+=1;
                }
                y+= 217;
                if(y>anchorPane.getHeight())
                    anchorPane.setPrefHeight(anchorPane.getHeight()+y);
            }

        x+=188;
        y+=217;

        addBtn.setLayoutX(x);
        addBtn.setLayoutY(y);
    }
}
