<%@ page import="java.util.List" %>
<%@ page import="com.jsp.exam.model.StudentLog" %>
<%@ page import="com.jsp.exam.service.StudentMGservice" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Management</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="container mt-4">
<h2 class="text-center mb-4">Student Management</h2>

<table class="table table-striped">
    <thead class="table-dark">
    <tr>
        <th>Username</th>
        <th>Email</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <%
        StudentMGservice studentService = new StudentMGservice();
        List<StudentLog> students = studentService.readStudent();

        for (StudentLog student : students) {
    %>
    <tr>
        <td><%= student.getUsername() %></td>
        <td><%= student.getEmail() %></td>
        <td>
            <button class="btn btn-danger delete-btn" data-username="<%= student.getUsername() %>">Delete</button>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>

<script>
    $(document).ready(function() {
        $(".delete-btn").click(function() {
            var username = $(this).data("username");

            $.post("student", { action: "delete", username: username }, function(response) {
                alert(response);
                location.reload();
            });
        });
    });
</script>

<!-- Bootstrap JS (Optional) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
