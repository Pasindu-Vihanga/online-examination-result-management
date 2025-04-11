<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Smart OAS Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f6f9;
        }
        .card-box {
            border-radius: 10px;
            padding: 20px;
            color: white;
        }
        .card-blue { background: #007bff; }
        .card-green { background: #28a745; }
        .card-red { background: #dc3545; }
        .card-orange { background: #fd7e14; }
        .sidebar {
            height: auto;
            background: #fff;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            padding: 20px;
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-2 sidebar">
            <h4>Smart OAS</h4>
            <ul class="nav flex-column">
                <li class="nav-item"><a class="nav-link" href="dashboard.jsp">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="results.jsp">Result</a></li>
                <li class="nav-item"><a class="nav-link" href="index.jsp">Main Menu</a></li>
            </ul>
        </div>

<div class="col-md-10">
            <h3 class="my-4">Dashboard</h3>
            <div class="row g-3">
                <div class="col-md-3">
                    <div class="card-box card-blue text-center">
                        <h4>Tests Count</h4>
                        <p>52 Total<br>41 Active Tests</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card-box card-green text-center">
                        <h4>Questions Count</h4>
                        <p>9 Total<br>11 Active Questions</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card-box card-red text-center">
                        <h4>Users Count</h4>
                        <p>39 Total<br>30 Active Users</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card-box card-orange text-center">
                        <h4>User Groups</h4>
                        <p>9 Total<br>1 Active Group</p>
                    </div>
                </div>
            </div>

            <div class="mt-5">
                <h5>Test Applications Statistics</h5>
                <table class="table table-bordered">
                    <thead class="table-light">
                    <tr>
                        <th>Test Name</th>
                        <th>Category</th>
                        <th>Subjects</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr><td>An Aptitude Test</td><td>APT</td><td>General Knowledge</td><td><button class="btn btn-sm btn-primary">Status</button></td></tr>
                    <tr><td>Vocabulary Test</td><td>Vocabulary</td><td>English</td><td><button class="btn btn-sm btn-primary">Status</button></td></tr>
                    <tr><td>Political Science</td><td>Politics</td><td>Civics</td><td><button class="btn btn-sm btn-primary">Status</button></td></tr>
                    <tr><td>Mathematical Expressions</td><td>Expressions</td><td>Mathematics</td><td><button class="btn btn-sm btn-primary">Status</button></td></tr>
                    <tr><td>Current Affairs</td><td>Latest News</td><td>General Knowledge</td><td><button class="btn btn-sm btn-primary">Status</button></td></tr>
                    </tbody>
                </table>
            </div>
            <div class="mt-5">
                <h5><b>Member Information</b></h5>
                <form action="dashboard" method="post" class="row g-3">
                    <div class="col-md-6">
                        <label>Name</label>
                        <input type="text" name="name" class="form-control">
                    </div>
                    <div class="col-md-6">
                        <label>Password</label>
                        <input type="password" name="password" class="form-control">
                    </div>
                    <div class="col-12">
                        <label>Address</label>
                        <input type="text" name="address" class="form-control">
                    </div>
                    <div class="col-md-6">
                        <label>Telephone</label>
                        <input type="text" name="telephone" class="form-control">
                    </div>
                    <div class="col-md-6">
                        <label>Email</label>
                        <input type="email" name="email" class="form-control">
                    </div>
                    <div class="col-12">
                        <button type="submit" class="btn btn-success">Save Member</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
