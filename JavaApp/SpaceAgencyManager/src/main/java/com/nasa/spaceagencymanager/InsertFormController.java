package com.nasa.spaceagencymanager;

import com.mysql.cj.jdbc.exceptions.MysqlDataTruncation;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Modifier;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.stage.Stage;
import javax.persistence.Entity;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.PersistenceException;

public class InsertFormController {

    @FXML
    private Label formTitle;
    @FXML
    private Button submitButton;

    // 15 input fields to use dynamically
    @FXML
    private TextField field1, field2, field3, field4, field5;
    @FXML
    private TextField field6, field7, field8, field9, field10;
    @FXML
    private TextField field11, field12, field13, field14, field15;

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
            if (Modifier.isStatic(fields[i].getModifiers()) || fields[i].getName().equals("serialVersionUID")) continue;
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
    private void submitForm() throws IllegalArgumentException, NoSuchFieldException, IllegalAccessException, NoSuchMethodException, InvocationTargetException, InstantiationException {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("SpaceManagerPU");
        EntityManager em = emf.createEntityManager();
        try {
            Object entityInstance = entityClass.getDeclaredConstructor().newInstance();

            // Populate the entity instance fields
            for (Map.Entry<String, TextField> entry : dynamicFieldMap.entrySet()) {
                String fieldName = entry.getKey();
                String inputValue = entry.getValue().getText();

                if (inputValue.isEmpty()) {
                    continue;
                }

                Field field = entityClass.getDeclaredField(fieldName);
                field.setAccessible(true);

                // If the field is a foreign key, check the ID
                if (isForeignKeyField(field)) {
                    String foreignKeyId = inputValue;
                    Object relatedEntity = checkForeignKeyId(em, field.getType(), foreignKeyId);
                    if (relatedEntity != null) {
                        field.set(entityInstance, relatedEntity);
                    } else {
                        showErrorDialog("Invalid ID for foreign key: " + inputValue);
                        return; // Exit if invalid foreign key
                    }
                } else {
                    // Cast the input to the correct field type
                    Object value = castToFieldType(field.getType(), inputValue);
                    field.set(entityInstance, value); //======================> set fields with new data before going back to database
                }
            }

            // Start the transaction and persist the entity // updating databases with changes
            em.getTransaction().begin();
            em.persist(entityInstance);
            em.getTransaction().commit();

            // Close the window and show success message
            ((Stage) submitButton.getScene().getWindow()).close();
            showSuccessDialog("Data inserted successfully!");

        } catch (PersistenceException e) {
            Throwable cause = e.getCause();
            while (cause != null) {
                if (cause instanceof MysqlDataTruncation) {
                    showErrorDialog("One of the fields contains data that is too long. Please check your input.");
                    break;
                }
                cause = cause.getCause();
            }

            // General exception handling
            if (cause == null) {
                showErrorDialog("An error occurred while inserting the data: " + e.getMessage());
            }

            // Print the full stack trace for debugging
            e.printStackTrace();
        } finally {
            // Make sure the EntityManager is closed after operation
            em.close();
        }

    }

    private boolean isForeignKeyField(Field field) {
        // Check if the field is a foreign key (i.e., a reference to another entity)
        return field.getType().getAnnotation(Entity.class) != null;
    }

    private Object checkForeignKeyId(EntityManager em, Class<?> relatedEntityClass, String foreignKeyId) {
    Object relatedEntity = em.find(relatedEntityClass, foreignKeyId);
    if (relatedEntity == null) {
        System.out.println("Foreign Key ID " + foreignKeyId + " not found in table " + relatedEntityClass.getSimpleName());
    }
    return relatedEntity;
}


    private Object castToFieldType(Class<?> type, String value) {
        try {
            if (type == String.class) {
                return value;
            }
            if (type == int.class || type == Integer.class) {
                return Integer.parseInt(value);
            }
            if (type == float.class || type == Float.class) {
                return Float.parseFloat(value);
            }
            if (type == double.class || type == Double.class) {
                return Double.parseDouble(value);
            }
            if (type == long.class || type == Long.class) {
                return Long.parseLong(value);
            }
            if (type == char.class || type == Character.class) {
                return value.charAt(0);
            }
            if (type == java.sql.Date.class) {
                return Date.valueOf(value);
            }
            if(type ==  boolean.class || type == Boolean.class){
               if(value.equalsIgnoreCase("true")) return true;
               else if(value.equalsIgnoreCase("false")) return false;
            }
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

    private void showSuccessDialog(String msg) {
        Alert alert = new Alert(Alert.AlertType.INFORMATION);
        alert.setTitle("Success");
        alert.setHeaderText("Operation Completed Successfully");
        alert.setContentText(msg);
        alert.showAndWait();
    }

}
