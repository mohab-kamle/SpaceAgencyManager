package com.nasa.spaceagencymanager;
import javafx.fxml.FXML;

public class PrimaryController {

   /* @FXML
    private void switchToSecondary() throws IOException {
        //test database connectivity 
        String nametest;
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("SpaceManagerPU");
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        Staff s = em.find(Staff.class, "01-2017908");
        System.out.println(s);
    }*/
    @FXML
    private void switchToFirstScreen() throws Exception {
        App.setRoot("firstScreen");
    }
}
