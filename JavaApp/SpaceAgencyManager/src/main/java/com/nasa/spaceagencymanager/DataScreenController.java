package com.nasa.spaceagencymanager;

import java.io.IOException;
import java.net.URL;
import java.util.Optional;
import java.util.ResourceBundle;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.input.MouseEvent;
import javafx.stage.Modality;
import javafx.stage.Stage;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class DataScreenController implements Initializable {

    @FXML
    private TableView<Object> mainTable;

    @FXML
    private Label tableNameLabel;

    @FXML
    private ComboBox<String> dropDownBox;

    @FXML
    private void dimButton(MouseEvent event) {
        ((Button) event.getSource()).setOpacity(0.6);
    }

    @FXML
    private void lightenButton(MouseEvent event) {
        ((Button) event.getSource()).setOpacity(1.0);
    }

    @FXML
    private void LoadData() {
        mainTable.getScene().setCursor(javafx.scene.Cursor.WAIT);
        String selectedTable = dropDownBox.getValue();

        if (selectedTable == null) {
            tableNameLabel.setText("Please choose a valid option");
            mainTable.getScene().setCursor(javafx.scene.Cursor.DEFAULT);
            return;
        }

        tableNameLabel.setText(selectedTable);
        Class<?> entityClass = TableEntityMapper.getEntityClass(selectedTable);

        if (entityClass != null) {
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("SpaceManagerPU");
            TableLoader.loadEntityToTable(emf, mainTable, entityClass);
        } else {
            tableNameLabel.setText("Unknown table selected.");
        }

        mainTable.getScene().setCursor(javafx.scene.Cursor.DEFAULT);
    }

    @FXML
    private void deleteSelectedRow() {
        Object selectedRow = mainTable.getSelectionModel().getSelectedItem();

        if (selectedRow == null) {
            System.out.println("Please select a row to delete.");
            return;
        }

        if (showConfirmationDialog()) {
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("SpaceManagerPU");
            EntityManager em = emf.createEntityManager();

            try {
                em.getTransaction().begin();
                try {
                    em.remove(em.contains(selectedRow) ? selectedRow : em.merge(selectedRow)); //============> removes from table
                } catch (Exception e) {
                    tableNameLabel.setText(e.getMessage());
                }
                em.getTransaction().commit(); //===============> actual line that save updates/changes to database
                showSuccessDialog("Row deleted successfully.");
                LoadData(); //================> should load data when table is updated 
            } catch (Exception e) {
                showErrorDialog(e.getMessage());
                e.printStackTrace();
                em.getTransaction().rollback();
            } finally {
                em.close();
            }
        }
    }

    private void showSuccessDialog(String msg) {
        Alert alert = new Alert(Alert.AlertType.INFORMATION);
        alert.setTitle("Success!");
        alert.setHeaderText("Operation Successful");
        alert.setContentText(msg);
        alert.showAndWait();
    }

    private void showErrorDialog(String msg) {
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle("Aw Snap!");
        alert.setHeaderText("Sorry for any inconvenience");
        alert.setContentText(msg);
        alert.showAndWait();
    }

    private boolean showConfirmationDialog() {
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

    @FXML
    private void insertData() {
        try {
            String selectedTable = dropDownBox.getValue();
            if (selectedTable == null) {
                tableNameLabel.setText("Please choose a valid option");
                return;
            }
FXMLLoader loader = new FXMLLoader(App.class.getResource("insertForm.fxml"));            
            Parent root = loader.load();
            InsertFormController controller = loader.getController();
            controller.setTargetTable(selectedTable);

            Stage popupStage = new Stage();
            popupStage.setTitle("Insert Data");
            popupStage.initModality(Modality.APPLICATION_MODAL);
            popupStage.setScene(new Scene(root));
            popupStage.showAndWait();

            LoadData();

        } catch (IOException e) {
            e.printStackTrace();
            showErrorDialog("Failed to open insert form: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            showErrorDialog("Unexpected error: " + e.getMessage());
        }
    }
    
    
    @FXML
    private void updateData() {
        try {
            Object selectedRow = mainTable.getSelectionModel().getSelectedItem();
            String selectedTable = dropDownBox.getValue();
            if (selectedTable == null) {
                tableNameLabel.setText("Please choose a valid option");
                return;
            }
FXMLLoader loader = new FXMLLoader(App.class.getResource("updateForm.fxml"));            
            Parent root = loader.load();
            UpdateFormController controller = loader.getController();
            controller.setTargetTable(selectedTable, mainTable); //======================> here's where we're gonna pass thet 

            Stage popupStage = new Stage();
            popupStage.setTitle("Update Data");
            popupStage.initModality(Modality.APPLICATION_MODAL);
            popupStage.setScene(new Scene(root));
            popupStage.showAndWait();

            LoadData();

        } catch (IOException e) {
            e.printStackTrace();
            showErrorDialog("Failed to open update form: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            showErrorDialog("Unexpected error: " + e.getMessage());
        }
    }

}

