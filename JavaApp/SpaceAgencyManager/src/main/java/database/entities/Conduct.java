package database.entities;

import java.io.Serializable;
/**
 *
 * @author mohab
 */
@javax.persistence.Entity
@javax.persistence.Table(name = "conduct")
@javax.persistence.NamedQueries({
    @javax.persistence.NamedQuery(name = "Conduct.findAll", query = "SELECT c FROM Conduct c"),
    @javax.persistence.NamedQuery(name = "Conduct.findByResearchID", query = "SELECT c FROM Conduct c WHERE c.conductPK.researchID = :researchID"),
    @javax.persistence.NamedQuery(name = "Conduct.findByStaffCIN", query = "SELECT c FROM Conduct c WHERE c.conductPK.staffCIN = :staffCIN"),
//    @javax.persistence.NamedQuery(name = "Conduct.findAllJoin",query = "SELECT c FROM Conduct cLEFT JOIN FETCH c.research rLEFT JOIN FETCH r.missionSet LEFT JOIN FETCH c.staff s LEFT JOIN FETCH c.equipment e"),
})
public class Conduct implements Serializable {

    private static final long serialVersionUID = 1L;
    @javax.persistence.EmbeddedId
    protected ConductPK conductPK;
    @javax.persistence.JoinColumn(name = "equip_ID", referencedColumnName = "equip_ID")
    @javax.persistence.ManyToOne
    private Equipment equipID;
    @javax.persistence.JoinColumn(name = "research_ID", referencedColumnName = "research_ID", nullable = false, insertable = false, updatable = false)
    @javax.persistence.ManyToOne(optional = false)
    private Research research;
    @javax.persistence.JoinColumn(name = "staff_CIN", referencedColumnName = "CIN", nullable = false, insertable = false, updatable = false)
    @javax.persistence.ManyToOne(optional = false)
    private Staff staff;

    public Conduct() {
    }

    public Conduct(ConductPK conductPK) {
        this.conductPK = conductPK;
    }

    public Conduct(String researchID, String staffCIN) {
        this.conductPK = new ConductPK(researchID, staffCIN);
    }

    public ConductPK getConductPK() {
        return conductPK;
    }

    public void setConductPK(ConductPK conductPK) {
        this.conductPK = conductPK;
    }

    public Equipment getEquipID() {
        return equipID;
    }

    public void setEquipID(Equipment equipID) {
        this.equipID = equipID;
    }

    public Research getResearch() {
        return research;
    }

    public void setResearch(Research research) {
        this.research = research;
    }

    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (conductPK != null ? conductPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Conduct)) {
            return false;
        }
        Conduct other = (Conduct) object;
        if ((this.conductPK == null && other.conductPK != null) || (this.conductPK != null && !this.conductPK.equals(other.conductPK))) {
            return false;
        }
        return true;
    }

    @Override
public String toString() {
    // Get the required details from related entities (Research, Staff, Equipment)
    String researchTitle = (research != null) ? research.getName() : "No Research Assigned";
    String staffName = (staff != null) ? staff.getCin() : "No Staff Assigned";
    String equipId = (equipID != null) ? equipID.getEquipID() : "No Equipment Assigned";
    
    // Return a more detailed and readable string representation
    return String.format("Conduct [Research: %s, Staff: %s, Equipment: %s, ResearchID: %s, StaffCIN: %s]",
                         researchTitle, staffName, equipId, conductPK.getResearchID(), conductPK.getStaffCIN());
}


}
