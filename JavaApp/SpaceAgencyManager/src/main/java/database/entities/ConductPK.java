/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database.entities;

import java.io.Serializable;

/**
 *
 * @author mohab
 */
@javax.persistence.Embeddable
public class ConductPK implements Serializable {

    @javax.persistence.Basic(optional = false)
    @javax.persistence.Column(name = "research_ID", nullable = false, length = 9)
    private String researchID;
    @javax.persistence.Basic(optional = false)
    @javax.persistence.Column(name = "staff_CIN", nullable = false, length = 10)
    private String staffCIN;

    public ConductPK() {
    }

    public ConductPK(String researchID, String staffCIN) {
        this.researchID = researchID;
        this.staffCIN = staffCIN;
    }

    public String getResearchID() {
        return researchID;
    }

    public void setResearchID(String researchID) {
        this.researchID = researchID;
    }

    public String getStaffCIN() {
        return staffCIN;
    }

    public void setStaffCIN(String staffCIN) {
        this.staffCIN = staffCIN;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (researchID != null ? researchID.hashCode() : 0);
        hash += (staffCIN != null ? staffCIN.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ConductPK)) {
            return false;
        }
        ConductPK other = (ConductPK) object;
        if ((this.researchID == null && other.researchID != null) || (this.researchID != null && !this.researchID.equals(other.researchID))) {
            return false;
        }
        if ((this.staffCIN == null && other.staffCIN != null) || (this.staffCIN != null && !this.staffCIN.equals(other.staffCIN))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return String.format("ConductPK [Research ID: %s, Staff CIN: %s]", researchID, staffCIN);
    }

}
