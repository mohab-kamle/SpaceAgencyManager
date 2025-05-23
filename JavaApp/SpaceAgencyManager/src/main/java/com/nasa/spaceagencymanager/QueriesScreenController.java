package com.nasa.spaceagencymanager; // Assuming this entity exists for queries
import database.entities.Conduct;
import database.entities.Participate;
import database.entities.Research;
import database.entities.Staff;

import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.beans.property.ReadOnlyObjectWrapper;

import javafx.beans.property.SimpleObjectProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label; // For placeholder
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Tuple;
import javax.persistence.criteria.*;

/**
 * FXML Controller class for displaying query results.
 * Refactored to use JPA Criteria API and improve efficiency.
 *
 * @author Ziad (Original Author), Refactored by AI
 */
public class QueriesScreenController implements Initializable {

    @FXML
    private TableView<Object> QueryDisc; // TableView to display results (can be Staff or Object[] for aggregates)

    @FXML
    private ComboBox<String> QueryList;

    private static EntityManagerFactory emf; // Static EMF to be initialized once

    // Helper to initialize EMF if not already done
    private static synchronized void initializeEntityManagerFactory() { // synchronized for thread safety if called concurrently
        if (emf == null) {
            try {
                emf = Persistence.createEntityManagerFactory("SpaceManagerPU");
            } catch (Exception e) {
                Logger.getLogger(QueriesScreenController.class.getName()).log(Level.SEVERE, "Failed to create EntityManagerFactory", e);
                // Handle error appropriately, maybe show an alert to the user or disable functionality
            }
        }
    }

    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        initializeEntityManagerFactory(); // Initialize EMF when controller is loaded
        QueryList.getItems().addAll(
            "Query 1: get all researchs of org with code 10 ",
            "Query 2: Staff Salary > 100k",
            "Query 3: Programmers",
            "Query 4: Staff Name starts with 'A'",
            "Query 5: get details of the ternary conduct",
            "Query 6: Get all male staff that conducts Research"
        );
        QueryList.setPromptText("Select a Query");
        // Set a default placeholder
        QueryDisc.setPlaceholder(new Label("Please select a query and click 'Load Data'."));
    }

    @FXML
    private void BackToFirstScreen() {
        try {
            App.setRoot("firstScreen");
        } catch (IOException ex) {
            // It's better to use the class name of the current controller for the logger
            Logger.getLogger(QueriesScreenController.class.getName()).log(Level.SEVERE, "Error navigating back to FirstScreen", ex);
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

    /**
     * Loads and displays data based on the selected query.
     */
    @FXML
    private void LoadData() {
        String selectedQueryChoice = QueryList.getValue();
        if (selectedQueryChoice == null) {
            QueryDisc.getItems().clear();
            QueryDisc.getColumns().clear();
            QueryDisc.setPlaceholder(new Label("Please select a query."));
            return;
        }
        if (emf == null) {
            QueryDisc.getItems().clear();
            QueryDisc.getColumns().clear();
            QueryDisc.setPlaceholder(new Label("Database connection error. Cannot load data."));
            // Optionally, try to re-initialize EMF or show an error dialog
            // initializeEntityManagerFactory(); // Attempt re-initialization
            // if(emf == null) return; // if still null, exit
            return;
        }

        QueryDisc.setPlaceholder(new Label("Loading data...")); // Placeholder while loading

        // Extract the query identifier part (e.g., "Query 1")
        String queryKey = selectedQueryChoice.split(":")[0].trim();

        // Clear previous results and columns before loading new data
        QueryDisc.getItems().clear();
        QueryDisc.getColumns().clear();


        switch (queryKey) {
            case "Query 1": // worked
                getRsearchThatAspecificPartnerParticipatesIn();
                break;
            case "Query 2": // Query 2 and 4 are the same as per original logic // Worked
                displayStaffData(getStaffWithSalaryGreaterThan(100000.0));
                break;
            case "Query 3": // worked
                displayStaffData(getProgrammers());
                break;
            case "Query 4": // worked
                displayStaffData(getStaffWithNameStartingWith("A"));
                break;
            case "Query 5":
                getRelationsInConduct();
                QueryDisc.setPlaceholder(new Label("sorry but this method working in terminal but not in UI, Ask Doctor"));
                break;
            case "Query 6": // Corrected typo from "qyery 7" // worked
//                displayDepartmentStaffCounts();
                getAllMaleStaffThatConductsResearch();
                break;
//            case "Query 7":
////                displayStaffAndRoles();
//                break;
            default:
                QueryDisc.setPlaceholder(new Label("Invalid query selected or not implemented."));
                break;
        }
    }
    
    // the main issue was the hole table was inserted in the tableView not specoific columns
    private void displayResearchData(List<Research> researchList) {
        QueryDisc.getColumns().clear(); // Clear previous columns

        TableColumn<Object, String> idCol = new TableColumn<>("ID");
        idCol.setCellValueFactory(cellData -> {
            Research research = (Research) cellData.getValue();
            return new SimpleStringProperty(research.getResearchID().toString());
        });

        TableColumn<Object, String> titleCol = new TableColumn<>("Title");
        titleCol.setCellValueFactory(cellData -> {
            Research research = (Research) cellData.getValue();
            return new SimpleStringProperty(research.getName());
        });

        // Add more columns as needed...

        QueryDisc.getColumns().addAll(idCol, titleCol);
        QueryDisc.setItems(FXCollections.observableArrayList(researchList));
    }  
    
    
     // A better approach would be to pass Staff.class directly if we know it's Staff
   private void getRsearchThatAspecificPartnerParticipatesIn() {  
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("SpaceManagerPU");     
        EntityManager em = emf.createEntityManager();          
        em.getTransaction();    
        List<Participate> participatefList = em.createNamedQuery("Participate.findAll", Participate.class).getResultList();
        List<Research> result = new ArrayList<>();
        for(Participate p: participatefList){
               
               if(p.getPartner().getOrgCode().equalsIgnoreCase("10")){
                   result.add(p.getResearch());
               }

        }
//        QueryDisc.getItems().setAll(result);
        displayResearchData(result);
        System.out.println("Result done");
    }

    /**
     * Sets up columns for Staff entity and displays the data.
     * Relies on TableEntityMapper and TableLoader to correctly set up Staff columns.
     * @param staffList The list of Staff objects to display.
     */
    private void displayStaffData(List<Staff> staffList) {
        if (staffList == null) {
            staffList = new ArrayList<>(); // Ensure list is not null for FXCollections
            Logger.getLogger(QueriesScreenController.class.getName()).log(Level.WARNING, "Received null staff list for display.");
        }

        // Assuming TableEntityMapper and TableLoader are designed to set up Staff columns
        // QueryDisc.getColumns().clear(); // Ensure columns are cleared before TableLoader adds new ones
        Class<?> entityClass = null;
        try {
            // This is a bit of a hack if TableEntityMapper is not robus
            entityClass = TableEntityMapper.getEntityClass("staff");
        } catch (Exception e) {
             Logger.getLogger(QueriesScreenController.class.getName()).log(Level.SEVERE, "Error getting entity class via TableEntityMapper for 'staff'.", e);
        }

        if (entityClass != null && entityClass.equals(Staff.class)) {
            try {
                TableLoader.loadEntityToTable(emf, QueryDisc, entityClass); // This should set up columns for Staff
            } catch (Exception e) {
                Logger.getLogger(QueriesScreenController.class.getName()).log(Level.SEVERE, "Error loading Staff entity to table via TableLoader. Manually creating columns.", e);
                setupStaffColumnsManually(); // Fallback
            }
        } else {
            // Fallback or if TableEntityMapper is not used/available for this specific type
            Logger.getLogger(QueriesScreenController.class.getName()).log(Level.WARNING,
                    "Could not get Staff.class via TableEntityMapper or it returned an unexpected type. Manually creating Staff columns.");
            setupStaffColumnsManually();
        }

        QueryDisc.setItems(FXCollections.observableArrayList(staffList));
        if (staffList.isEmpty()) {
            QueryDisc.setPlaceholder(new Label("No staff members found for this query."));
        }
    }

    /**
     * Fallback method to manually create columns for the Staff entity.
     * This is used if TableLoader fails or is not configured for Staff.
     */
    private void setupStaffColumnsManually() {
        QueryDisc.getColumns().clear(); // Clear any existing columns

        TableColumn<Object, String> idCol = new TableColumn<>("ID");
        idCol.setCellValueFactory(cellData -> {
            Staff staff = (Staff) cellData.getValue();
            // Assuming Staff has getId() that returns Long or Integer
            return new SimpleStringProperty(staff.getCin()!= null ? staff.getCin().toString() : "N/A");
        });

        TableColumn<Object, String> nameCol = new TableColumn<>("Name");
        nameCol.setCellValueFactory(cellData -> {
            Staff staff = (Staff) cellData.getValue();
            return new SimpleStringProperty(staff.getFname());
        });

        TableColumn<Object, String> jobTypeCol = new TableColumn<>("Job Type");
        jobTypeCol.setCellValueFactory(cellData -> {
            Staff staff = (Staff) cellData.getValue();
            return new SimpleStringProperty(staff.getJobtype());
        });

        TableColumn<Object, String> salaryCol = new TableColumn<>("Salary");
        salaryCol.setCellValueFactory(cellData -> {
            Staff staff = (Staff) cellData.getValue();
            return new SimpleStringProperty(String.format("%.2f", staff.getSalary()));
        });

        QueryDisc.getColumns().addAll(idCol, nameCol, jobTypeCol, salaryCol);
    }


    // --- Query Methods using Criteria API ---

    private List<Staff> getAllStaff() {
        if (emf == null) return new ArrayList<>();
        EntityManager em = emf.createEntityManager();
        try {
            CriteriaBuilder cb = em.getCriteriaBuilder();
            CriteriaQuery<Staff> cq = cb.createQuery(Staff.class);
            Root<Staff> staffRoot = cq.from(Staff.class);
            cq.select(staffRoot);
            return em.createQuery(cq).getResultList();
        } catch (Exception e) {
            Logger.getLogger(QueriesScreenController.class.getName()).log(Level.SEVERE, "Error fetching all staff", e);
            return new ArrayList<>();
        }
    }

    private List<Staff> getStaffWithSalaryGreaterThan(double minSalary) {
        if (emf == null) return new ArrayList<>();
        EntityManager em = emf.createEntityManager();
        try  {
            CriteriaBuilder cb = em.getCriteriaBuilder();
            CriteriaQuery<Staff> cq = cb.createQuery(Staff.class);
            Root<Staff> staff = cq.from(Staff.class);
            // For Metamodel: cq.where(cb.greaterThan(staff.get(Staff_.salary), minSalary));
            cq.where(cb.greaterThan(staff.get("salary"), minSalary));
            return em.createQuery(cq).getResultList();
        } catch (Exception e) {
            Logger.getLogger(QueriesScreenController.class.getName()).log(Level.SEVERE, "Error fetching staff with high salary", e);
            return new ArrayList<>();
        }
    }
    
    
    private void setupConductColumnsManually() {
        QueryDisc.getColumns().clear(); // Clear any existing columns

        TableColumn<Object, String> equipIdCol = new TableColumn<>("Equip_ID");
        equipIdCol.setCellValueFactory(cellData -> {
            Conduct cond = (Conduct) cellData.getValue();
            // Assuming Staff has getId() that returns Long or Integer
            return new SimpleStringProperty(cond.getEquipID()!= null ? cond.getEquipID().toString() : "N/A");
        });

        TableColumn<Object, String> researchIdCol = new TableColumn<>("Research_ID");
        researchIdCol.setCellValueFactory(cellData -> {
            Research res = (Research) cellData.getValue();
            return new SimpleStringProperty(res.getResearchID().toString());
        });

        TableColumn<Object, String> staffIdCol = new TableColumn<>("");
        staffIdCol.setCellValueFactory(cellData -> {
            Staff staff = (Staff) cellData.getValue();
            String s = String.valueOf(staff.getCin());
            return new SimpleStringProperty(s);
        });

        QueryDisc.getColumns().addAll(equipIdCol, researchIdCol, staffIdCol);
    }
    
//    private void displayConductData(List<Conduct> conductList) {
//    QueryDisc.getColumns().clear(); // Clear previous columns
//
//    // Column for equip_ID
//    TableColumn<Object, String> equipIDCol = new TableColumn<>("Equip ID");
//    equipIDCol.setCellValueFactory(cellData -> {
//        Conduct conduct = (Conduct) cellData.getValue();
//        // Handle null case
//        return new SimpleStringProperty(conduct.getEquipID() != null ? conduct.getEquipID().toString() : "N/A");  // Use "N/A" or an empty string
//    });
//
//    // Column for staff_CIN
//    TableColumn<Object, String> staffCINCol = new TableColumn<>("Staff CIN");
//    staffCINCol.setCellValueFactory(cellData -> {
//        Conduct conduct = (Conduct) cellData.getValue();
//        return new SimpleStringProperty(conduct.getStaff() != null ? conduct.getStaff().toString() : "N/A");  // Handle null here as well
//    });
//
//    // Column for research_ID
//    TableColumn<Object, String> researchIDCol = new TableColumn<>("Research ID");
//    researchIDCol.setCellValueFactory(cellData -> {
//        Conduct conduct = (Conduct) cellData.getValue();
//        return new SimpleStringProperty(conduct.getResearch() != null ? conduct.getResearch().toString() : "N/A");  // Handle null here as well
//    });
//
//    // Add all columns to the QueryDisc table
//    QueryDisc.getColumns().addAll(equipIDCol, staffCINCol, researchIDCol);
//
//    // Set the items in the table
//    QueryDisc.setItems(FXCollections.observableArrayList(conductList));
//}


    
    private void getRelationsInConduct() {
    if (emf == null) return;
    
    EntityManager em = emf.createEntityManager();
    
    try {
        // Execute the query and get the results
        List<Conduct> conductList = em.createNamedQuery("Conduct.findAll", Conduct.class).getResultList();
        
        // Add the results to the QueryDisc table
//        QueryDisc.getItems().addAll(conductList);
        QueryDisc.getItems().addAll("sorry but this method working in terminal but not in UI, Ask Doctor");
//        displayConductData(conductList);
        System.out.println(conductList);
    } catch (Exception e) {
        Logger.getLogger(QueriesScreenController.class.getName()).log(Level.SEVERE, "Error fetching Conduct entities", e);
        setupConductColumnsManually();
    } finally {
        // Close the EntityManager to avoid resource leaks
        em.close();
    }
}

    private List<Staff> getProgrammers() {
        if (emf == null) return new ArrayList<>();
        EntityManager em = emf.createEntityManager();
        try {
            CriteriaBuilder cb = em.getCriteriaBuilder();
            CriteriaQuery<Staff> cq = cb.createQuery(Staff.class);
            Root<Staff> staff = cq.from(Staff.class);
            // For Metamodel: cq.where(cb.equal(staff.get(Staff_.jobType), "Programmer"));
            cq.where(cb.equal(staff.get("jobType"), "Programmer"));
            return em.createQuery(cq).getResultList();
        } catch (Exception e) {
            Logger.getLogger(QueriesScreenController.class.getName()).log(Level.SEVERE, "Error fetching programmers", e);
            return new ArrayList<>();
        }
    }

    private List<Staff> getStaffWithNameStartingWith(String prefix) {
        if (emf == null) return new ArrayList<>();
        EntityManager em = emf.createEntityManager();
        List<Staff> newList = new ArrayList<>();
        try {
            for(Staff s :getAllStaff()){
                if(s.getFname().startsWith(prefix)){
                    newList.add(s);
                }
            }
            return newList;
        } catch (Exception e) {
            Logger.getLogger(QueriesScreenController.class.getName()).log(Level.SEVERE, "Error fetching staff by name prefix", e);
            return new ArrayList<>();
        }
    }
    
    
    private void getAllMaleStaffThatConductsResearch() {    
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("SpaceManagerPU");
        EntityManager em = emf.createEntityManager();
        QueryDisc.getColumns().clear();

        for (Field field : Staff.class.getDeclaredFields()) {
            if (Modifier.isStatic(field.getModifiers()) || field.getName().equals("serialVersionUID")) continue;

            field.setAccessible(true);
            Class<?> fieldType = field.getType();

            // Create column with correct type
            TableColumn<Object, ?> column = createTypedColumn(field.getName(), field, fieldType);
            if (column != null) {
                QueryDisc.getColumns().add(column);
            }
        }
        
        List<Conduct> allConducts = em.createQuery("FROM " + Conduct.class.getSimpleName(), Conduct.class).getResultList();
        List<Staff> results = new ArrayList<>();
        for(Conduct c : allConducts){
               if(c.getStaff().getGender().equals("M".charAt(0))) results.add(c.getStaff());
        }
        QueryDisc.getItems().setAll(results);
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



    /**
     * Optional: Call this method when the application is shutting down to release JPA resources.
     * This should ideally be called from your main Application's stop() method.
     */
    public static void shutdown() {
        if (emf != null && emf.isOpen()) {
            emf.close();
            emf = null; // Allow it to be re-initialized if the app part is somehow restarted
            Logger.getLogger(QueriesScreenController.class.getName()).log(Level.INFO, "EntityManagerFactory closed.");
        }
    }
}