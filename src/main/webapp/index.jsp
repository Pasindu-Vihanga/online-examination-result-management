<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Examination & Result Management</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f9f9f9;
        }
        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('exam-bg.jpg') center/cover;
            color: white;
            text-align: center;
            padding: 120px 20px;
        }
        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
        }
        .section-title {
            margin: 30px 0;
            text-align: center;
            color: #333;
        }
        .feature-card {
            transition: transform 0.3s ease-in-out;
        }
        .feature-card:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        footer {
            background-color: #343a40;
            color: white;
            padding: 15px 0;
        }
    </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="#">Exam Portal</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="#">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="memberslogin.jsp">Member's Login</a></li>
                <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
                <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero">
    <div class="container">
        <h1 style="color: seagreen;">Welcome to Online Examination & Result Management</h1>
        <p style="color: gray;">Your platform for secure, efficient, and reliable examinations</p>
        <a href="login.jsp" class="btn btn-warning btn-lg">Login Now</a>
    </div>
</section>

<style>
    .hero {
        /* Background image and styling */
        background: url('/pictures/exam.png') center/cover no-repeat;
        color: white;
        text-align: center;
        padding: 120px 20px;
        height: auto; /* Adjust height based on your content */
    }
</style>
<!-- Features Section -->
<section id="features" class="container py-5">
    <h2 class="section-title">Features</h2>
    <div class="row">
        <div class="col-md-4">
            <div class="card feature-card">
                <div class="card-body text-center">
                    <h3 class="card-title">Online Exams</h3>
                    <p class="card-text">Conduct online exams securely with real-time monitoring.</p>
                    <a href="#" class="btn btn-primary">Learn More</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card feature-card">
                <div class="card-body text-center">
                    <h3 class="card-title">Instant Results</h3>
                    <p class="card-text">Get automated and instant results right after the test.</p>
                    <a href="#" class="btn btn-success">Learn More</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card feature-card">
                <div class="card-body text-center">
                    <h3 class="card-title">Student Management</h3>
                    <p class="card-text">Manage students, track performance, and generate reports.</p>
                    <a href="#" class="btn btn-info">Learn More</a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="text-center">
    <p>&copy; 2025 Online Exam Portal | All Rights Reserved</p>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
