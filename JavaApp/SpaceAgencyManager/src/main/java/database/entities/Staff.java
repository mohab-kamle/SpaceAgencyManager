package database.entities;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

/**
 *
 * @author mohab
 */
@javax.persistence.Entity
@javax.persistence.Table(name = "staff")
@javax.persistence.NamedQueries({
    @javax.persistence.NamedQuery(name = "Staff.findAll", query = "SELECT s FROM Staff s"),
    @javax.persistence.NamedQuery(name = "Staff.findByCin", query = "SELECT s FROM Staff s WHERE s.cin = :cin"),
    @javax.persistence.NamedQuery(name = "Staff.findByFname", query = "SELECT s FROM Staff s WHERE s.fname = :fname"),
    @javax.persistence.NamedQuery(name = "Staff.findByMname", query = "SELECT s FROM Staff s WHERE s.mname = :mname"),
    @javax.persistence.NamedQuery(name = "Staff.findByLname", query = "SELECT s FROM Staff s WHERE s.lname = :lname"),
    @javax.persistence.NamedQuery(name = "Staff.findByJobtype", query = "SELECT s FROM Staff s WHERE s.jobtype = :jobtype"),
    @javax.persistence.NamedQuery(name = "Staff.findBySalary", query = "SELECT s FROM Staff s WHERE s.salary = :salary"),
    @javax.persistence.NamedQuery(name = "Staff.findByBuildNo", query = "SELECT s FROM Staff s WHERE s.buildNo = :buildNo"),
    @javax.persistence.NamedQuery(name = "Staff.findByStreetName", query = "SELECT s FROM Staff s WHERE s.streetName = :streetName"),
    @javax.persistence.NamedQuery(name = "Staff.findByPostalCode", query = "SELECT s FROM Staff s WHERE s.postalCode = :postalCode"),
    @javax.persistence.NamedQuery(name = "Staff.findByCity", query = "SELECT s FROM Staff s WHERE s.city = :city"),
    @javax.persistence.NamedQuery(name = "Staff.findByState", query = "SELECT s FROM Staff s WHERE s.state = :state"),
    @javax.persistence.NamedQuery(name = "Staff.findByCountry", query = "SELECT s FROM Staff s WHERE s.country = :country"),
    @javax.persistence.NamedQuery(name = "Staff.findByGender", query = "SELECT s FROM Staff s WHERE s.gender = :gender"),
    @javax.persistence.NamedQuery(name = "Staff.findByBirthDate", query = "SELECT s FROM Staff s WHERE s.birthDate = :birthDate")})
public class Staff implements Serializable {

    private static final long serialVersionUID = 1L;
    @javax.persistence.Id
    @javax.persistence.Basic(optional = false)
    @javax.persistence.Column(name = "CIN", nullable = false, length = 10)
    private String cin;
    @javax.persistence.Basic(optional = false)
    @javax.persistence.Column(name = "fname", nullable = false, length = 15)
    private String fname;
    @javax.persistence.Column(name = "mname", length = 15)
    private String mname;
    @javax.persistence.Column(name = "lname", length = 15)
    private String lname;
    @javax.persistence.Basic(optional = false)
    @javax.persistence.Column(name = "Job_type", nullable = false, length = 50)
    private String jobtype;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @javax.persistence.Column(name = "salary", precision = 12, scale = 0)
    private Float salary;
    @javax.persistence.Column(name = "build_no", length = 5)
    private String buildNo;
    @javax.persistence.Column(name = "street_name", length = 20)
    private String streetName;
    @javax.persistence.Column(name = "postal_code", length = 10)
    private String postalCode;
    @javax.persistence.Column(name = "city", length = 20)
    private String city;
    @javax.persistence.Column(name = "state", length = 20)
    private String state;
    @javax.persistence.Column(name = "country", length = 20)
    private String country;
    @javax.persistence.Column(name = "gender")
    private Character gender;
    @javax.persistence.Column(name = "birth_date")
    @javax.persistence.Temporal(javax.persistence.TemporalType.DATE)
    private Date birthDate;
    @javax.persistence.OneToMany(cascade = javax.persistence.CascadeType.ALL, mappedBy = "staff")
    private Set<Conduct> conductSet;

    public Staff() {
    }

    public Staff(String cin) {
        this.cin = cin;
    }

    public Staff(String cin, String fname, String jobtype) {
        this.cin = cin;
        this.fname = fname;
        this.jobtype = jobtype;
    }

    public String getCin() {
        return cin;
    }

    public void setCin(String cin) {
        this.cin = cin;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getMname() {
        return mname;
    }

    public void setMname(String mname) {
        this.mname = mname;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public String getJobtype() {
        return jobtype;
    }

    public void setJobtype(String jobtype) {
        this.jobtype = jobtype;
    }

    public Float getSalary() {
        return salary;
    }

    public void setSalary(Float salary) {
        this.salary = salary;
    }

    public String getBuildNo() {
        return buildNo;
    }

    public void setBuildNo(String buildNo) {
        this.buildNo = buildNo;
    }

    public String getStreetName() {
        return streetName;
    }

    public void setStreetName(String streetName) {
        this.streetName = streetName;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public Character getGender() {
        return gender;
    }

    public void setGender(Character gender) {
        this.gender = gender;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
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
        hash += (cin != null ? cin.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Staff)) {
            return false;
        }
        Staff other = (Staff) object;
        if ((this.cin == null && other.cin != null) || (this.cin != null && !this.cin.equals(other.cin))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Staff[ cin = " + cin + ",name = "+fname+" "+mname+" "+lname +" ]";
    }
    
}
