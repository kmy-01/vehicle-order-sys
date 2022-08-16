package com.utar.model.sessionbean;


import com.utar.model.entity.Employee;

import javax.ejb.EJBException;
import java.util.ArrayList;
import java.util.List;

public interface StaffLogInSessionBeanLocal {
    public List<Employee> getAllEmployees() throws EJBException;
    public Employee findEmployee(String id) throws EJBException;
    public List<Employee> readEmployee(int currentPage, int recordsPerPage, String keyword) throws EJBException;
    public int getNumberOfRows(String keyword) throws EJBException;
    public void updateEmployee(String[] s) throws EJBException;
    public void deleteEmployee(String id) throws EJBException;
    public void addEmployee(String[] s) throws EJBException;
    public List<Employee> findSubordinates(String s) throws EJBException;

}
