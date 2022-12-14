package com.utar.controller;


import com.utar.model.entity.Employee;
import com.utar.model.sessionbean.StaffLogInSessionBeanLocal;
import com.utar.utilities.ValidateManageLogic;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "staffSignIn", value = "/staffSignIn")
public class StaffSignIn extends HttpServlet {

    @EJB
    private StaffLogInSessionBeanLocal staffbean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getParameter("staff-username");

        try {
            Employee empFound =  staffbean.findEmployee(username);

            if ( Integer.parseInt( username ) == empFound.getId() ){
                List<Employee> subordinateList = staffbean.findSubordinates(username);
                request.setAttribute("staff", empFound);
                request.setAttribute("subordinates", subordinateList);

                RequestDispatcher dispatcher = request.getRequestDispatcher("staff-dashboard.jsp");
                dispatcher.forward(request, response);

            } else {
                PrintWriter out = response.getWriter();
                out.println( "<!DOCTYPE html>" );
                out.println( "<html><body>" );
                out.println( "<p>" );
                out.println( "Log In Failed. Please Try Again...");
                out.println( "</p>" );
                out.println( "</body></html>" );

                RequestDispatcher dispatcher = request.getRequestDispatcher("staff-login.html");
                dispatcher.forward(request, response);
            }
        } catch (EJBException ex) {	}
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Update Acc Info
        String[] infoToUpdate = new String[8];
        infoToUpdate[2] = request.getParameter("staffid");

        infoToUpdate[0] = request.getParameter("fname");
        infoToUpdate[1] = request.getParameter("lname");
        infoToUpdate[3] = request.getParameter("extension");
        infoToUpdate[4] = request.getParameter("email");
//        infoToUpdate[5] = request.getParameter("officecode");
        infoToUpdate[6] = request.getParameter("jobtitle");
        infoToUpdate[7] = request.getParameter("supervisor");

        staffbean.updateEmployee( infoToUpdate );

        PrintWriter out = response.getWriter();
        out.println("<SCRIPT type=\"text/javascript\">");
        out.println("window.location.assign(\"successful.html\")");
        out.println("</SCRIPT>");
    }
}
