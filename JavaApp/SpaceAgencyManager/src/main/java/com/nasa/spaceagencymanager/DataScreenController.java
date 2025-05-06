package com.nasa.spaceagencymanager;

import database.entities.Equipment;
import database.entities.Mission;
import database.entities.Partner;
import database.entities.Planet;
import database.entities.Research;
import database.entities.Spacecraft;
import database.entities.Staff;
import java.io.IOException;
import java.net.URL;
import java.util.Optional;
import java.util.ResourceBundle;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.ButtonType;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.scene.control.TableView;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 * FXML Controller class
 *
 * @author mohab
 */
public class DataScreenController implements Initializable {
    
    @FXML
    private TableView mainTable;
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
    
    @FXML
    private void LoadData() {
        // Change the cursor to loading (wait) cursor
        mainTable.getScene().setCursor(javafx.scene.Cursor.WAIT);
        
        String selectedTable = dropDownBox.getValue();
        
        if (selectedTable == null) {
            tableNameLabel.setText("Please choose a valid option");
            // Reset the cursor to default
            mainTable.getScene().setCursor(javafx.scene.Cursor.DEFAULT);
            return;
        }
        
        tableNameLabel.setText(selectedTable);
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("SpaceManagerPU");
        Class<?> entityClass = null;
        
        switch (selectedTable) {
            case "staff":
                entityClass = Staff.class;
                break;
            case "missions":
                entityClass = Mission.class;
                break;
            case "planets":
                entityClass = Planet.class;
                break;
            case "spacecrafts":
                entityClass = Spacecraft.class;
                break;
            case "equipment":
                entityClass = Equipment.class;
                break;
            case "partners":
                entityClass = Partner.class;
                break;
            case "research":
                entityClass = Research.class;
                break;
            default:
                System.out.println("Unknown table: " + selectedTable);
                break;
        }
        
        if (entityClass != null) {
            // Load the data into the table
            TableLoader.loadEntityToTable(emf, mainTable, entityClass);
        } else {
            System.out.println("Unknown table: " + selectedTable);
        }

        // Reset the cursor to default after the data is loaded
        mainTable.getScene().setCursor(javafx.scene.Cursor.DEFAULT);
    }
    
    @FXML
    private void deleteSelectedRow() {
        // Get the selected row from the TableView
        Object selectedRow = mainTable.getSelectionModel().getSelectedItem();
        
        if (selectedRow == null) {
            // If no row is selected, show an error message
            System.out.println("Please select a row to delete.");
            return;
        }
        
        boolean confirmed = showConfirmationDialog();
        
        if (confirmed) {
            // delete part
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("SpaceManagerPU");
            EntityManager em = emf.createEntityManager();
            
            try {
                em.getTransaction().begin();
                try {
                    // Merge and delete the selected row entity
                    em.remove(em.contains(selectedRow) ? selectedRow : em.merge(selectedRow));
                } catch (Exception e) {
                    tableNameLabel.setText(e.getMessage());
                    
                }
                // Commit the transaction
                em.getTransaction().commit();
                showSuccessDialog("Row deleted successfully.");

                // Refresh
                LoadData();
            } catch (Exception e) {
                showErrorDialog(e.getMessage());
                e.printStackTrace();
                em.getTransaction().rollback(); // Rollback if any error occurs
            } finally {
                em.close();
            }
        }
    }
    private void showSuccessDialog(String s) {
    Alert alert = new Alert(Alert.AlertType.INFORMATION);
    alert.setTitle("Success!");
    alert.setHeaderText("Operation Successful");
    alert.setContentText(s);

    // Show the alert and wait for the user to close it
    alert.showAndWait();
}

    private void showErrorDialog(String s) {
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle("Aw Snap!");
        alert.setHeaderText("Sorry for any inconvenience");
        alert.setContentText(s);

        // Show the alert and wait for the user to close it
        alert.showAndWait();
    }
    
    private boolean showConfirmationDialog() {
        // Display a confirmation dialog before deletion
        Alert alert = new Alert(Alert.AlertType.CONFIRMATION);
        alert.setTitle("Confirm Deletion");
        alert.setHeaderText("Are you sure you want to delete this item?");
        alert.setContentText("This action cannot be undone.");
        
        Optional<ButtonType> result = alert.showAndWait();
        return result.isPresent() && result.get() == ButtonType.OK;
    }
    
    @FXML
    private void backToFirstScreen() throws IOException {
        App.setRoot("firstScreen");
    }
    
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        dropDownBox.getItems().addAll(
                "staff", "spacecrafts", "partners", "missions", "planets", "equipment", "research"
        );
        dropDownBox.setPromptText("Select a table");
    }
}
