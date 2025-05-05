package com.nasa.spaceagencymanager;

import database.entities.Staff;
import java.io.IOException;
import javafx.fxml.FXML;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class PrimaryController {

    @FXML
    private void switchToSecondary() throws IOException {
        //test database connectivity 
        String nametest;
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("SpaceManagerPU");
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        Staff s = em.find(Staff.class, "01-2017908");
        System.out.println(s);
    }
}
