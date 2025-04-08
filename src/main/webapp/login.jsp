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
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('exam-bg.jpg') center/cover no-repeat;
            color: white;
            text-align: center;
            padding: 120px 20px;
        }
        .login-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
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
                <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#login">Login</a></li>
                <li class="nav-item"><a class="nav-link" href="#features">Features</a></li>
                <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero">
    <div class="container">
        <h1>Welcome to Online Examination & Result Management</h1>
        <p>Your platform for secure, efficient, and reliable examinations</p>
        <a href="login.jsp" class="btn btn-warning btn-lg">Login Now</a>
    </div>
</section>

<style>
    .hero {
        /* Background image and styling */
        background: url('/pictures/welcome.png') center/cover no-repeat;
        color: white;
        text-align: center;
        padding: 120px 20px;
        height: auto; /* Adjust height based on your content */
    }
</style>

<!-- Login Section -->
<section id="login" class="container py-5">
    <div class="login-container">
        <h2 class="text-center mb-4">Login Portal</h2>
        <form action="login" method="post">
            <div class="mb-3">
                <label for="user" class="form-label">User Name</label>
                <input type="text" class="form-control" id="user" placeholder="Enter your name" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" placeholder="Enter your password" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
        </form>
        <div class="text-center mt-3">
            <p>Not registered? <a href="registration.jsp" class="btn btn-outline-secondary">Register Here</a></p>
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
