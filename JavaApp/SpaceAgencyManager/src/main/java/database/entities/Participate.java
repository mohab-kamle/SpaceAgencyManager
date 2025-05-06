package database.entities;

import java.io.Serializable;

/**
 *
 * @author mohab
 */
@javax.persistence.Entity
@javax.persistence.Table(name = "participate")
@javax.persistence.NamedQueries({
    @javax.persistence.NamedQuery(name = "Participate.findAll", query = "SELECT p FROM Participate p"),
    @javax.persistence.NamedQuery(name = "Participate.findByPartnerOrgCode", query = "SELECT p FROM Participate p WHERE p.participatePK.partnerOrgCode = :partnerOrgCode"),
    @javax.persistence.NamedQuery(name = "Participate.findByResearchID", query = "SELECT p FROM Participate p WHERE p.participatePK.researchID = :researchID"),
    @javax.persistence.NamedQuery(name = "Participate.findByCategory", query = "SELECT p FROM Participate p WHERE p.category = :category")})
public class Participate implements Serializable {

    private static final long serialVersionUID = 1L;
    @javax.persistence.EmbeddedId
    protected ParticipatePK participatePK;
    @javax.persistence.Column(name = "category", length = 20)
    private String category;
    @javax.persistence.JoinColumn(name = "research_ID", referencedColumnName = "research_ID", nullable = false, insertable = false, updatable = false)
    @javax.persistence.ManyToOne(optional = false)
    private Research research;
    @javax.persistence.JoinColumn(name = "partner_org_code", referencedColumnName = "org_code", nullable = false, insertable = false, updatable = false)
    @javax.persistence.ManyToOne(optional = false)
    private Partner partner;

    public Participate() {
    }

    public Participate(ParticipatePK participatePK) {
        this.participatePK = participatePK;
    }

    public Participate(String partnerOrgCode, String researchID) {
        this.participatePK = new ParticipatePK(partnerOrgCode, researchID);
    }

    public ParticipatePK getParticipatePK() {
        return participatePK;
    }

    public void setParticipatePK(ParticipatePK participatePK) {
        this.participatePK = participatePK;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public Research getResearch() {
        return research;
    }

    public void setResearch(Research research) {
        this.research = research;
    }

    public Partner getPartner() {
        return partner;
    }

    public void setPartner(Partner partner) {
        this.partner = partner;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (participatePK != null ? participatePK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Participate)) {
            return false;
        }
        Participate other = (Participate) object;
        if ((this.participatePK == null && other.participatePK != null) || (this.participatePK != null && !this.participatePK.equals(other.participatePK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return String.format("Participate [Partner Org Code: %s, Research ID: %s, Category: %s, Partner: %s, Research: %s]",
                participatePK != null ? participatePK.getPartnerOrgCode() : "N/A",
                participatePK != null ? participatePK.getResearchID() : "N/A",
                category != null ? category : "N/A",
                partner != null ? partner.toString() : "N/A",
                research != null ? research.toString() : "N/A");
    }

}
