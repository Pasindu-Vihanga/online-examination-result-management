<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Assuming a "Student" class and a "students" list are passed from the backend to this JSP.
    List<Student> students = (List<Student>) request.getAttribute("students");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registered Students</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('exam-bg.jpg') center/cover;
            color: white;
            text-align: center;
            padding: 50px 20px;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Exam Portal</a>
        <span class="navbar-text ms-auto">
            Logged in as: <strong><%= (String) session.getAttribute("username") %></strong>
        </span>
    </div>
</nav>

<section class="hero">
    <div class="container">
        <h1>Registered Students</h1>
        <p>View the names and passwords of all registered students</p>
    </div>
</section>

<section class="container py-5">
    <div class="table-responsive">
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
            <tr>
                <th>Name</th>
                <th>Password</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (students != null && !students.isEmpty()) {
                    for (Student student : students) {
            %>
            <tr>
                <td><%= student.getName() %></td>
                <td><%= student.getPassword() %></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="2" class="text-center">No registered students found</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</section>
</body>
</html>
