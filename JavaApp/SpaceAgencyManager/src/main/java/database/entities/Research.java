package database.entities;

import java.io.Serializable;
import java.util.Set;

/**
 *
 * @author mohab
 */
@javax.persistence.Entity
@javax.persistence.Table(name = "research")
@javax.persistence.NamedQueries({
    @javax.persistence.NamedQuery(name = "Research.findAll", query = "SELECT r FROM Research r"),
    @javax.persistence.NamedQuery(name = "Research.findByResearchID", query = "SELECT r FROM Research r WHERE r.researchID = :researchID"),
    @javax.persistence.NamedQuery(name = "Research.findByName", query = "SELECT r FROM Research r WHERE r.name = :name"),
    @javax.persistence.NamedQuery(name = "Research.findByType", query = "SELECT r FROM Research r WHERE r.type = :type"),
    @javax.persistence.NamedQuery(name = "Research.findByFindings", query = "SELECT r FROM Research r WHERE r.findings = :findings"),
    @javax.persistence.NamedQuery(name = "Research.findByPublicationsNo", query = "SELECT r FROM Research r WHERE r.publicationsNo = :publicationsNo")})
public class Research implements Serializable {

    private static final long serialVersionUID = 1L;
    @javax.persistence.Id
    @javax.persistence.Basic(optional = false)
    @javax.persistence.Column(name = "research_ID", nullable = false, length = 9)
    private String researchID;
    @javax.persistence.Basic(optional = false)
    @javax.persistence.Column(name = "name", nullable = false, length = 50)
    private String name;
    @javax.persistence.Basic(optional = false)
    @javax.persistence.Column(name = "type", nullable = false, length = 25)
    private String type;
    @javax.persistence.Column(name = "findings", length = 55)
    private String findings;
    @javax.persistence.Column(name = "publications_no")
    private Integer publicationsNo;
    @javax.persistence.ManyToMany(mappedBy = "researchSet")
    private Set<Mission> missionSet;
    @javax.persistence.OneToMany(cascade = javax.persistence.CascadeType.ALL, mappedBy = "research")
    private Set<Participate> participateSet;
    @javax.persistence.OneToMany(cascade = javax.persistence.CascadeType.ALL, mappedBy = "research")
    private Set<Conduct> conductSet;

    public Research() {
    }

    public Research(String researchID) {
        this.researchID = researchID;
    }

    public Research(String researchID, String name, String type) {
        this.researchID = researchID;
        this.name = name;
        this.type = type;
    }

    public String getResearchID() {
        return researchID;
    }

    public void setResearchID(String researchID) {
        this.researchID = researchID;
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

    public String getFindings() {
        return findings;
    }

    public void setFindings(String findings) {
        this.findings = findings;
    }

    public Integer getPublicationsNo() {
        return publicationsNo;
    }

    public void setPublicationsNo(Integer publicationsNo) {
        this.publicationsNo = publicationsNo;
    }

    public Set<Mission> getMissionSet() {
        return missionSet;
    }

    public void setMissionSet(Set<Mission> missionSet) {
        this.missionSet = missionSet;
    }

    public Set<Participate> getParticipateSet() {
        return participateSet;
    }

    public void setParticipateSet(Set<Participate> participateSet) {
        this.participateSet = participateSet;
    }

    public Set<Conduct> getConductSet() {
        return conductSet;
    }

    public void setConductSet(Set<Conduct> conductSet) {
        this.conductSet = conductSet;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (researchID != null ? researchID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Research)) {
            return false;
        }
        Research other = (Research) object;
        if ((this.researchID == null && other.researchID != null) || (this.researchID != null && !this.researchID.equals(other.researchID))) {
            return false;
        }
        return true;
    }

    @Override
public String toString() {
    return "Research{" +
            "researchID='" + researchID + '\'' +
            ", name='" + name + '\'' +
            ", type='" + type + '\'' +
            ", findings='" + findings + '\'' +
            ", publicationsNo=" + publicationsNo +
            ", numberOfMissions=" + (missionSet != null ? missionSet.size() : 0) +
            ", numberOfParticipates=" + (participateSet != null ? participateSet.size() : 0) +
            ", numberOfConducts=" + (conductSet != null ? conductSet.size() : 0) +
            '}';
}

    
}
