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
    public List<Employee> readEmployee(int currentPage, int recordsPerPage, String keyword) throws  EJBException {
        Query q = null;
        int start = 0;

        if (keyword.isEmpty()) {
            q = em.createNativeQuery("SELECT * FROM employees.employee order by id", Employee.class);
            start = currentPage * recordsPerPage - recordsPerPage;
        } else {
            q = em.createNativeQuery("SELECT * from employees.employee WHERE concat(id,first_name,last_name,gender) LIKE ? order by id",Employee.class);
            start = currentPage * recordsPerPage - recordsPerPage;
            q.setParameter(1, keyword );
        }
//use of setMaxResults --> to replace LIMIT & setFirstResult --> to replace OFFSET
        List<Employee> results = q.setFirstResult(start).setMaxResults(recordsPerPage).getResultList();
        return results;
    }

    @Override
    public int getNumberOfRows(String username) throws EJBException {
        Query q = null;
        if (username.isEmpty()) {
            q = em.createNativeQuery("SELECT COUNT(*) AS totalrow FROM employees.employee");
        } else {
            q = em.createNativeQuery("SELECT COUNT(*) AS totalrow from employees.employee WHERE concat(id,first_name,last_name,gender) LIKE ?");
            // setParameter( integer position, Object value );
            q.setParameter(1, "%" + username + "%");
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
        Employee e = findEmployee(s[0]);

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
