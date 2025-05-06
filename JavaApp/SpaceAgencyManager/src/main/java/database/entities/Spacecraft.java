
package database.entities;

import java.io.Serializable;
import java.util.Set;

/**
 *
 * @author mohab
 */
@javax.persistence.Entity
@javax.persistence.Table(name = "spacecraft")
@javax.persistence.NamedQueries({
    @javax.persistence.NamedQuery(name = "Spacecraft.findAll", query = "SELECT s FROM Spacecraft s"),
    @javax.persistence.NamedQuery(name = "Spacecraft.findBySpacecraftID", query = "SELECT s FROM Spacecraft s WHERE s.spacecraftID = :spacecraftID"),
    @javax.persistence.NamedQuery(name = "Spacecraft.findByName", query = "SELECT s FROM Spacecraft s WHERE s.name = :name"),
    @javax.persistence.NamedQuery(name = "Spacecraft.findByType", query = "SELECT s FROM Spacecraft s WHERE s.type = :type"),
    @javax.persistence.NamedQuery(name = "Spacecraft.findByLaunchPad", query = "SELECT s FROM Spacecraft s WHERE s.launchPad = :launchPad"),
    @javax.persistence.NamedQuery(name = "Spacecraft.findBySize", query = "SELECT s FROM Spacecraft s WHERE s.size = :size"),
    @javax.persistence.NamedQuery(name = "Spacecraft.findByWeight", query = "SELECT s FROM Spacecraft s WHERE s.weight = :weight"),
    @javax.persistence.NamedQuery(name = "Spacecraft.findByStatus", query = "SELECT s FROM Spacecraft s WHERE s.status = :status"),
    @javax.persistence.NamedQuery(name = "Spacecraft.findByPowerSource", query = "SELECT s FROM Spacecraft s WHERE s.powerSource = :powerSource"),
    @javax.persistence.NamedQuery(name = "Spacecraft.findByCPeople", query = "SELECT s FROM Spacecraft s WHERE s.cPeople = :cPeople"),
    @javax.persistence.NamedQuery(name = "Spacecraft.findByCLoad", query = "SELECT s FROM Spacecraft s WHERE s.cLoad = :cLoad")})
public class Spacecraft implements Serializable {

    private static final long serialVersionUID = 1L;
    @javax.persistence.Id
    @javax.persistence.Basic(optional = false)
    @javax.persistence.Column(name = "spacecraft_ID", nullable = false, length = 15)
    private String spacecraftID;
    @javax.persistence.Column(name = "name", length = 20)
    private String name;
    @javax.persistence.Column(name = "type", length = 20)
    private String type;
    @javax.persistence.Column(name = "launch_pad", length = 15)
    private String launchPad;
    @javax.persistence.Column(name = "size", length = 15)
    private String size;
    @javax.persistence.Column(name = "weight", length = 10)
    private String weight;
    @javax.persistence.Column(name = "status", length = 15)
    private String status;
    @javax.persistence.Column(name = "power_source", length = 20)
    private String powerSource;
    @javax.persistence.Column(name = "c_people")
    private Integer cPeople;
    @javax.persistence.Column(name = "c_load", length = 10)
    private String cLoad;
    @javax.persistence.OneToMany(cascade = javax.persistence.CascadeType.ALL, mappedBy = "spacecraftID")
    private Set<TakesOff> takesOffSet;

    public Spacecraft() {
    }

    public Spacecraft(String spacecraftID) {
        this.spacecraftID = spacecraftID;
    }

    public String getSpacecraftID() {
        return spacecraftID;
    }

    public void setSpacecraftID(String spacecraftID) {
        this.spacecraftID = spacecraftID;
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

    public String getLaunchPad() {
        return launchPad;
    }

    public void setLaunchPad(String launchPad) {
        this.launchPad = launchPad;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getWeight() {
        return weight;
    }

    public void setWeight(String weight) {
        this.weight = weight;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPowerSource() {
        return powerSource;
    }

    public void setPowerSource(String powerSource) {
        this.powerSource = powerSource;
    }

    public Integer getCPeople() {
        return cPeople;
    }

    public void setCPeople(Integer cPeople) {
        this.cPeople = cPeople;
    }

    public String getCLoad() {
        return cLoad;
    }

    public void setCLoad(String cLoad) {
        this.cLoad = cLoad;
    }

    public Set<TakesOff> getTakesOffSet() {
        return takesOffSet;
    }

    public void setTakesOffSet(Set<TakesOff> takesOffSet) {
        this.takesOffSet = takesOffSet;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (spacecraftID != null ? spacecraftID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Spacecraft)) {
            return false;
        }
        Spacecraft other = (Spacecraft) object;
        if ((this.spacecraftID == null && other.spacecraftID != null) || (this.spacecraftID != null && !this.spacecraftID.equals(other.spacecraftID))) {
            return false;
        }
        return true;
    }

    @Override
public String toString() {
    return "Spacecraft{" +
            "spacecraftID='" + spacecraftID + '\'' +
            ", name='" + name + '\'' +
            ", type='" + type + '\'' +
            ", launchPad='" + launchPad + '\'' +
            ", size='" + size + '\'' +
            ", weight='" + weight + '\'' +
            ", status='" + status + '\'' +
            ", powerSource='" + powerSource + '\'' +
            ", cPeople=" + cPeople +
            ", cLoad='" + cLoad + '\'' +
            ", numberOfTakesOff=" + (takesOffSet != null ? takesOffSet.size() : 0) +
            '}';
}

    
}
