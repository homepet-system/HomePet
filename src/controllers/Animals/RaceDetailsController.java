package controllers.Animals;

import com.jfoenix.controls.JFXButton;
import com.jfoenix.controls.JFXComboBox;
import com.jfoenix.controls.JFXTextArea;
import com.jfoenix.controls.JFXTextField;
import de.jensd.fx.glyphs.fontawesome.FontAwesomeIcon;
import javafx.collections.FXCollections;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.SnapshotResult;
import javafx.scene.control.Alert;
import javafx.scene.control.ButtonType;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;
import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Pane;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.paint.Paint;
import javafx.scene.text.Text;
import main.Main;

import java.net.URL;
import java.util.Optional;
import java.util.ResourceBundle;

public class RaceDetailsController implements Initializable {


    //Botones
    @FXML private JFXButton raceDetailsBackBtn;
    @FXML private JFXButton editButton;
    @FXML private JFXButton deleteButton;
    @FXML private JFXButton saveButton;
    @FXML private JFXButton cancelButton;

    //Imagenes
    @FXML private ImageView raceImage;

    //Iconos
    @FXML private FontAwesomeIcon tinyIcon;
    @FXML private FontAwesomeIcon smallIcon;
    @FXML private FontAwesomeIcon mediumIcon;
    @FXML private FontAwesomeIcon bigIcon;
    @FXML private FontAwesomeIcon gigantIcon;

    //Labels
    @FXML private Label nameRaceLabel;
    @FXML private Label tallLabel;
    @FXML private Text descipcionText;
    @FXML private Label contexturaLabel;
    @FXML private Label intelligenceLabel;
    @FXML private Label skinLabel;
    @FXML private Label minWeightLabel;
    @FXML private Label maxWeightLabel;
    @FXML private Label minHeightLabel;
    @FXML private Label maxHeightLabel;
    @FXML private Label heightUnit;
    @FXML private Label weightUnit;

    //Box
    @FXML private VBox vBox;
    @FXML private VBox vBox2;
    @FXML private HBox hBox1;

    //ListView
    @FXML private ListView foodListView;

    //Variables de edicion
    JFXTextField nameRaceField;
    JFXTextArea descriptionArea;
    JFXComboBox contexturaBox;
    JFXComboBox intelligenceBox;
    JFXTextField skinField;
    JFXTextField minHeightField;
    JFXTextField maxHeightField;
    JFXComboBox heightUnitBox;
    JFXTextField minWeightField;
    JFXTextField maxWeightField;
    JFXComboBox WeightUnitBox;

