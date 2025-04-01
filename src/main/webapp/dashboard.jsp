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
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            background-color: #343a40;
            color: white;
            padding: 20px;
            width: 200px;
        }
        .sidebar a {
            color: white;
            text-decoration: none;
            display: block;
            margin: 10px 0;
        }
        .sidebar a:hover {
            text-decoration: underline;
        }
        .content {
            margin-left: 220px;
            padding: 20px;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Exam Portal</a>
        <span class="navbar-text ms-auto">Logged in as: <strong>Username</strong></span>
    </div>
</nav>

<div class="sidebar">
    <h4>Navigation</h4>
    <a href="#">Home</a>
    <a href="#about">About</a>
    <a href="#features">Features</a>
    <a href="#contact">Contact</a>
    <h4 class="mt-4">Members</h4>
    <ul>
        <li>Member 1</li>
        <li>Member 2</li>
        <li>Member 3</li>
    </ul>
</div>

<div class="content">
    <section class="hero">
        <div class="container">
            <h1>Welcome to Online Examination & Result Management</h1>
            <p>Secure, Efficient, and Reliable Examination System</p>
            <a href="login.jsp" class="btn btn-primary">Login</a>
        </div>
    </section>

    <section id="features" class="container py-5">
        <div class="row">
            <!-- Existing Card: Update Member Details -->
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        Update Member Details
                    </div>
                    <div class="card-body">
                        <form action="dashboard" method="POST">
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

            <!-- New Card: Photo Upload -->
            <div class="col-md-6">
                <div class="card">
                    <img src="example.jpg" class="card-img-top" alt="Photo">
                    <div class="card-body">
                        <h5 class="card-title">Upload a Photo</h5>
                        <form>
                            <div class="form-group">
                                <label for="fileInput">Choose file</label>
                                <input type="file" class="form-control-file" id="fileInput" accept=".jpg, .png">
                            </div>
                            <button type="submit" class="btn btn-primary mt-3">Submit</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<footer class="bg-dark text-white text-center py-3">
    <p>&copy; 2025 Online Exam Portal. All Rights Reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
