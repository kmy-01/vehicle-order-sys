<%@ page import="com.utar.model.entity.Employee" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
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


    <%
        Employee staff = (Employee) request.getSession().getAttribute("staff-session");
    %>

    <div class="container">
        <h2>Profile</h2>
        <form action="StaffSignIn" method="post">
            <table class="container table-padding">
                <tbody>
                <tr>
                    <td>First Name: </td>
                    <td>
                        <span class="show"><%= staff.getFirstname() %></span>
                        <input type="text" name="fname" class="hide" value="<%= staff.getFirstname() %>">
                    </td>
                </tr>
                <tr>
                    <td>Last Name: </td>
                    <td>
                        <span class="show"><%= staff.getLastname() %></span>
                        <input type="text" name="lname" class="hide" value="<%= staff.getLastname() %>">
                    </td>
                </tr>
                <tr>
                    <td>Staff ID: </td>
                    <td>
                        <span class="show"><%= staff.getId() %></span>
                        <input type="number" name="staffid" maxlength="4" class="hide" value="<%= staff.getId() %>">
                    </td>
                </tr>
                <tr>
                    <td>Extension:</td>
                    <td>
                        <span class="show"><%= staff.getExtension() %></span>
                        <input type="number" name="extension" maxlength="4" class="hide" value="<%= staff.getExtension() %>">
                    </td>
                </tr>
                <tr>
                    <td>Email:</td>
                    <td>
                        <span class="show"><%= staff.getEmail() %></span>
                        <input type="email" name="email" class="hide" value="<%= staff.getEmail() %>">
                    </td>
                </tr>
                <tr>
                    <td>Office Code:</td>
                    <td>
<%--                        <%= staff.getOfficecode() %>--%>
                        <input type="number" name="officecode" maxlength="1" class="hide" value="">
                    </td>
                </tr>
                <tr>
                    <td>Region:</td>
                    <td>
                        <%--                        <%= staff.getOfficecode() %>--%>
                    </td>
                </tr>
                <tr>
                    <td>Job Title:</td>
                    <td>
                        <span class="show"><%= staff.getJobtitle() %></span>
                        <input type="text" name="jobtitle" class="hide" value="<%= staff.getJobtitle() %>">
                    </td>
                </tr>
                <tr>
                    <td>Reports to:</td>
                    <td>
                        <span class="show"><%= staff.getReportsto() %></span>
                        <input type="number" name="supervisor" maxlength="4" class="hide" value="<%= staff.getReportsto() %>">
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
        <button class="button"><a href="/staff-dashboard.jsp">Back</a></button>
        <button class="button show" onclick="editAccInfo()" id="edit_btn">Edit Info</button>
        <input type="submit" class="button hide" id="submit_btn" value="Submit Change">
    </div>

    <script>
        function editAccInfo(){
            console.log("Edit btn clicked");
            $('#submit_btn').toggleClass('hide show');
            $('#edit_btn').toggleClass('show hide');

            $('span[class=show]').toggleClass('show hide');
            $('input[class=hide]').toggleClass('hide show');
        }
    </script>


    <script src="js/vendor/jquery-1.10.1.min.js"></script>
    <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.10.1.min.js"><\/script>')</script>
    <script src="js/jquery.easing-1.3.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/plugins.js"></script>
    <script src="js/main.js"></script>
</body>
</html>