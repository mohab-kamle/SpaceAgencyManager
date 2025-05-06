package database.entities;

import java.io.Serializable;
import java.util.Set;

/**
 *
 * @author mohab
 */
@javax.persistence.Entity
@javax.persistence.Table(name = "mission")
@javax.persistence.NamedQueries({
    @javax.persistence.NamedQuery(name = "Mission.findAll", query = "SELECT m FROM Mission m"),
    @javax.persistence.NamedQuery(name = "Mission.findByMissionID", query = "SELECT m FROM Mission m WHERE m.missionID = :missionID"),
    @javax.persistence.NamedQuery(name = "Mission.findByName", query = "SELECT m FROM Mission m WHERE m.name = :name"),
    @javax.persistence.NamedQuery(name = "Mission.findByType", query = "SELECT m FROM Mission m WHERE m.type = :type"),
    @javax.persistence.NamedQuery(name = "Mission.findByStatus", query = "SELECT m FROM Mission m WHERE m.status = :status"),
    @javax.persistence.NamedQuery(name = "Mission.findByObjective", query = "SELECT m FROM Mission m WHERE m.objective = :objective")})
public class Mission implements Serializable {

    private static final long serialVersionUID = 1L;
    @javax.persistence.Id
    @javax.persistence.Basic(optional = false)
    @javax.persistence.Column(name = "mission_ID", nullable = false, length = 7)
    private String missionID;
    @javax.persistence.Column(name = "name", length = 20)
    private String name;
    @javax.persistence.Column(name = "type", length = 20)
    private String type;
    @javax.persistence.Column(name = "status", length = 15)
    private String status;
    @javax.persistence.Column(name = "objective", length = 50)
    private String objective;
    @javax.persistence.JoinTable(name = "assigned_to", joinColumns = {
        @javax.persistence.JoinColumn(name = "mission_ID", referencedColumnName = "mission_ID", nullable = false)}, inverseJoinColumns = {
        @javax.persistence.JoinColumn(name = "research_ID", referencedColumnName = "research_ID", nullable = false)})
    @javax.persistence.ManyToMany
    private Set<Research> researchSet;
    @javax.persistence.JoinColumn(name = "planet_ID", referencedColumnName = "planet_ID")
    @javax.persistence.ManyToOne
    private Planet planetID;
    @javax.persistence.OneToOne(cascade = javax.persistence.CascadeType.ALL, mappedBy = "mission")
    private TakesOff takesOff;

    public Mission() {
    }

    public Mission(String missionID) {
        this.missionID = missionID;
    }

    public String getMissionID() {
        return missionID;
    }

    public void setMissionID(String missionID) {
        this.missionID = missionID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getObjective() {
        return objective;
    }

    public void setObjective(String objective) {
        this.objective = objective;
    }

    public Set<Research> getResearchSet() {
        return researchSet;
    }

    public void setResearchSet(Set<Research> researchSet) {
        this.researchSet = researchSet;
    }

    public Planet getPlanetID() {
        return planetID;
    }

    public void setPlanetID(Planet planetID) {
        this.planetID = planetID;
    }

    public TakesOff getTakesOff() {
        return takesOff;
    }

    public void setTakesOff(TakesOff takesOff) {
        this.takesOff = takesOff;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (missionID != null ? missionID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Mission)) {
            return false;
        }
        Mission other = (Mission) object;
        if ((this.missionID == null && other.missionID != null) || (this.missionID != null && !this.missionID.equals(other.missionID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return String.format("Mission [ID: %s, Name: %s, Type: %s, Status: %s, Objective: %s, Planet: %s]",
                missionID, name, type, status, objective, planetID != null ? planetID.getPlanetID() : "N/A");
    }

}
