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
        .login-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">Exam Portal</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="#">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#login">Login</a></li>
                <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
                <li class="nav-item"><a class="nav-link" href="#features">Features</a></li>
                <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
            </ul>
        </div>
    </div>
</nav>

<section class="hero">
    <div class="container">
        <h1>Welcome to Online Examination & Result Management</h1>
        <p>Secure, Efficient, and Reliable Examination System</p>
        <a href="#login" class="btn btn-primary">Login</a>
    </div>
</section>

<section id="login" class="container py-5">
    <div class="login-container bg-light">
        <h2 class="text-center">Login Portal</h2>
        <form action="login" method="post">
            <div class="mb-3">
                <label for="user" class="form-label">User Name</label>
                <input type="text" class="form-control" id="user" placeholder="Enter your name">
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" placeholder="Enter your password">
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
        </form>
        <div class="text-center mt-3">
            <p>Not registered? <a href="register.html" class="btn btn-outline-secondary">Register Here</a></p>
        </div>
    </div>
</section>

<section id="features" class="container py-5">
    <div class="row">
        <div class="col-md-4">
            <h3>Online Exams</h3>
            <p>Conduct online exams securely with real-time monitoring.</p>
        </div>
        <div class="col-md-4">
            <h3>Instant Results</h3>
            <p>Get automated and instant results right after the test.</p>
        </div>
        <div class="col-md-4">
            <h3>Student Management</h3>
            <p>Manage students, track performance, and generate reports.</p>
        </div>
    </div>
</section>

<footer class="bg-dark text-white text-center py-3">
    <p>&copy; 2025 Online Exam Portal. All Rights Reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
