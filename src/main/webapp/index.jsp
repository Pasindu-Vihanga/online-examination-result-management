<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Examination & Result Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #3a0ca3, #4361ee);
            color: white;
        }

        .navbar {
            background-color: transparent;
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.8rem;
            color: white;
        }

        .navbar-nav .nav-link {
            color: white;
            font-weight: 600;
            margin-left: 1rem;
        }

        .navbar-nav .nav-link:hover {
            color: #ffd60a;
        }

        .hero {
            padding: 120px 0;
            text-align: center;
        }

        .hero h1 {
            font-size: 3rem;
            font-weight: 700;
        }

        .hero p {
            font-size: 1.25rem;
            max-width: 650px;
            margin: 1rem auto;
            color: #dbe4ff;
        }

        .btn-custom {
            background-color: #4cc9f0;
            color: #000;
            font-weight: bold;
            padding: 12px 30px;
            border-radius: 50px;
            transition: 0.3s ease;
        }

        .btn-custom:hover {
            background-color: #3a86ff;
            color: #fff;
        }

        .features {
            background-color: white;
            color: #333;
            padding: 60px 20px;
            text-align: center;
        }

        .feature-icon {
            font-size: 2rem;
            color: #4361ee;
            margin-bottom: 10px;
        }

        footer {
            background-color: #1b1b1b;
            color: #ccc;
            padding: 20px;
            text-align: center;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="#">Exam Portal</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="memberslogin.jsp">Admin Login</a></li>
                <li class="nav-item"><a class="nav-link" href="#about">About Us</a></li>
                <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero">
    <div class="container">
        <h1>Online Examination & Result Management</h1>
        <p>Secure, efficient, and reliable examinations</p>
        <a href="login.jsp" class="btn btn-custom btn-lg mt-4">Student Login</a>
    </div>
</section>

<!-- Features Section -->
<section class="features">
    <div class="container">
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="feature-icon">🧑‍💻</div>
                <h5>Built for Developers</h5>
                <p>Customize and scale exams effortlessly with a developer-friendly interface.</p>
            </div>
            <div class="col-md-4 mb-4">
                <div class="feature-icon">📱</div>
                <h5>Responsive Design</h5>
                <p>Fully responsive across all devices for seamless exam experiences.</p>
            </div>
            <div class="col-md-4 mb-4">
                <div class="feature-icon">📘</div>
                <h5>Complete Documentation</h5>
                <p>All functionalities clearly documented to help you manage with ease.</p>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer>
    <p>&copy; 2025 Online Exam Portal | All Rights Reserved</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
