package com.nasa.spaceagencymanager;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.List;
import javafx.beans.property.ReadOnlyObjectWrapper;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

public class TableLoader {

    public static void loadEntityToTable(EntityManagerFactory emf, TableView<Object> tableView, Class<?> entityClass) {
        EntityManager em = emf.createEntityManager();
        tableView.getColumns().clear();

        for (Field field : entityClass.getDeclaredFields()) {
            if (Modifier.isStatic(field.getModifiers()) || field.getName().equals("serialVersionUID")) continue;

            field.setAccessible(true);
            Class<?> fieldType = field.getType();

            // Create column with correct type
            TableColumn<Object, ?> column = createTypedColumn(field.getName(), field, fieldType);
            if (column != null) {
                tableView.getColumns().add(column);
            }
        }

        List<?> results = em.createQuery("FROM " + entityClass.getSimpleName(), entityClass).getResultList();
        tableView.getItems().setAll(results);
    }

    private static <T> TableColumn<Object, T> createTypedColumn(String name, Field field, Class<T> fieldType) {
        TableColumn<Object, T> column = new TableColumn<>(name);
        column.setCellValueFactory(cellData -> {
            try {
                T value = fieldType.cast(field.get(cellData.getValue()));
                return new ReadOnlyObjectWrapper<>(value);
            } catch (IllegalAccessException | ClassCastException e) {
                e.printStackTrace();
                return new ReadOnlyObjectWrapper<>(null);
            }
        });
        return column;
    }
}
