package com.nasa.spaceagencymanager;

import java.lang.reflect.Field;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.stage.Stage;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class InsertFormController {

    @FXML
    private Label formTitle;
    @FXML
    private Button submitButton;

    // 15 input fields to use dynamically
    @FXML private TextField field1, field2, field3, field4, field5;
    @FXML private TextField field6, field7, field8, field9, field10;
    @FXML private TextField field11, field12, field13, field14, field15;

    private Map<String, TextField> dynamicFieldMap = new HashMap<>();
    private Class<?> entityClass;
    private String targetTable;

    public void setTargetTable(String tableName) {
        this.targetTable = tableName;
        this.entityClass = TableEntityMapper.getEntityClass(tableName);
        buildDynamicForm();
    }

    private void buildDynamicForm() {
        Field[] fields = entityClass.getDeclaredFields();
        TextField[] inputs = {
                field1, field2, field3, field4, field5,
                field6, field7, field8, field9, field10,
                field11, field12, field13, field14, field15
        };

        for (int i = 0; i < Math.min(fields.length, inputs.length); i++) {
            fields[i].setAccessible(true);
            String fieldName = fields[i].getName();
            dynamicFieldMap.put(fieldName, inputs[i]);
            inputs[i].setPromptText(fieldName);
            inputs[i].setVisible(true);
        }

        // Hide unused fields
        for (int i = fields.length; i < inputs.length; i++) {
            inputs[i].setVisible(false);
        }

        formTitle.setText("Insert into " + targetTable);
    }

    @FXML
    private void submitForm() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("SpaceManagerPU");
        EntityManager em = emf.createEntityManager();
        try {
            Object entityInstance = entityClass.getDeclaredConstructor().newInstance();

            for (Map.Entry<String, TextField> entry : dynamicFieldMap.entrySet()) {
                String fieldName = entry.getKey();
                String inputValue = entry.getValue().getText();

                if (inputValue.isEmpty()) continue;

                Field field = entityClass.getDeclaredField(fieldName);
                field.setAccessible(true);

                Object value = castToFieldType(field.getType(), inputValue);
                field.set(entityInstance, value);
            }

            em.getTransaction().begin();
            em.persist(entityInstance);
            em.getTransaction().commit();

            ((Stage) submitButton.getScene().getWindow()).close();

        } catch (Exception e) {
            e.printStackTrace();
            showErrorDialog("Error inserting data: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    private Object castToFieldType(Class<?> type, String value) {
        try {
            if (type == String.class) return value;
            if (type == int.class || type == Integer.class) return Integer.parseInt(value);
            if (type == float.class || type == Float.class) return Float.parseFloat(value);
            if (type == double.class || type == Double.class) return Double.parseDouble(value);
            if (type == long.class || type == Long.class) return Long.parseLong(value);
            if (type == char.class || type == Character.class) return value.charAt(0);
            if (type == java.sql.Date.class) return Date.valueOf(value);
            // Add other types if needed
        } catch (Exception e) {
            System.err.println("Conversion error for type " + type.getSimpleName() + ": " + value);
        }
        return null;
    }

    private void showErrorDialog(String msg) {
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle("Insert Error");
        alert.setHeaderText("Failed to insert data");
        alert.setContentText(msg);
        alert.showAndWait();
    }
}