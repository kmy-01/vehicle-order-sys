package com.utar.model.entity;

import javax.persistence.*;

@Entity
@Table(name = "employees", schema = "classicmodels")
//@NamedQuery(name = "Employee.foundEmpCount", query = "SELECT COUNT(e) FROM Employee e WHERE e.id = :id")
@NamedQuery(name = "Employee.findbyId", query = "SELECT e FROM Employee e WHERE e.id = :id")
@NamedQuery(name = "Employee.findSubordinate", query = "SELECT e FROM Employee e WHERE e.reportsto LIKE :id")
public class Employee {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "employeenumber", nullable = false)
    private Short id;

    @Column(name = "lastname", nullable = false, length = 9)
    private String lastname;

    @Column(name = "firstname", nullable = false, length = 8)
    private String firstname;

    @Column(name = "extension", nullable = false, length = 5)
    private String extension;

    @Column(name = "email", nullable = false, length = 31)
    private String email;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "officecode", nullable = false, insertable=false, updatable = false)
    private Office officecode;

    @Column(name = "reportsto", length = 4)
    private String reportsto;

    @Column(name = "jobtitle", nullable = false, length = 20)
    private String jobtitle;

    public Short getId() {
        return id;
    }

    public void setId(Short id) {
        this.id = id;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getExtension() {
        return extension;
    }

    public void setExtension(String extension) {
        this.extension = extension;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Office getOfficecode() {
        return officecode;
    }

    public void setOfficecode(Office officecode) {
        this.officecode = officecode;
    }

    public String getReportsto() {
        return reportsto;
    }

    public void setReportsto(String reportsto) {
        this.reportsto = reportsto;
    }

    public String getJobtitle() {
        return jobtitle;
    }

    public void setJobtitle(String jobtitle) {
        this.jobtitle = jobtitle;
    }

}