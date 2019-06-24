package controllers;

import com.jfoenix.controls.JFXButton;
import de.jensd.fx.glyphs.fontawesome.FontAwesomeIcon;
import javafx.animation.ScaleTransition;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.SnapshotParameters;
import javafx.scene.control.Label;
import javafx.scene.control.ScrollPane;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.image.WritableImage;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.Pane;
import javafx.scene.layout.VBox;

import javafx.event.ActionEvent;
import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;
import javafx.scene.shape.Rectangle;
import javafx.util.Duration;
import main.Main;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;


public class HomeController implements Initializable {

    @FXML private VBox menuBox;
    @FXML private ImageView imageCircleOne;
    @FXML private ImageView imageCircleTwo;
    @FXML private ScrollPane scrollPane;
    @FXML private Label usernameLbl;
    @FXML private Label cargoLbl;
    @FXML private JFXButton showHideBtn;
    @FXML private FontAwesomeIcon notification;
    @FXML private Pane pane;
    @FXML private BorderPane root;

    private Parent content;
    private boolean showHide;
    private ScaleTransition scale = new ScaleTransition(Duration.seconds(2));

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        showHide = true;
        scale.setNode(menuBox);
        imageCircleOne.setClip(new Circle(imageCircleOne.getFitWidth()/2,imageCircleOne.getFitHeight()/2,50));
        imageCircleOne.setImage(new Image("img/Users/81.jpg"));

        imageCircleTwo.setClip(new Circle(imageCircleTwo.getFitWidth()/2,imageCircleTwo.getFitHeight()/2,22));
        imageCircleTwo.setImage(imageCircleOne.getImage());

        try{
            content = FXMLLoader.load(getClass().getResource("../GUI/Menu.fxml"));
            scrollPane.setContent(content);
        }catch (IOException e){
            e.printStackTrace();
        }
    }

    @FXML
    public void clickImageButton(ActionEvent actionEvent){

    }

    public void showHideMenu(ActionEvent actionEvent){
        if(!showHide){
            showHide = true;
            root.setLeft(menuBox);
        }else {
            showHide = false;
            root.setLeft(null);
        }
    }
}
