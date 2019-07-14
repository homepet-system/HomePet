package API.supportClasses;

import com.jfoenix.controls.JFXButton;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.image.ImageView;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import main.Main;

import java.util.List;

public class ButtonsCreator {

    public static void createBtnLess4(int n, List<String> list, HBox hBox, JFXButton mainBtn, JFXButton addBtn, int fitWidth){
        int actualList = 0;

        for(int j = 0; j<n;j++){
                if(j==0){
                    mainBtn.setText(list.get(actualList));
                    actualList++;
                }else {

                    createAnotherBtn(mainBtn,hBox,list,actualList, fitWidth);
                    actualList++;
            }
        }
        hBox.getChildren().add(addBtn);
    }


    public static void createBtnMore4(int n, List<String> list, HBox hBox, VBox vBox, JFXButton mainBtn, JFXButton addBtn, int fitWidth){
        int numDiv = (int)Math.ceil((double)n/4);
        HBox[] hBoxes;
        int maximo;
        int actualList = 0;

        System.out.println(numDiv);

        if(n % 4 == 0){
            hBoxes = new HBox[numDiv+1];
            maximo = numDiv+1;
        }else{
            hBoxes = new HBox[numDiv];
            maximo = numDiv;
        }

        hBoxes[0] = hBox;

        for(int i = 1; i <maximo; i++){
            hBoxes[i] = new HBox();
            hBoxes[i].setPrefHeight(hBox.getPrefHeight());
            hBoxes[i].setSpacing(hBox.getSpacing());
        }

        for(int j = 0; j<maximo;j++){
            for(int k  = 0; k<4; k++){
                if(actualList==n){
                    break;
                }
                if(j==0  && k==0){
                    mainBtn.setText(list.get(actualList));
                    actualList++;
                }else {
                    createAnotherBtn(mainBtn,hBoxes[j],list,actualList, fitWidth);
                    actualList++;
                }
            }
            if(j!=0){
                vBox.getChildren().add(hBoxes[j]);
            }
            if(j>1){
                vBox.setPrefHeight(vBox.getPrefHeight()+200);
            }
        }
        hBoxes[maximo-1].getChildren().add(addBtn);
    }

    private static void createAnotherBtn(JFXButton mainBtn, HBox hBox, List<String> list, int actualList, int fitWidth){
        JFXButton btn = new JFXButton(list.get(actualList));
        btn.setPrefWidth(mainBtn.getPrefWidth());
        btn.setPrefHeight(mainBtn.getPrefHeight());
        ImageView img = new ImageView();
        img.setPreserveRatio(false);
        img.setFitWidth(fitWidth);
        img.setFitHeight(fitWidth);
        btn.setGraphic(img);
        btn.setGraphicTextGap(mainBtn.getGraphicTextGap());
        btn.setContentDisplay(mainBtn.getContentDisplay());
        btn.setFont(mainBtn.getFont());
        btn.getStyleClass().addAll(mainBtn.getStyleClass());
        hBox.getChildren().add(btn);
    }

    public static void setBtns(int n, VBox vBox, EventHandler<ActionEvent> eventHandler){
        int div =  Math.round((float)n/4);
        int actual = 0;
        for(int i = 0; i<div;i++){
            for(int j = 0; j<4;j++){
                if(actual==n){
                    break;
                }
                ((JFXButton)((HBox)vBox.getChildren().get(i)).getChildren().get(j)).setOnAction(eventHandler);
                actual++;
            }
        }
    }
}
