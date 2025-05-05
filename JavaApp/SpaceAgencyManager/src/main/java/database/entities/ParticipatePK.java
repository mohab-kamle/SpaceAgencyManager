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
public class ParticipatePK implements Serializable {

    @javax.persistence.Basic(optional = false)
    @javax.persistence.Column(name = "partner_org_code", nullable = false, length = 3)
    private String partnerOrgCode;
    @javax.persistence.Basic(optional = false)
    @javax.persistence.Column(name = "research_ID", nullable = false, length = 9)
    private String researchID;

    public ParticipatePK() {
    }

    public ParticipatePK(String partnerOrgCode, String researchID) {
        this.partnerOrgCode = partnerOrgCode;
        this.researchID = researchID;
    }

    public String getPartnerOrgCode() {
        return partnerOrgCode;
    }

    public void setPartnerOrgCode(String partnerOrgCode) {
        this.partnerOrgCode = partnerOrgCode;
    }

    public String getResearchID() {
        return researchID;
    }

    public void setResearchID(String researchID) {
        this.researchID = researchID;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (partnerOrgCode != null ? partnerOrgCode.hashCode() : 0);
        hash += (researchID != null ? researchID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ParticipatePK)) {
            return false;
        }
        ParticipatePK other = (ParticipatePK) object;
        if ((this.partnerOrgCode == null && other.partnerOrgCode != null) || (this.partnerOrgCode != null && !this.partnerOrgCode.equals(other.partnerOrgCode))) {
            return false;
        }
        if ((this.researchID == null && other.researchID != null) || (this.researchID != null && !this.researchID.equals(other.researchID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "database.entities.ParticipatePK[ partnerOrgCode=" + partnerOrgCode + ", researchID=" + researchID + " ]";
    }
    
}
