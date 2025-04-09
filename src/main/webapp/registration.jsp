<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Examination & Result Management - Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .form-container {
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
                <li class="nav-item"><a class="nav-link" href="#register">Register</a></li>
                <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
                <li class="nav-item"><a class="nav-link" href="#features">Features</a></li>
                <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
            </ul>
        </div>
    </div>
</nav>

<section id="register" class="container py-5">
    <div class="form-container bg-light">
        <h2 class="text-center">Registration Portal</h2>

        <form action="register" method="post">
            <div class="mb-3">
                <label for="name" class="form-label">Enter Name</label>
                <input type="text" class="form-control" id="name" name="name" placeholder="Enter name" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Create Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Create a password" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email Address</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Enter email address" required>
            </div>
            <button type="submit" class="btn btn-success w-100">Register</button>
        </form>

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
