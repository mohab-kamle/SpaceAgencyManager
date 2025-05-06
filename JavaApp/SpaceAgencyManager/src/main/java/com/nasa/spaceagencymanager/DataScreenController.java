package com.nasa.spaceagencymanager;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;

/**
 * FXML Controller class
 *
 * @author mohab
 */
public class DataScreenController implements Initializable {
    @FXML
    private Label tableNameLabel;
    @FXML
    private ComboBox<String> dropDownBox;

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
    //TO DO
    @FXML
    private void LoadData() {
        String selectedTable = dropDownBox.getValue();

        if (selectedTable == null) {
            tableNameLabel.setText("please choose a valid option");
            return;
        }
        tableNameLabel.setText(selectedTable);
        System.out.println("Loading data from table: " + selectedTable);

        // Replace this with real logic to load from DB
        switch (selectedTable) {
            case "astronauts":
                // load astronauts table
                break;
            case "missions":
                // load missions table
                break;
            // add more 
        }
    }

    @FXML
    private void backToFirstScreen() throws IOException {
        App.setRoot("firstScreen");
    }

    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        dropDownBox.getItems().addAll(
                "staff",
                "spacecrafts",
                "partners",
                "missions",
                "planets",
                "equipment",
                "research"
        );

        dropDownBox.setPromptText("Select a table");
    }

}
