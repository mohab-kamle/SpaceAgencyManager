/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database.entities;

import java.io.Serializable;
import java.util.Set;

/**
 *
 * @author mohab
 */
@javax.persistence.Entity
@javax.persistence.Table(name = "equipment")
@javax.persistence.NamedQueries({
    @javax.persistence.NamedQuery(name = "Equipment.findAll", query = "SELECT e FROM Equipment e"),
    @javax.persistence.NamedQuery(name = "Equipment.findByEquipID", query = "SELECT e FROM Equipment e WHERE e.equipID = :equipID"),
    @javax.persistence.NamedQuery(name = "Equipment.findByName", query = "SELECT e FROM Equipment e WHERE e.name = :name"),
    @javax.persistence.NamedQuery(name = "Equipment.findByStatus", query = "SELECT e FROM Equipment e WHERE e.status = :status"),
    @javax.persistence.NamedQuery(name = "Equipment.findByType", query = "SELECT e FROM Equipment e WHERE e.type = :type"),
    @javax.persistence.NamedQuery(name = "Equipment.findByOriginCountry", query = "SELECT e FROM Equipment e WHERE e.originCountry = :originCountry"),
    @javax.persistence.NamedQuery(name = "Equipment.findByKind", query = "SELECT e FROM Equipment e WHERE e.kind = :kind")})
public class Equipment implements Serializable {

    private static final long serialVersionUID = 1L;
    @javax.persistence.Id
    @javax.persistence.Basic(optional = false)
    @javax.persistence.Column(name = "equip_ID", nullable = false, length = 7)
    private String equipID;
    @javax.persistence.Column(name = "name", length = 30)
    private String name;
    @javax.persistence.Column(name = "status", length = 30)
    private String status;
    @javax.persistence.Column(name = "type", length = 15)
    private String type;
    @javax.persistence.Column(name = "origin_country", length = 20)
    private String originCountry;
    @javax.persistence.Column(name = "kind", length = 40)
    private String kind;
    @javax.persistence.OneToMany(mappedBy = "equipID")
    private Set<Conduct> conductSet;
    @javax.persistence.JoinColumn(name = "partner_org_code", referencedColumnName = "org_code")
    @javax.persistence.ManyToOne
    private Partner partnerOrgCode;

    public Equipment() {
    }

    public Equipment(String equipID) {
        this.equipID = equipID;
    }

    public String getEquipID() {
        return equipID;
    }

    public void setEquipID(String equipID) {
        this.equipID = equipID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getOriginCountry() {
        return originCountry;
    }

    public void setOriginCountry(String originCountry) {
        this.originCountry = originCountry;
    }

    public String getKind() {
        return kind;
    }

    public void setKind(String kind) {
        this.kind = kind;
    }

    public Set<Conduct> getConductSet() {
        return conductSet;
    }

    public void setConductSet(Set<Conduct> conductSet) {
        this.conductSet = conductSet;
    }

    public Partner getPartnerOrgCode() {
        return partnerOrgCode;
    }

    public void setPartnerOrgCode(Partner partnerOrgCode) {
        this.partnerOrgCode = partnerOrgCode;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (equipID != null ? equipID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Equipment)) {
            return false;
        }
        Equipment other = (Equipment) object;
        if ((this.equipID == null && other.equipID != null) || (this.equipID != null && !this.equipID.equals(other.equipID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "database.entities.Equipment[ equipID=" + equipID + " ]";
    }
    
}
