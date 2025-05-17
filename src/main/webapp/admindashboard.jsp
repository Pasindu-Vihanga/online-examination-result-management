<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Online Exam Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #eef2f7, #dde3f0);
            color: #333;
        }
        .navbar {
            background-color: #2c3138;
            padding: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('/pictures/new-admin-bg.jpg') center/cover no-repeat;
            color: white;
            text-align: center;
            padding: 100px 20px;
            border-radius: 15px;
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease-in-out;
        }
        .hero:hover {
            transform: scale(1.02);
        }
        .section-container {
            max-width: 900px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }
        .list-group-item {
            font-size: 1.2em;
            padding: 18px;
            border-radius: 10px;
            transition: all 0.3s ease;
            background: #f8f9fc;
        }
        .list-group-item:hover {
            background: #cfe2ff;
            transform: scale(1.04);
            font-weight: bold;
        }
        .list-group-item a {
            text-decoration: none;
            font-weight: bold;
            color: #0056b3;
        }
        .user-info {
            color: white;
            font-weight: bold;
            margin-right: 15px;
        }
        footer {
            background-color: #2c3138;
            color: white;
            padding: 20px 0;
            text-align: center;
            border-top: 3px solid #0056b3;
            margin-top: 40px;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="admindashboard.jsp">Admin Dashboard</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <%
                        String adminName = (session.getAttribute("inputUsername") != null) ? (String) session.getAttribute("inputUsername") : "Admin";
                    %>
                    <span class="user-info">👤 <%= adminName %></span>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-danger fw-bold" href="adminlogin.jsp">Logout</a>
                    <a class="nav-link text-danger fw-bold" href="feedbackrecords.jsp">Feedbacks</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Banner -->
<section class="hero">
    <div class="container">
        <h1 class="fw-bold">Welcome, Admin</h1>
        <p>Manage the system efficiently using the links below.</p>
    </div>
</section>

<!-- Dashboard Options -->
<section class="section-container">
    <ul class="list-group">
        <li class="list-group-item"><a href="manage.jsp">🔹 Admin Management - Add/Remove/View Admins</a></li>
        <li class="list-group-item"><a href="Exmindex.jsp">📊 Exam Manage - Add/Remove/Edit Exams</a></li>
        <li class="list-group-item"><a href="adminResultmanage.jsp">📊 Results Manage - Add/Remove/Edit Results</a></li>
        <li class="list-group-item"><a href="studentmanage.jsp">🎓 Manage Students - Add/Remove/View Students</a></li>
    </ul>
</section>

<!-- Footer -->
<footer>
    <p>&copy; 2025 Online Exam Portal | Admin Dashboard</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
