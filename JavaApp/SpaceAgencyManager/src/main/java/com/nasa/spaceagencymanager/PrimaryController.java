package com.nasa.spaceagencymanager;

import javafx.fxml.FXML;
import javafx.scene.control.Button;

public class PrimaryController {

    @FXML
    private Button primaryButton;

    @FXML
    private void switchToFirstScreen() throws Exception {
        App.setRoot("firstScreen");
    }
    
    @FXML
    private void dimButton() {
        primaryButton.setOpacity(0.6); // dim it
    }
    @FXML
    private void lightenButton() {
        primaryButton.setOpacity(1.0); // back to full
    }

}
