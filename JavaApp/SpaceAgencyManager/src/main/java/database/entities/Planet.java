package database.entities;

import java.io.Serializable;
import java.util.Set;

/**
 *
 * @author mohab
 */
@javax.persistence.Entity
@javax.persistence.Table(name = "planet")
@javax.persistence.NamedQueries({
    @javax.persistence.NamedQuery(name = "Planet.findAll", query = "SELECT p FROM Planet p"),
    @javax.persistence.NamedQuery(name = "Planet.findByPlanetID", query = "SELECT p FROM Planet p WHERE p.planetID = :planetID"),
    @javax.persistence.NamedQuery(name = "Planet.findByName", query = "SELECT p FROM Planet p WHERE p.name = :name"),
    @javax.persistence.NamedQuery(name = "Planet.findByType", query = "SELECT p FROM Planet p WHERE p.type = :type"),
    @javax.persistence.NamedQuery(name = "Planet.findByDiameter", query = "SELECT p FROM Planet p WHERE p.diameter = :diameter"),
    @javax.persistence.NamedQuery(name = "Planet.findByMass", query = "SELECT p FROM Planet p WHERE p.mass = :mass"),
    @javax.persistence.NamedQuery(name = "Planet.findByOrbitRadius", query = "SELECT p FROM Planet p WHERE p.orbitRadius = :orbitRadius"),
    @javax.persistence.NamedQuery(name = "Planet.findByHasRings", query = "SELECT p FROM Planet p WHERE p.hasRings = :hasRings"),
    @javax.persistence.NamedQuery(name = "Planet.findByOrbitPeriod", query = "SELECT p FROM Planet p WHERE p.orbitPeriod = :orbitPeriod"),
    @javax.persistence.NamedQuery(name = "Planet.findByNumberOfMoons", query = "SELECT p FROM Planet p WHERE p.numberOfMoons = :numberOfMoons"),
    @javax.persistence.NamedQuery(name = "Planet.findByRotationPeriod", query = "SELECT p FROM Planet p WHERE p.rotationPeriod = :rotationPeriod")})
public class Planet implements Serializable {

    private static final long serialVersionUID = 1L;
    @javax.persistence.Id
    @javax.persistence.Basic(optional = false)
    @javax.persistence.Column(name = "planet_ID", nullable = false, length = 15)
    private String planetID;
    @javax.persistence.Column(name = "name", length = 20)
    private String name;
    @javax.persistence.Column(name = "type", length = 20)
    private String type;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @javax.persistence.Column(name = "diameter", precision = 12, scale = 0)
    private Float diameter;
    @javax.persistence.Column(name = "mass", precision = 12, scale = 0)
    private Float mass;
    @javax.persistence.Column(name = "orbit_radius", precision = 12, scale = 0)
    private Float orbitRadius;
    @javax.persistence.Column(name = "has_rings")
    private Boolean hasRings;
    @javax.persistence.Column(name = "orbit_period", precision = 12, scale = 0)
    private Float orbitPeriod;
    @javax.persistence.Column(name = "number_of_moons")
    private Integer numberOfMoons;
    @javax.persistence.Column(name = "rotation_period", precision = 12, scale = 0)
    private Float rotationPeriod;
    @javax.persistence.OneToMany(mappedBy = "planetID")
    private Set<Mission> missionSet;

    public Planet() {
    }

    public Planet(String planetID) {
        this.planetID = planetID;
    }

    public String getPlanetID() {
        return planetID;
    }

    public void setPlanetID(String planetID) {
        this.planetID = planetID;
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

    public Float getDiameter() {
        return diameter;
    }

    public void setDiameter(Float diameter) {
        this.diameter = diameter;
    }

    public Float getMass() {
        return mass;
    }

    public void setMass(Float mass) {
        this.mass = mass;
    }

    public Float getOrbitRadius() {
        return orbitRadius;
    }

    public void setOrbitRadius(Float orbitRadius) {
        this.orbitRadius = orbitRadius;
    }

    public Boolean getHasRings() {
        return hasRings;
    }

    public void setHasRings(Boolean hasRings) {
        this.hasRings = hasRings;
    }

    public Float getOrbitPeriod() {
        return orbitPeriod;
    }

    public void setOrbitPeriod(Float orbitPeriod) {
        this.orbitPeriod = orbitPeriod;
    }

    public Integer getNumberOfMoons() {
        return numberOfMoons;
    }

    public void setNumberOfMoons(Integer numberOfMoons) {
        this.numberOfMoons = numberOfMoons;
    }

    public Float getRotationPeriod() {
        return rotationPeriod;
    }

    public void setRotationPeriod(Float rotationPeriod) {
        this.rotationPeriod = rotationPeriod;
    }

    public Set<Mission> getMissionSet() {
        return missionSet;
    }

    public void setMissionSet(Set<Mission> missionSet) {
        this.missionSet = missionSet;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (planetID != null ? planetID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Planet)) {
            return false;
        }
        Planet other = (Planet) object;
        if ((this.planetID == null && other.planetID != null) || (this.planetID != null && !this.planetID.equals(other.planetID))) {
            return false;
        }
        return true;
    }

    @Override
public String toString() {
    return "Planet{" +
            "planetID='" + planetID + '\'' +
            ", name='" + name + '\'' +
            ", type='" + type + '\'' +
            ", diameter=" + diameter +
            ", mass=" + mass +
            ", orbitRadius=" + orbitRadius +
            ", hasRings=" + hasRings +
            ", orbitPeriod=" + orbitPeriod +
            ", numberOfMoons=" + numberOfMoons +
            ", rotationPeriod=" + rotationPeriod +
            '}';
}

    public void setDistanceFromEarth(double parseDouble) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    
}
