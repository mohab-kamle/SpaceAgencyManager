/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database.entities;

import java.io.Serializable;
import java.util.Date;
/**
 *
 * @author mohab
 */
@javax.persistence.Entity
@javax.persistence.Table(name = "takes_off")
@javax.persistence.NamedQueries({
    @javax.persistence.NamedQuery(name = "TakesOff.findAll", query = "SELECT t FROM TakesOff t"),
    @javax.persistence.NamedQuery(name = "TakesOff.findByMissionID", query = "SELECT t FROM TakesOff t WHERE t.missionID = :missionID"),
    @javax.persistence.NamedQuery(name = "TakesOff.findByLaunchDate", query = "SELECT t FROM TakesOff t WHERE t.launchDate = :launchDate"),
    @javax.persistence.NamedQuery(name = "TakesOff.findByEndDate", query = "SELECT t FROM TakesOff t WHERE t.endDate = :endDate")})
public class TakesOff implements Serializable {

    private static final long serialVersionUID = 1L;
    @javax.persistence.Id
    @javax.persistence.Basic(optional = false)
    @javax.persistence.Column(name = "mission_ID", nullable = false, length = 7)
    private String missionID;
    @javax.persistence.Basic(optional = false)
    @javax.persistence.Column(name = "launch_date", nullable = false)
    @javax.persistence.Temporal(javax.persistence.TemporalType.DATE)
    private Date launchDate;
    @javax.persistence.Basic(optional = false)
    @javax.persistence.Column(name = "end_date", nullable = false)
    @javax.persistence.Temporal(javax.persistence.TemporalType.DATE)
    private Date endDate;
    @javax.persistence.JoinColumn(name = "mission_ID", referencedColumnName = "mission_ID", nullable = false, insertable = false, updatable = false)
    @javax.persistence.OneToOne(optional = false)
    private Mission mission;
    @javax.persistence.JoinColumn(name = "spacecraft_ID", referencedColumnName = "spacecraft_ID", nullable = false)
    @javax.persistence.ManyToOne(optional = false)
    private Spacecraft spacecraftID;

    public TakesOff() {
    }

    public TakesOff(String missionID) {
        this.missionID = missionID;
    }

    public TakesOff(String missionID, Date launchDate, Date endDate) {
        this.missionID = missionID;
        this.launchDate = launchDate;
        this.endDate = endDate;
    }

    public String getMissionID() {
        return missionID;
    }

    public void setMissionID(String missionID) {
        this.missionID = missionID;
    }

    public Date getLaunchDate() {
        return launchDate;
    }

    public void setLaunchDate(Date launchDate) {
        this.launchDate = launchDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Mission getMission() {
        return mission;
    }

    public void setMission(Mission mission) {
        this.mission = mission;
    }

    public Spacecraft getSpacecraftID() {
        return spacecraftID;
    }

    public void setSpacecraftID(Spacecraft spacecraftID) {
        this.spacecraftID = spacecraftID;
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
        if (!(object instanceof TakesOff)) {
            return false;
        }
        TakesOff other = (TakesOff) object;
        if ((this.missionID == null && other.missionID != null) || (this.missionID != null && !this.missionID.equals(other.missionID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "database.entities.TakesOff[ missionID=" + missionID + " ]";
    }
    
}
