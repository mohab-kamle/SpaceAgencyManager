package com.nasa.spaceagencymanager;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.effect.DropShadow;
import javafx.scene.input.MouseEvent;
import javafx.scene.paint.Color;

public class FirstScreenController implements Initializable {

    @FXML
    public Button TableB;
    @FXML
    public Button QueryB;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        TableB.setOnMouseEntered(this::handleMouseEnterT);
        TableB.setOnMouseExited(this::handleMouseLeaveT);
        QueryB.setOnMouseEntered(this::handleMouseEnterB);
        QueryB.setOnMouseExited(this::handleMouseLeaveB);

        TableB.setOnAction(e -> goToDataScreen());
        QueryB.setOnAction(e -> goToQueriesScreen());
    }

    @FXML
    public void handleMouseEnterT(MouseEvent event) {
        DropShadow dropShadow = new DropShadow();
        dropShadow.setColor(Color.web("#ffcb05"));
        dropShadow.setOffsetX(0);
        dropShadow.setOffsetY(0);
        dropShadow.setWidth(150);
        dropShadow.setHeight(150);
        dropShadow.setRadius(30);
        dropShadow.setSpread(0.3);

        TableB.setEffect(dropShadow);
        TableB.setScaleX(1.05);
        TableB.setScaleY(1.05);
    }

    @FXML
    public void handleMouseLeaveT(MouseEvent event) {
        TableB.setEffect(null);
        TableB.setScaleX(1);
        TableB.setScaleY(1);
    }

    @FXML
    public void handleMouseEnterB(MouseEvent event) {
        DropShadow dropShadow = new DropShadow();
        dropShadow.setColor(Color.web("#ffcb05"));
        dropShadow.setOffsetX(0);
        dropShadow.setOffsetY(0);
        dropShadow.setWidth(150);
        dropShadow.setHeight(150);
        dropShadow.setRadius(30);
        dropShadow.setSpread(0.3);

        QueryB.setEffect(dropShadow);
        QueryB.setScaleX(1.05);
        QueryB.setScaleY(1.05);
    }

    @FXML
    public void handleMouseLeaveB(MouseEvent event) {
        QueryB.setEffect(null);
        QueryB.setScaleX(1);
        QueryB.setScaleY(1);
    }

    private void goToDataScreen() {
        try {
            App.setRoot("dataScreen");
        } catch (IOException ex) {
            Logger.getLogger(FirstScreenController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void goToQueriesScreen() {
        try {
            App.setRoot("queriesScreen");
        } catch (IOException ex) {
            Logger.getLogger(FirstScreenController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
