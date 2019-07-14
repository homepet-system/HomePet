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

    @FXML
    private HBox animals;
    @FXML
    private HBox pets;
    @FXML
    private HBox reservations;
    @FXML
    private HBox shopping;
    @FXML
    private HBox providers;
    @FXML
    private HBox pays;
    @FXML
    private HBox books;
    @FXML
    private HBox dashboard;
    @FXML
    private HBox homePets;
    @FXML
    private HBox clients;
    @FXML
    private HBox employees;
    @FXML
    private HBox services;
    @FXML
    private HBox products;

    private String selected;

    private HBox[] hBoxes = new HBox[13];
    private Hashtable<Integer, Parent> table = new Hashtable<>();

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        selected = "";
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

        try {
            table.put(0, FXMLLoader.load(getClass().getResource("../GUI/DashBoard/Dashboard.fxml")));
            table.put(1, FXMLLoader.load(getClass().getResource("../GUI/HomePet/HomePets.fxml")));
            table.put(2, FXMLLoader.load(getClass().getResource("../GUI/Owners/Owners.fxml")));
            table.put(3, FXMLLoader.load(getClass().getResource("../GUI/Empleados/Empleados.fxml")));
            table.put(4, FXMLLoader.load(getClass().getResource("../GUI/Animals/Animals.fxml")));
            table.put(5, FXMLLoader.load(getClass().getResource("../GUI/Pets/Pets.fxml")));
            table.put(6, FXMLLoader.load(getClass().getResource("../GUI/Services/Services.fxml")));
            table.put(7, FXMLLoader.load(getClass().getResource("../GUI/Reservations/Reservation-Details.fxml")));
            table.put(8, FXMLLoader.load(getClass().getResource("../GUI/Reservations/Reservations.fxml")));
            table.put(9, FXMLLoader.load(getClass().getResource("../GUI/HomePet/HomePets.fxml")));
            table.put(10, FXMLLoader.load(getClass().getResource("../GUI/HomePet/HomePets.fxml")));
            table.put(11, FXMLLoader.load(getClass().getResource("../GUI/HomePet/HomePets.fxml")));
            table.put(12, FXMLLoader.load(getClass().getResource("../GUI/HomePet/HomePets.fxml")));
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    @FXML
    public void itemSelected(MouseEvent event) {
        if (!selected.equals(((HBox) event.getSource()).getId())) {
            Parent contenido;
            selected = ((HBox) event.getSource()).getId();
            int i = 0;
            switch (((HBox) event.getSource()).getId()) {
                case "dashboard":
                    HomeController.staticWindowTitle.setText("Dashboard");
                    i = 0;
                    break;
                case "homePets":
                    HomeController.staticWindowTitle.setText("HomePets");
                    i = 1;
                    break;
                case "clients":
                    HomeController.staticWindowTitle.setText("Clientes");
                    i = 2;
                    break;
                case "employees":
                    HomeController.staticWindowTitle.setText("Empleados");
                    i = 3;
                    break;
                case "animals":
                    HomeController.staticWindowTitle.setText("Animales");
                    i = 4;
                    break;
                case "pets":
                    HomeController.staticWindowTitle.setText("Mascotas");
                    i = 5;
                    break;
                case "services":
                    HomeController.staticWindowTitle.setText("Servicios");
                    i = 6;
                    break;
                case "products":
                    HomeController.staticWindowTitle.setText("Productos");
                    i = 7;
                    break;
                case "reservations":
                    HomeController.staticWindowTitle.setText("Reservaciones");
                    i = 8;
                    break;
                case "shopping":
                    HomeController.staticWindowTitle.setText("Orden de Compra");
                    i = 9;
                    break;
                case "providers":
                    HomeController.staticWindowTitle.setText("Proveedores");
                    i = 10;
                    break;
                case "pays":
                    HomeController.staticWindowTitle.setText("Facturación");
                    i = 11;
                    break;
                case "books":
                    HomeController.staticWindowTitle.setText("Inventario");
                    i = 12;
                    break;
            }

            for (int j = 0; j < 13; j++) {
                if (j == i) {
                    hBoxes[j].getStyleClass().setAll("item-selected");
                } else {
                    hBoxes[j].getStyleClass().setAll("item");
                }
            }
            contenido = (Parent) Main.myStage.getScene().getRoot().getChildrenUnmodifiable().get(1);
            contenido = (Parent) contenido.getChildrenUnmodifiable().get(1);
            ((Pane) contenido).getChildren().setAll(table.get(i));
        }
    }
}