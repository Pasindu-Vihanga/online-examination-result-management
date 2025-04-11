<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Management Page</title>
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
                <li class="nav-item"><a class="nav-link" href="#">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link text-danger" href="index.jsp">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<section class="hero">
    <div class="container">
        <h1>Welcome Admin</h1>
        <p>Manage members, oversee exams, and perform administrative actions efficiently.</p>
    </div>
</section>

<section id="management" class="container py-5">
    <h2 class="text-center">Management Portal</h2>
    <div class="row">
        <!-- Add Member Section -->
        <div class="col-md-6">
            <div class="card actions-card">
                <div class="card-header bg-primary text-white">Add New Member</div>
                <div class="card-body">
                    <form action="manage" method="post">
                        <input type="hidden" name="action" value="addMember">
                        <div class="mb-3">
                            <label for="AddmemberName" class="form-label">Member Name:</label>
                            <input type="text" class="form-control" id="AddmemberName" name="memberName" required>
                        </div>
                        <div class="mb-3">
                            <label for="memberPassword" class="form-label">Member Password:</label>
                            <input type="password" class="form-control" id="memberPassword" name="memberPassword" required>
                        </div>
                        <button type="submit" class="btn btn-success">Add Member</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Remove Member Section -->
        <div class="col-md-6">
            <div class="card actions-card">
                <div class="card-header bg-danger text-white">Remove Member</div>
                <div class="card-body">
                    <form action="manage" method="post">
                        <input type="hidden" name="action" value="remove">
                        <input type="hidden" name="type" value="member">
                        <div class="mb-3">
                            <label for="RemmemberName" class="form-label">Member Name:</label>
                            <input type="text" class="form-control" id="RemmemberName" name="name" required>
                        </div>
                        <button type="submit" class="btn btn-danger">Remove Member</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="row mt-4">
        <!-- Remove Student Section -->
        <div class="col-md-6">
            <div class="card actions-card">
                <div class="card-header bg-danger text-white">Remove Student</div>
                <div class="card-body">
                    <form action="manage" method="post">
                        <input type="hidden" name="action" value="remove">
                        <input type="hidden" name="type" value="student">
                        <div class="mb-3">
                            <label for="studentremoval" class="form-label">Student Name:</label>
                            <input type="text" class="form-control" id="studentremoval" name="name" required>
                        </div>
                        <button type="submit" class="btn btn-danger">Remove Student</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<section id="actions" class="container py-5">
    <h2 class="text-center">Admin Actions</h2>
    <div class="row">
        <div class="col-md-4">
            <div class="card actions-card">
                <div class="card-header bg-info text-white">View Reports</div>
                <div class="card-body">
                    <a href="viewReports.jsp" class="btn btn-info">Go to Reports</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card actions-card">
                <div class="card-header bg-secondary text-white">Approve Exams</div>
                <div class="card-body">
                    <a href="approveExams.jsp" class="btn btn-secondary">Approve Now</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card actions-card">
                <div class="card-header bg-warning text-white">Manage Students</div>
                <div class="card-body">
                    <a href="viewstudents.jsp" class="btn btn-warning">Students</a>
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
