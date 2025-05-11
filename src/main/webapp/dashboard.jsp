<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Safely retrieve session attributes with defaults
    String loggedUserName = (session.getAttribute("loggedUserName") != null && !((String) session.getAttribute("loggedUserName")).isEmpty())
            ? (String) session.getAttribute("loggedUserName") : "Admin";
    String loggedUserEmail = (session.getAttribute("loggedUserEmail") != null)
            ? (String) session.getAttribute("loggedUserEmail") : "";
    String updateStatus = request.getParameter("update");
    String errorMessage = (String) request.getAttribute("errorMessage");

    // Safely get user initial
    String userInitial = loggedUserName.substring(0, 1).toUpperCase();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Smart OAS Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #5e72e4;
            --secondary: #f7fafc;
            --dark: #1a1a2e;
            --light: #f8f9fa;
            --success: #2dce89;
            --info: #11cdef;
            --warning: #fb6340;
            --danger: #f5365c;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #f0f2f5;
            color: #525f7f;
        }

        .sidebar {
            background: white;
            min-height: 100vh;
            position: fixed;
            width: 250px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
            padding: 20px 0;
        }

        .sidebar-header {
            padding: 0 20px 20px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        .sidebar-menu {
            padding: 0;
            list-style: none;
        }

        .sidebar-menu li {
            padding: 10px 20px;
            transition: all 0.3s;
        }

        .sidebar-menu li:hover {
            background: rgba(0, 0, 0, 0.02);
        }

        .sidebar-menu li a {
            color: #525f7f;
            text-decoration: none;
            display: block;
        }

        .sidebar-menu li.active {
            background: rgba(94, 114, 228, 0.1);
            border-left: 3px solid var(--primary);
        }

        .sidebar-menu li.active a {
            color: var(--primary);
            font-weight: 500;
        }

        .main-content {
            margin-left: 250px;
            padding: 20px;
        }

        .navbar {
            background: white;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.05);
            border-radius: 10px;
            padding: 15px 20px;
        }

        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.05);
            margin-bottom: 20px;
        }

        .card-header {
            background: white;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            font-weight: 600;
            padding: 15px 20px;
        }

        .stat-card {
            padding: 20px;
            border-radius: 10px;
            background: white;
        }

        .stat-value {
            font-size: 1.8rem;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .stat-label {
            color: #8898aa;
            font-size: 0.875rem;
            margin-bottom: 5px;
        }

        .stat-change {
            font-size: 0.75rem;
            color: var(--success);
        }

        .progress-thin {
            height: 6px;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--primary);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        .btn-report {
            background: var(--primary);
            color: white;
            font-weight: 500;
            padding: 10px 20px;
            border-radius: 30px;
        }

        .btn-report:hover {
            background: #4a5acf;
            color: white;
        }

        .table-custom thead th {
            background: #f6f9fc;
            border-bottom-width: 1px;
            font-weight: 600;
        }

        .form-control {
            border-radius: 8px;
            padding: 10px 15px;
        }

        .btn-save {
            background: var(--success);
            color: white;
            font-weight: 500;
            padding: 10px 25px;
            border-radius: 8px;
        }
    </style>
</head>
<body>
<div class="sidebar">
    <div class="sidebar-header">
        <h4>Interface</h4>
    </div>
    <ul class="sidebar-menu">
        <li class="active"><a href="dashboard.jsp">Dashboard</a></li>
        <li><a href="results.jsp">Result</a></li>
        <li><a href="index.jsp">Main Menu</a></li>
    </ul>

    <div class="px-3 mt-4">
        <h6 class="text-uppercase text-muted mb-3">UI Toolkit</h6>
        <ul class="sidebar-menu">
            <li><a href="#">Components</a></li>
            <li><a href="#">Content</a></li>
            <li><a href="#">Forms</a></li>
            <li><a href="#">Utilities</a></li>
        </ul>
    </div>
</div>

<div class="main-content">
    <nav class="navbar mb-4">
        <div class="container-fluid p-0">
            <h5 class="mb-0">Dashboard</h5>
            <div class="d-flex align-items-center">
                <div class="me-3">
                    <span class="text-muted">Sales overview & summary</span>
                </div>
                <div class="user-avatar me-2">
                    <%= userInitial %>
                </div>
                <span class="me-3"><%= loggedUserName %></span>
            </div>
        </div>
    </nav>

    <%-- Success or Failure message --%>
    <% if ("success".equals(updateStatus)) { %>
    <div class="alert alert-success text-center">
        User information updated successfully!
    </div>
    <% } else if ("fail".equals(updateStatus)) { %>
    <div class="alert alert-danger text-center">
        Failed to update user information. Please try again.
    </div>
    <% } %>

    <%-- Error Message if set in request --%>
    <% if (errorMessage != null) { %>
    <div class="alert alert-danger text-center">
        <%= errorMessage %>
    </div>
    <% } %>

    <div class="row">
        <div class="col-md-4">
            <div class="stat-card">
                <div class="stat-label">Tests Count</div>
                <div class="stat-value">52</div>
                <div class="stat-change">+3% from last month</div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card">
                <div class="stat-label">Questions Count</div>
                <div class="stat-value">9</div>
                <div class="stat-change">+3% from last month</div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card">
                <div class="stat-label">Users Count</div>
                <div class="stat-value">39</div>
                <div class="stat-change">+3% from last month</div>
            </div>
        </div>
    </div>

    <div class="row mt-4">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h6 class="mb-0">Test Applications Statistics</h6>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-custom">
                            <thead>
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
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card">
                <div class="card-header">
                    <h6 class="mb-0">Revenue Breakdown</h6>
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <div class="d-flex justify-content-between mb-1">
                            <span>Actual</span>
                            <span>40,000</span>
                        </div>
                        <div class="d-flex justify-content-between mb-1">
                            <span>Revenue</span>
                            <span>$59,482</span>
                        </div>
                        <div class="d-flex justify-content-between mb-1">
                            <span>Deal</span>
                            <span>20,000</span>
                        </div>
                        <div class="text-end text-success">119%</div>
                    </div>
                    <div class="text-center mt-4">
                        <a href="#" class="btn btn-report">OPEN REPORT</a>
                    </div>
                </div>
            </div>

            <div class="card mt-4">
                <div class="card-header">
                    <h6 class="mb-0">Account Storage</h6>
                </div>
                <div class="card-body">
                    <p class="small text-muted">Your account storage is shared across all devices.</p>
                    <div class="d-flex justify-content-between mb-1">
                        <span>10 GB of 30 GB used</span>
                        <span>33%</span>
                    </div>
                    <div class="progress progress-thin">
                        <div class="progress-bar" style="width: 33%"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="card mt-4">
        <div class="card-header">
            <h6 class="mb-0">Member Information</h6>
        </div>
        <div class="card-body">
            <form action="dashboard" method="post" class="row g-3">
                <div class="col-md-6">
                    <label for="name" class="form-label">Name</label>
                    <input type="text" name="name" class="form-control" id="name" value="<%= loggedUserName %>" required>
                </div>
                <div class="col-md-6">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" id="password" required>
                </div>
                <div class="col-md-6">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" id="email" value="<%= loggedUserEmail %>" required>
                </div>
                <div class="col-12">
                    <button type="submit" class="btn btn-save">Save Member</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>