    private boolean activeEdit;
    private FontAwesomeIcon[] icons = new FontAwesomeIcon[5];

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        saveButton.setVisible(false);
        cancelButton.setVisible(false);
        icons[0] = tinyIcon;
        icons[1] = smallIcon;
        icons[2] = mediumIcon;
        icons[3] = bigIcon;
        icons[4] = gigantIcon;
        activeEdit = false;
    }

    @FXML public void edit(ActionEvent event){
        String style = "-fx-font-family: Raleway; -fx-font-size: 12; -fx-text-fill: #000000";

        activeEdit = true;
        saveButton.setVisible(true);
        cancelButton.setVisible(true);
        hBox1.getChildren().setAll(saveButton,cancelButton);

        nameRaceField = new JFXTextField(nameRaceLabel.getText());
        nameRaceField.setStyle(style+"; -fx-font-weight: Bold; -fx-font-size: 24");
        vBox.getChildren().set(1,nameRaceField);

        descriptionArea = new JFXTextArea(descipcionText.getText());
        descriptionArea.setWrapText(true);
        descriptionArea.setPrefWidth(descipcionText.getWrappingWidth());
        descriptionArea.setStyle(style+"; -fx-font-size: 14");
        vBox2.getChildren().set(2,descriptionArea);

        contexturaBox = new JFXComboBox(FXCollections.observableArrayList("Si","No"));
        contexturaBox.setStyle(style);
        contexturaBox.getSelectionModel().selectFirst();
        ((HBox)vBox2.getChildren().get(3)).getChildren().set(1,contexturaBox);

        intelligenceBox = new JFXComboBox(FXCollections.observableArrayList("Baja","Media","Alta"));
        intelligenceBox.setStyle(style);
        intelligenceBox.getSelectionModel().selectFirst();
        ((HBox)vBox2.getChildren().get(4)).getChildren().set(1,intelligenceBox);

        skinField = new JFXTextField(skinLabel.getText());
        skinField.setStyle(style);
        ((HBox)vBox2.getChildren().get(5)).getChildren().set(1,skinField);

        minHeightField = new JFXTextField(minHeightLabel.getText());
        minHeightField.setPrefWidth(40);
        minHeightField.setStyle(style);

        maxHeightField = new JFXTextField(maxHeightLabel.getText());
        maxHeightField.setPrefWidth(40);
        maxHeightField.setStyle(style);

        heightUnitBox = new JFXComboBox(FXCollections.observableArrayList("cm","mm","m"));
        heightUnitBox.getSelectionModel().selectFirst();
        heightUnitBox.setStyle(style);

        ((HBox)vBox2.getChildren().get(6)).getChildren().set(1,minHeightField);
        ((HBox)vBox2.getChildren().get(6)).getChildren().set(3,maxHeightField);
        ((HBox)vBox2.getChildren().get(6)).getChildren().set(4,heightUnitBox);

        minWeightField = new JFXTextField(minWeightLabel.getText());
        minWeightField.setPrefWidth(40);
        minWeightField.setStyle(style);

        maxWeightField = new JFXTextField(maxWeightLabel.getText());
        maxWeightField.setPrefWidth(40);
        maxWeightField.setStyle(style);

        WeightUnitBox = new JFXComboBox(FXCollections.observableArrayList("cm","mm","m"));
        WeightUnitBox.getSelectionModel().selectFirst();
        WeightUnitBox.setStyle(style);

        ((HBox)vBox2.getChildren().get(7)).getChildren().set(1,minWeightField);
        ((HBox)vBox2.getChildren().get(7)).getChildren().set(3,maxWeightField);
        ((HBox)vBox2.getChildren().get(7)).getChildren().set(4,WeightUnitBox);
    }

    @FXML public void save(ActionEvent event){
        activeEdit = false;
        hBox1.getChildren().setAll(editButton,deleteButton);

        nameRaceLabel.setText(nameRaceField.getText());
        vBox.getChildren().set(1,nameRaceLabel);

        descipcionText.setText(descriptionArea.getText());
        vBox2.getChildren().set(2,descipcionText);

        contexturaLabel.setText((String) contexturaBox.getSelectionModel().getSelectedItem());
        ((HBox)vBox2.getChildren().get(3)).getChildren().set(1,contexturaLabel);

        intelligenceLabel.setText((String) intelligenceBox.getSelectionModel().getSelectedItem());
        ((HBox)vBox2.getChildren().get(4)).getChildren().set(1,intelligenceLabel);

        skinLabel.setText(skinField.getText());
        ((HBox)vBox2.getChildren().get(5)).getChildren().set(1,skinLabel);

        minHeightLabel.setText(minHeightField.getText());
        ((HBox)vBox2.getChildren().get(6)).getChildren().set(1,minHeightLabel);

        maxHeightField.setText(maxHeightField.getText());
        ((HBox)vBox2.getChildren().get(6)).getChildren().set(3,maxHeightLabel);

        heightUnit.setText((String) heightUnitBox.getSelectionModel().getSelectedItem());
        ((HBox)vBox2.getChildren().get(6)).getChildren().set(4,heightUnit);

        minWeightLabel.setText(minWeightField.getText());
        ((HBox)vBox2.getChildren().get(7)).getChildren().set(1,minWeightLabel);

        maxWeightLabel.setText(maxWeightField.getText());
        ((HBox)vBox2.getChildren().get(7)).getChildren().set(3,maxWeightLabel);

        weightUnit.setText((String) WeightUnitBox.getSelectionModel().getSelectedItem());
        ((HBox)vBox2.getChildren().get(7)).getChildren().set(4,weightUnit);
    }


    @FXML public void cancelEdit(ActionEvent event) {
        activeEdit = false;
        hBox1.getChildren().setAll(editButton,deleteButton);
        vBox.getChildren().set(1,nameRaceLabel);
        vBox2.getChildren().set(2,descipcionText);
        ((HBox)vBox2.getChildren().get(3)).getChildren().set(1,contexturaLabel);
        ((HBox)vBox2.getChildren().get(4)).getChildren().set(1,intelligenceLabel);
        ((HBox)vBox2.getChildren().get(5)).getChildren().set(1,skinLabel);
        ((HBox)vBox2.getChildren().get(6)).getChildren().set(1,minHeightLabel);
        ((HBox)vBox2.getChildren().get(6)).getChildren().set(3,maxHeightLabel);
        ((HBox)vBox2.getChildren().get(6)).getChildren().set(4,heightUnit);
        ((HBox)vBox2.getChildren().get(7)).getChildren().set(1,minWeightLabel);
        ((HBox)vBox2.getChildren().get(7)).getChildren().set(3,maxWeightLabel);
        ((HBox)vBox2.getChildren().get(7)).getChildren().set(4,weightUnit);
    }

    @FXML public void delete(ActionEvent event){
        Alert alert = new Alert(Alert.AlertType.CONFIRMATION);
        alert.setContentText("¿Está seguro que desea elimnar esta raza?");

        Optional<ButtonType> result = alert.showAndWait();
        if (result.get() == ButtonType.OK){
            System.out.println("Se elimina esta instancia");
            try {
                Parent root = FXMLLoader.load(getClass().getResource("Animals-Details.fxml"));
                ((Pane)Main.myStage.getScene().getRoot().getChildrenUnmodifiable().get(1)).getChildren().setAll(root);
            }catch (Exception e){
                e.printStackTrace();
            }
        } else {}
    }

    @FXML public void selectTall(MouseEvent mouseEvent) {
        if(activeEdit){
            int i = -1;
            switch (mouseEvent.getPickResult().getIntersectedNode().getId()){
                case "tinyIcon":
                    tallLabel.setText("Mini");
                    i = 0;
                    break;
                case "smallIcon":
                    tallLabel.setText("Pequeña");
                    i = 1;
                    break;
                case "mediumIcon":
                    tallLabel.setText("Mediana");
                    i = 2;
                    break;
                case "bigIcon":
                    tallLabel.setText("Grande");
                    i = 3;
                    break;
                case "gigantIcon":
                    tallLabel.setText("Gigante");
                    i = 4;
                    break;
            }
            for(int j = 0; j<5; j++){
                if(j==i){
                    icons[j].getStyleClass().setAll("secundary");
                }else{
                    icons[j].getStyleClass().setAll("secundary-light");
                }
            }
        }

    }

}
