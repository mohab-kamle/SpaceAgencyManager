
package database.entities;

import java.io.Serializable;
import java.util.Set;

/**
 *
 * @author mohab
 */
@javax.persistence.Entity
@javax.persistence.Table(name = "partner")
@javax.persistence.NamedQueries({
    @javax.persistence.NamedQuery(name = "Partner.findAll", query = "SELECT p FROM Partner p"),
    @javax.persistence.NamedQuery(name = "Partner.findByOrgCode", query = "SELECT p FROM Partner p WHERE p.orgCode = :orgCode"),
    @javax.persistence.NamedQuery(name = "Partner.findByName", query = "SELECT p FROM Partner p WHERE p.name = :name"),
    @javax.persistence.NamedQuery(name = "Partner.findByAddress", query = "SELECT p FROM Partner p WHERE p.address = :address"),
    @javax.persistence.NamedQuery(name = "Partner.findByEmail", query = "SELECT p FROM Partner p WHERE p.email = :email"),
    @javax.persistence.NamedQuery(name = "Partner.findByPhoneNo", query = "SELECT p FROM Partner p WHERE p.phoneNo = :phoneNo")})
public class Partner implements Serializable {

    private static final long serialVersionUID = 1L;
    @javax.persistence.Id
    @javax.persistence.Basic(optional = false)
    @javax.persistence.Column(name = "org_code", nullable = false, length = 3)
    private String orgCode;
    @javax.persistence.Basic(optional = false)
    @javax.persistence.Column(name = "name", nullable = false, length = 20)
    private String name;
    @javax.persistence.Column(name = "address", length = 40)
    private String address;
    @javax.persistence.Basic(optional = false)
    @javax.persistence.Column(name = "email", nullable = false, length = 40)
    private String email;
    @javax.persistence.Column(name = "phone_no", length = 12)
    private String phoneNo;
    @javax.persistence.OneToMany(cascade = javax.persistence.CascadeType.ALL, mappedBy = "partner")
    private Set<Participate> participateSet;
    @javax.persistence.OneToMany(mappedBy = "partnerOrgCode")
    private Set<Equipment> equipmentSet;

    public Partner() {
    }

    public Partner(String orgCode) {
        this.orgCode = orgCode;
    }

    public Partner(String orgCode, String name, String email) {
        this.orgCode = orgCode;
        this.name = name;
        this.email = email;
    }

    public String getOrgCode() {
        return orgCode;
    }

    public void setOrgCode(String orgCode) {
        this.orgCode = orgCode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public Set<Participate> getParticipateSet() {
        return participateSet;
    }

    public void setParticipateSet(Set<Participate> participateSet) {
        this.participateSet = participateSet;
    }

    public Set<Equipment> getEquipmentSet() {
        return equipmentSet;
    }

    public void setEquipmentSet(Set<Equipment> equipmentSet) {
        this.equipmentSet = equipmentSet;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (orgCode != null ? orgCode.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Partner)) {
            return false;
        }
        Partner other = (Partner) object;
        if ((this.orgCode == null && other.orgCode != null) || (this.orgCode != null && !this.orgCode.equals(other.orgCode))) {
            return false;
        }
        return true;
    }

    @Override
public String toString() {
    return "Partner{" +
            "orgCode='" + orgCode + '\'' +
            ", name='" + name + '\'' +
            ", address='" + address + '\'' +
            ", email='" + email + '\'' +
            ", phoneNo='" + phoneNo + '\'' +
            '}';
}

    
}
