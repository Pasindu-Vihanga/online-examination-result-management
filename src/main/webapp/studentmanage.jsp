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

<!-- Add Student Form -->
<div class="card p-4 shadow mb-4">
    <h4>Add New Student</h4>
    <form id="addStudentForm">
        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" class="form-control" id="username" name="username" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>
        <button type="submit" class="btn btn-primary w-100">Add Student</button>
    </form>
</div>

<!-- Student List Table -->
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
        // Handle Add Student Form Submission
        $("#addStudentForm").submit(function(event) {
            event.preventDefault();

            $.post("student", {
                action: "add",
                username: $("#username").val(),
                password: $("#password").val(),
                email: $("#email").val()
            }, function(response) {
                alert(response);
                location.reload();
            });
        });

        // Handle Delete Student Action
        $(".delete-btn").click(function() {
            var username = $(this).data("username");

            $.post("student", { action: "delete", username: username }, function(response) {
                alert(response);
                location.reload();
            });
        });
    });
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

