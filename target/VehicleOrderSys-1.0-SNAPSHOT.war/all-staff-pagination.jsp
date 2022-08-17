<%@ page import="com.utar.model.entity.Employee" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 8/17/2022
  Time: 11:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%
        int currentPage = (int) request.getAttribute("currentPage");
        int recordsPerPage = (int) request.getAttribute("recordsPerPage");
        int nOfPages = (int) request.getAttribute("nOfPages");
        String keyword = (String) request.getAttribute("keyword");
        String direction = (String) request.getAttribute("direction");
    %>

<%--    <form class="form-inline md-form mr-auto mb-4" action="DisplayStaffInPage" method="get">--%>
<%--        <input class="form-control mr-sm-2" type="text" aria-label="Search" name="keyword" />--%>
<%--        <button class="btn aqua-gradient btn-rounded btn-sm my-0 btn btn-info" type="submit">Search</button>--%>
<%--        <input type="hidden" name="currentPage" value="<%=currentPage%>" />--%>
<%--        <input type="hidden" name="recordsPerPage" value="<%=recordsPerPage%>" />--%>
<%--        <input type="hidden" name="direction" value="<%=direction%>" />--%>
<%--    </form>--%>
<%--    <form class="form-inline md-form mr-auto mb-4" action="DisplayStaffInPage" method="get">--%>
<%--        <select class="form-control" id="direction" name="direction">--%>
<%--            <option value="ASC">ascending</option>--%>
<%--            <option value="DESC">descending</option>--%>
<%--        </select>--%>
<%--        <button class="btn aqua-gradient btn-rounded btn-sm my-0 btn btn-info" type="submit">Sorting</button>--%>
<%--        <input type="hidden" name="currentPage" value="<%=currentPage%>" />--%>
<%--        <input type="hidden" name="recordsPerPage" value="<%=recordsPerPage%>" />--%>
<%--        <input type="hidden" name="keyword" value="<%=keyword%>" />--%>
<%--    </form>--%>

    <div class="row col-md-6">
        <table class="table table-striped table-bordered table-sm">
            <tr>
                <th>ID</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Extension</th>
                <th>Email</th>
                <th>Office code</th>
                <th>Job Title</th>
                <th>Reports to</th>
            </tr>


            <%
                List<Employee> staffs = (List<Employee>) request.getAttribute("staffs");
                if (staffs.size() != 0) {
                    for (Employee t : staffs) {
                        out.println("<tr>");
                        out.println("<td>" + t.getId() + "</td>");
                        out.println("<td>" + t.getFirstname() + "</td>");
                        out.println("<td>" + t.getLastname() + "</td>");
                        out.println("<td>" + t.getExtension() + "</td>");
                        out.println("<td>" + t.getEmail() + "</td>");
//                        out.println("<td>" + t.getOfficecode() + "</td>");
                        out.println("<td>" + t.getJobtitle() + "</td>");
                        out.println("<td>" + t.getReportsto() + "</td>");
//                        out.println("<td><a href=\"EmployeeController?id=" + t.getId() + "\">Update</a></td>");
//                        out.println("<td><a href=\"EmployeeController?id=" + t.getId() + "\">Delete</a></td>");
                        out.println("</tr>");
                    }
                } else {
                    out.println("<tr>");
                    String status = "No records";
                    for (int i = 0; i < 8; i++) {
                        out.println("<td>" + status + "</td>");
                    }
                    out.println("</tr>");
                }
            %>
        </table>
    </div>

    <nav aria-label="Navigation for staffs">
        <ul class="pagination">
            <%
                if (currentPage != 1 && nOfPages != 0) {
                    out.println("<li class=\"page-item\">");
                    out.println("<a class=\"page-link\" href=\"" + "PaginationServlet?recordsPerPage=" + recordsPerPage + "&currentPage=1" + "&keyword=" + keyword + "&direction=" + direction + "\">First</a>");
                    out.println("</li>");
            %>
            <li class="page-item">
                <%
                    out.println("<a class=\"page-link\" href=\"" + "PaginationServlet?recordsPerPage=" + recordsPerPage + "&currentPage=" + (currentPage - 1) + "&keyword=" + keyword + "&direction=" + direction + "\">Previous</a>");
                %>
            </li>

            <% } %>

            <%
                if (currentPage < nOfPages) {
                    out.println("<li class=\"page-item\">");
                    out.println("<a class=\"page-link\" href=\"" + "PaginationServlet?recordsPerPage=" + recordsPerPage + "&currentPage=" + (currentPage + 1) + "&keyword=" + keyword + "&direction=" + direction+ "\">Next</a>");
                    out.println("</li>");
                    out.println("<li class=\"page-item\">");
                    out.println("<a class=\"page-link\" href=\"" + "PaginationServlet?recordsPerPage=" + recordsPerPage + "&currentPage=" + nOfPages + "&keyword=" + keyword + "&direction=" + direction+ "\">Last</a>");
                    out.println("</li>");
                }
            %>
        </ul>
    </nav>
    <%
        if (nOfPages != 0) {
            out.println("<p class=\"pageref\">");
            out.println(currentPage + " of " + nOfPages);
            out.println("</p>");
        }
    %>
    <script src="https://code.jquery.com/jquery-3.1.1.slim.min.js"></script>
    <script
            src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
    <script
            src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"></script>
    <button class="open-button" onclick="openForm()">Open Form</button>
    <div class="form-popup" id="myForm">
        <form action="EmployeeController" class="form-container" method="post">
            <h1>Add Employee</h1>
            <fieldset>
                <legend>Add Employee Details:</legend>
                <br> First Name:
                <input type="text" name="fname" /> <br>
                Last Name: <input type="text" name="lname" /> <br>
                Gender: <input type="text" name="gender" /> <br>
                DOB: <input type="text" name="dob" />
                <br> Hired Date: <input type="text" name="hdate" />
            </fieldset>
            <button type="submit" class="btn">Submit Test</button>
            <button type="button" class="btn cancel" onclick="closeForm()">Close</button>
            <button type="reset" class="btn">Reset</button>
        </form>
    </div>
    <script>
        function openForm() {
            document.getElementById("myForm").style.display = "block";
        }
        function closeForm() {
            document.getElementById("myForm").style.display = "none";
        }
    </script>
</body>
</html>
