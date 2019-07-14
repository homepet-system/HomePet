package controllers;

import de.jensd.fx.glyphs.fontawesome.FontAwesomeIcon;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.control.Label;
import javafx.scene.control.ScrollPane;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.Pane;
import javafx.scene.layout.VBox;

import javafx.event.ActionEvent;
import javafx.scene.shape.Circle;
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
    @FXML private FontAwesomeIcon notification;
    @FXML private Pane pane;
    @FXML private BorderPane root;
    @FXML private Label windowTitle;

    private Parent content;
    public static Label staticWindowTitle;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        staticWindowTitle = windowTitle;
        imageCircleOne.setClip(new Circle(imageCircleOne.getFitWidth()/2,imageCircleOne.getFitHeight()/2,50));
        //imageCircleOne.setImage(new Image(getClass().getResourceAsStream("/resources/img/Users/81.jpg")));

        imageCircleTwo.setClip(new Circle(imageCircleTwo.getFitWidth()/2,imageCircleTwo.getFitHeight()/2,22));
        //imageCircleTwo.setImage(imageCircleOne.getImage());

        try{
            content = FXMLLoader.load(getClass().getResource("../GUI/Menu.fxml"));
            scrollPane.setContent(content);
            content = FXMLLoader.load(getClass().getResource("../GUI/DashBoard/Dashboard.fxml"));
            pane.getChildren().add(content);
        }catch (IOException e){
            e.printStackTrace();
        }
    }


    @FXML
    public void clickImageButton(ActionEvent actionEvent){

    }

    public void closeApplication(ActionEvent event) {
        System.exit(0);
    }
}
