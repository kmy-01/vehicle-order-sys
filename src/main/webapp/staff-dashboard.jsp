<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 8/13/2022
  Time: 12:12 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.utar.model.entity.Employee" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Staff Dashboard</title>

  <meta name="description" content="Order Management Monitoring System">
  <meta name="viewport" content="width=device-width">

  <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="css/bootstrap.css">
  <link rel="stylesheet" href="css/normalize.min.css">
  <link rel="stylesheet" href="css/font-awesome.min.css">
  <link rel="stylesheet" href="css/animate.css">
  <link rel="stylesheet" href="css/templatemo-misc.css">
  <link rel="stylesheet" href="css/templatemo-style.css">

  <script src="js/vendor/modernizr-2.6.2.min.js"></script>
</head>

<body>

  <header class="site-header">
    <div class="top-header">
      <div class="container">
        <div class="row">
          <div class="col-md-4 col-sm-4 col-xs-8">
            <div class="logo">
              <h1><a href="#">Kool Store</a></h1>
            </div> <!-- /.logo -->
          </div> <!-- /.col-md-4 -->
          <div class="col-md-6 col-sm-6">
            <div class="main-header">
              <a class="nav-element" href="index.html">Staff Log Out</a>
              <a class="nav-element" href="staff-account.jsp">Account</a>
            </div> <!-- /.top-header-left -->
          </div> <!-- /.col-md-6 -->
        </div> <!-- /.row -->
      </div> <!-- /.container -->
    </div> <!-- /.top-header -->
  </header> <!-- /.site-header -->

  <div class="container table-padding">
    <%
      Employee staff = (Employee) request.getAttribute("staff");
      request.getSession().setAttribute("staff-session", staff);
    %>
    <h2>Welcome, <%= staff.getFirstname() %>.</h2>
    <h3>Staffs under your supervision</h3>
    <table>
      <thead>
      <tr>
        <th>Staff ID</th>
        <th>Extension Number</th>
        <th>Full Name</th>
        <th>Email</th>
        <th>Job Title</th>
        <th>Country</th>
        <th>Office Code</th>
      </tr>
      </thead>
      <tbody>
      <%
        List<Employee> subordinateList = (List<Employee>) request.getAttribute("subordinates");
        for (Employee subordinate : subordinateList){
          out.println("<tr>");
          out.println("<td>"+ subordinate.getId() +"</td>");
          out.println("<td>"+ subordinate.getExtension() +"</td>");
          out.println("<td>"+ subordinate.getFirstname() + " " + subordinate.getLastname() +"</td>");
          out.println("<td>"+ subordinate.getEmail() +"</td>");
          out.println("<td>"+ subordinate.getJobtitle() +"</td>");
          out.println("<td>"+ subordinate.getJobtitle() +"</td>");
          out.println("<td>"+ subordinate.getJobtitle() +"</td>");
          out.println("</tr>");
        }
      %>
      </tbody>
    </table>
  </div>

  <script src="js/vendor/jquery-1.10.1.min.js"></script>
  <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.10.1.min.js"><\/script>')</script>
  <script src="js/jquery.easing-1.3.js"></script>
  <script src="js/bootstrap.js"></script>
  <script src="js/plugins.js"></script>
  <script src="js/main.js"></script>
</body>
</html>
