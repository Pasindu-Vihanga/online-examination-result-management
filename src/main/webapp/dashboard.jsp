<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Examination & Result Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('exam-bg.jpg') center/cover;
            color: white;
            text-align: center;
            padding: 100px 20px;
        }
        .sidebar {
            height: 100%;
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            background-color: #343a40;
            padding-top: 20px;
            color: white;
        }
        .sidebar a {
            color: white;
            text-decoration: none;
            display: block;
            padding: 10px;
        }
        .sidebar a:hover {
            background-color: #495057;
        }
        .content {
            margin-left: 270px; /* Align content to account for the sidebar */
            padding: 20px;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Exam Portal</a>
        <span class="navbar-text ms-auto">
            Logged in as: <strong><%= (username != null) ? username : "Guest" %></strong>
        </span>
    </div>
</nav>

<div class="sidebar">
    <h5 class="text-center">Navigation</h5>
    <a href="dashboard.jsp">Dashboard</a>
    <a href="results.jsp">View Results</a>
    <a href="exam.jsp">Exams</a>
    <a href="login.jsp">Logout</a>
</div>

<div class="content">
    <section class="hero">
        <div class="container">
            <h1>Welcome to Online Examination & Result Management</h1>
            <p>Secure, Efficient, and Reliable Examination System</p>
        </div>
    </section>

    <section id="features" class="container py-5">
        <div class="d-flex justify-content-center align-items-center min-vh-100">
            <!-- Update Member Details Card -->
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header text-center">
                        Update Member Details
                    </div>
                    <div class="card-body">
                        <form action="dashboard" method="POST" enctype="multipart/form-data">
                            <div class="mb-3">
                                <label for="name" class="form-label">Name</label>
                                <input type="text" class="form-control" id="name" name="name" required>
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                            <div class="mb-3">
                                <label for="address" class="form-label">Address</label>
                                <input type="text" class="form-control" id="address" name="address">
                            </div>
                            <div class="mb-3">
                                <label for="telephone" class="form-label">Telephone Number</label>
                                <input type="text" class="form-control" id="telephone" name="telephone">
                            </div>
                            <button type="submit" class="btn btn-primary">Update Details</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
</body>
</html>
