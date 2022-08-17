package com.utar.controller;

import com.utar.model.entity.Employee;
import com.utar.model.sessionbean.StaffLogInSessionBeanLocal;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "DisplayStaffInPage", value = "/DisplayStaffInPage")
public class DisplayStaffInPage extends HttpServlet {

    private static final long serialVersionUID = 1L;
    @EJB
    private StaffLogInSessionBeanLocal staffbean;


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int nOfPages = 0;
        int currentPage = Integer.parseInt(request.getParameter("currentPage"));
        int recordsPerPage = Integer.parseInt(request.getParameter("recordsPerPage"));
        String keyword = request.getParameter("keyword");
        String direction = request.getParameter("direction");

        // Use methods declared in Staff Session Bean
        try {
            int rows = staffbean.getNumberOfRows(keyword);
            nOfPages = rows / recordsPerPage;
            if (rows % recordsPerPage != 0) {
                nOfPages++;
            }
            if (currentPage > nOfPages && nOfPages != 0) {
                currentPage = nOfPages;
            }
            List<Employee> lists = staffbean.readEmployee(currentPage, recordsPerPage, keyword, direction);
            request.setAttribute("staffs", lists);
        } catch (EJBException ex) {
        }
        request.setAttribute("nOfPages", nOfPages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("recordsPerPage", recordsPerPage);
        request.setAttribute("keyword", keyword);
        request.setAttribute("direction", direction);

        // Dispatch request to all-staff-pagination.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("all-staff-pagination.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
