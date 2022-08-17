package com.utar.model.sessionbean;


import com.utar.model.entity.Employee;

import javax.ejb.EJBException;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Stateless
public class StaffLogInSessionBean implements StaffLogInSessionBeanLocal {
    @PersistenceContext(unitName = "StaffUnit")
    EntityManager em;

    @Override
    public List getAllEmployees() throws EJBException {
        return em.createNamedQuery("Employee.findbyId").getResultList();
    }

    @Override
    public List<Employee> readEmployee(int currentPage, int recordsPerPage, String keyword, String direction) throws  EJBException {
        Query q = null;
        int start = 0;
        direction = " " + direction;
        if (keyword.isEmpty()) {
            q = em.createNativeQuery("SELECT * FROM classicmodels.employees order by id" + direction, Employee.class);
            start = currentPage * recordsPerPage - recordsPerPage;
        } else {
            q = em.createNativeQuery("SELECT * from classicmodels.employees WHERE concat(id,first_name,last_name,extension,email,officecode,jobtitle) LIKE ? order by id" + direction, Employee.class);
            start = currentPage * recordsPerPage - recordsPerPage;
            q.setParameter(1, keyword );
        }
        List<Employee> results = q.setFirstResult(start).setMaxResults(recordsPerPage).getResultList();
        return results;
    }

    @Override
    public int getNumberOfRows(String keyword) throws EJBException {
        Query q = null;
        if (keyword.isEmpty()) {
            q = em.createNativeQuery("SELECT COUNT(*) AS totalrow FROM classicmodels.employees");
        } else {
            q = em.createNativeQuery("SELECT COUNT(*) AS totalrow FROM classicmodels.employees WHERE concat(id,first_name,last_name,extension,email,officecode,jobtitle) LIKE ?");
            // setParameter( integer position, Object value );
            q.setParameter(1, "%" + keyword + "%");
        }
        BigInteger results = (BigInteger) q.getSingleResult();
        int i = results.intValue();
        return i;
    }

    @Override
    public Employee findEmployee(String id) throws EJBException {
        Query q = em.createNamedQuery("Employee.findbyId");
        q.setParameter("id", Short.valueOf(id));
        return (Employee) q.getSingleResult();
    }

    @Override
    public void updateEmployee(String[] s) throws EJBException {
        Employee e = findEmployee(s[2]);

        e.setFirstname(s[0]);
        e.setLastname(s[1]);
        e.setId(Short.parseShort(s[2]));
        e.setExtension(s[3]);
        e.setEmail(s[4]);
//        e.setOfficecode();
        e.setJobtitle(s[6]);
        e.setReportsto(s[7]);
        em.merge(e);
    }

    @Override
    public void deleteEmployee(String id) throws EJBException {
        Employee e = findEmployee(id);
        em.remove(e);
    }

    @Override
    public void addEmployee(String[] s) throws EJBException {
        Date dob = null;
        Date hd = null;
        try {
            dob = new SimpleDateFormat("yyyy-MM-dd").parse(s[4]);
            hd = new SimpleDateFormat("yyyy-MM-dd").parse(s[5]);
        } catch (Exception ex) {
        }
        Employee e = new Employee();
        java.sql.Date DOB = new java.sql.Date(dob.getTime());
        java.sql.Date HD = new java.sql.Date(hd.getTime());
        em.persist(e);
    }

    public List<Employee> findSubordinates(String id) throws EJBException{
        Query q = em.createNamedQuery("Employee.findSubordinate");
        q.setParameter("id", id);
        List<Employee> subordinateList = (List<Employee>) q.getResultList();
        return subordinateList;
    }
}
