/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/javafx/FXMLController.java to edit this template
 */
package com.nasa.spaceagencymanager;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;

/**
 * FXML Controller class
 *
 * @author Ziad
 */
public class QueriesScreenController implements Initializable {

    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
    } 
    @FXML
    private void BackToFirstScreen() {
        try {
            App.setRoot("firstScreen");
        } catch (IOException ex) {
            Logger.getLogger(FirstScreenController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    @FXML
    private void dimButton(javafx.scene.input.MouseEvent event) {
        Button hoveredButton = (Button) event.getSource();
        hoveredButton.setOpacity(0.6);
    }
    
    @FXML
    private void lightenButton(javafx.scene.input.MouseEvent event) {
        Button hoveredButton = (Button) event.getSource();
        hoveredButton.setOpacity(1.0);
    }
    
}
