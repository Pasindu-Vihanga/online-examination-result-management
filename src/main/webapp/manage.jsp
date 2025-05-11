<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('admin-bg.jpg') center/cover;
            color: white;
            text-align: center;
            padding: 50px 20px;
        }
        .actions-card {
            margin: 20px 0;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">Admin Panel</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link text-white" href="admindashboard.jsp">Dashboard</a></li>
            </ul>
        </div>
    </div>
</nav>

<section class="hero">
    <div class="container">
        <h1>Welcome Admin</h1>
        <p>Manage administrator accounts below.</p>
    </div>
</section>

<section class="container py-5">
    <h2 class="text-center">Admin Management</h2>
    <div class="row">
        <!-- Create Admin -->
        <div class="col-md-6">
            <div class="card actions-card">
                <div class="card-header bg-success text-white">Update Admin</div>
                <div class="card-body">
                    <form action="manage" method="post">
                        <input type="hidden" name="action" value="update">
                        <div class="mb-3">
                            <label for="adminUsername" class="form-label">Username:</label>
                            <input type="text" class="form-control" id="adminUsername" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label for="adminPassword" class="form-label">Password:</label>
                            <input type="password" class="form-control" id="adminPassword" name="password" required>
                        </div>
                        <button type="submit" class="btn btn-success">Update Admin</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Update Admin -->
        <div class="col-md-6">
            <div class="card actions-card">
                <div class="card-header bg-danger text-white">Delete Admin</div>
                <div class="card-body">
                    <form action="manage" method="post">
                        <input type="hidden" name="action" value="delete">
                        <div class="mb-3">
                            <label for="deleteAdminUsername" class="form-label">Username:</label>
                            <input type="text" class="form-control" id="deleteAdminUsername" name="username" required>
                        </div>
                        <button type="submit" class="btn btn-danger">Delete Admin</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- View Admin List -->
    <div class="row mt-4">
        <div class="col-md-6 mx-auto">
            <div class="card actions-card">
                <div class="card-header bg-info text-white text-center">View Admins</div>
                <div class="card-body">
                    <form action="manage" method="post">
                        <input type="hidden" name="action" value="read">
                        <button type="submit" class="btn btn-info w-100">Show Admin List</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<footer class="bg-dark text-white text-center py-3">
    <p>&copy; 2025 Admin Panel. All Rights Reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
