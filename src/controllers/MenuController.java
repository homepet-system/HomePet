package controllers;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Pane;
import javafx.scene.layout.VBox;
import main.Main;

import java.io.IOException;
import java.net.URL;
import java.util.Hashtable;
import java.util.ResourceBundle;

public class MenuController implements Initializable {

    @FXML private HBox animals;
    @FXML private HBox pets;
    @FXML private HBox reservations;
    @FXML private HBox shopping;
    @FXML private HBox providers;
    @FXML private HBox pays;
    @FXML private HBox books;
    @FXML private HBox dashboard;
    @FXML private HBox homePets;
    @FXML private HBox clients;
    @FXML private HBox employees;
    @FXML private HBox services;
    @FXML private HBox products;

    private Parent contenido;

    private HBox[] hBoxes = new HBox[13];
    private Hashtable<Integer, Parent> table = new Hashtable<>();

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        hBoxes[0] = dashboard;
        hBoxes[1] = homePets;
        hBoxes[2] = clients;
        hBoxes[3] = employees;
        hBoxes[4] = animals;
        hBoxes[5] = pets;
        hBoxes[6] = services;
        hBoxes[7] = products;
        hBoxes[8] = reservations;
        hBoxes[9] = shopping;
        hBoxes[10] = providers;
        hBoxes[11] = pays;
        hBoxes[12] = books;

        try{
            table.put(0,FXMLLoader.load(getClass().getResource("../GUI/Dashboard.fxml")));
            table.put(1,FXMLLoader.load(getClass().getResource("../GUI/HomePets.fxml")));
            table.put(2,FXMLLoader.load(getClass().getResource("../GUI/HomePets.fxml")));
            table.put(3,FXMLLoader.load(getClass().getResource("../GUI/HomePets.fxml")));
            table.put(4,FXMLLoader.load(getClass().getResource("../GUI/HomePets.fxml")));
            table.put(5,FXMLLoader.load(getClass().getResource("../GUI/HomePets.fxml")));
            table.put(6,FXMLLoader.load(getClass().getResource("../GUI/HomePets.fxml")));
            table.put(7,FXMLLoader.load(getClass().getResource("../GUI/HomePets.fxml")));
            table.put(8,FXMLLoader.load(getClass().getResource("../GUI/HomePets.fxml")));
            table.put(9,FXMLLoader.load(getClass().getResource("../GUI/HomePets.fxml")));
            table.put(10,FXMLLoader.load(getClass().getResource("../GUI/HomePets.fxml")));
            table.put(11,FXMLLoader.load(getClass().getResource("../GUI/HomePets.fxml")));
            table.put(12,FXMLLoader.load(getClass().getResource("../GUI/HomePets.fxml")));

        }catch (IOException e){
            e.printStackTrace();
        }

    }

    @FXML
    public void itemSelected(MouseEvent event){
        int i = -1;
        switch (((HBox)event.getSource()).getId()){
            case "dashboard":
                i =0;
                break;
            case "clients":
                i =2;
                break;
            case "homePets":
                i =1;
                break;
            case "employees":
                i =3;
                break;
            case "animals":
                i =4;
                break;
            case "pets":
                i =5;
                break;
            case "services":
                i =6;
                break;
            case "products":
                i =7;
                break;
            case "reservations":
                i =8;
                break;
            case "shopping":
                i =9;
                break;
            case "providers":
                i =10;
                break;
            case "pays":
                i =11;
                break;
            case "books":
                i =12;
                break;
        }
        for (int j = 0; j<13; j++){
            if(j==i){
                hBoxes[j].getStyleClass().removeAll("item");
                hBoxes[j].getStyleClass().add("item-selected");
            }else{
                hBoxes[j].getStyleClass().removeAll("item-selected");
                hBoxes[j].getStyleClass().add("item");
            }
        }
        contenido = (Parent) Main.myStage.getScene().getRoot().getChildrenUnmodifiable().get(1);
        contenido = (Parent)contenido.getChildrenUnmodifiable().get(1);
        ((Pane)contenido).getChildren().setAll(table.get(i));
    }
}
