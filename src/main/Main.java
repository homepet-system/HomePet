package main;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;
import javafx.stage.StageStyle;

public class Main extends Application {

    public static Stage myStage;

    public static void main(String[] args){
        launch(args);
    }

    @Override
    public void start(Stage stage) throws Exception {
        Parent root = FXMLLoader.load(getClass().getResource("../GUI/Home.fxml"));
        myStage = stage;
        myStage.initStyle(StageStyle.TRANSPARENT);
        myStage.setScene(new Scene(root));
        myStage.show();
    }

}
