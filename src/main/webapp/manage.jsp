<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.jsp.exam.model.AdminLog, com.jsp.exam.service.AdminMGservice" %>
<%
    AdminMGservice adminService = new AdminMGservice();
    List<AdminLog> adminList = adminService.readAdmin();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Account Management - Console</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- Custom Theme -->
    <link href="css/modern-theme.css" rel="stylesheet">
    <style>
        body {
            background-color: #0b0f19;
            color: #f1f5f9;
            min-height: 100vh;
        }
        .admin-nav {
            background: rgba(17, 24, 39, 0.9);
            border-bottom: 1px solid #1f2937;
            backdrop-filter: blur(12px);
        }
        .admin-card-dark {
            background: #111827;
            border: 1px solid #1f2937;
            border-radius: 16px;
        }
        .admin-input-dark {
            background-color: #1f2937 !important;
            border: 1px solid #374151 !important;
            color: #f9fafb !important;
        }
        .admin-input-dark:focus {
            border-color: #6366f1 !important;
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.25) !important;
        }
        .admin-table {
            color: #f1f5f9;
        }
        .admin-table thead th {
            background-color: #1f2937;
            color: #9ca3af;
            border-bottom: 1px solid #374151;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            padding: 1rem;
        }
        .admin-table tbody tr td {
            padding: 1rem;
            border-bottom: 1px solid #1f2937;
            vertical-align: middle;
        }
        .admin-table tbody tr:hover td {
            background-color: #1a2234;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

<!-- Navigation -->
<nav class="navbar navbar-expand-lg admin-nav sticky-top py-3">
    <div class="container">
        <a class="navbar-brand text-white fw-bold d-flex align-items-center gap-2" href="admindashboard.jsp">
            <div class="brand-icon-box" style="background: linear-gradient(135deg, #f59e0b 0%, #ef4444 100%);">
                <i class="bi bi-shield-lock-fill"></i>
            </div>
            <span>AdminAccess</span>
        </a>

        <div class="d-flex align-items-center gap-2">
            <a href="logview.jsp" class="btn btn-outline-light btn-sm rounded-pill px-3">
                <i class="bi bi-shield-shaded me-1"></i> Audit Logs
            </a>
            <a href="admindashboard.jsp" class="btn btn-outline-secondary btn-sm rounded-pill px-3">
                <i class="bi bi-speedometer2 me-1"></i> Dashboard
            </a>
        </div>
    </div>
</nav>

<div class="container my-4 flex-grow-1">

    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
        <div>
            <h3 class="fw-bold text-white mb-1">System Administrator Accounts</h3>
            <p class="text-muted small mb-0">Manage privileged administrator credentials and access levels</p>
        </div>
    </div>

    <div class="row g-4 mb-4">
        <!-- Add / Update Admin Form -->
        <div class="col-lg-5">
            <!-- Provision Admin -->
            <div class="admin-card-dark p-4 mb-4 animate-fade-in">
                <h5 class="fw-bold text-white mb-3 d-flex align-items-center gap-2">
                    <i class="bi bi-person-plus text-success"></i> Create Administrator
                </h5>
                <form action="manage" method="POST">
                    <input type="hidden" name="action" value="create">
                    <div class="mb-3">
                        <label for="createUsername" class="form-label small fw-semibold text-light mb-1">Username</label>
                        <input type="text" class="form-control admin-input-dark" id="createUsername" name="username" 
                               placeholder="Choose an admin username" required>
                    </div>
                    <div class="mb-3">
                        <label for="createPassword" class="form-label small fw-semibold text-light mb-1">Password</label>
                        <input type="password" class="form-control admin-input-dark" id="createPassword" name="password" 
                               placeholder="Create secure password" required>
                    </div>
                    <button type="submit" class="btn btn-modern-primary w-100 py-2 justify-content-center">
                        <i class="bi bi-plus-circle"></i> Provision Admin
                    </button>
                </form>
            </div>

            <!-- Update Admin Credentials -->
            <div class="admin-card-dark p-4 animate-fade-in">
                <h5 class="fw-bold text-white mb-3 d-flex align-items-center gap-2">
                    <i class="bi bi-key text-warning"></i> Update Admin Password
                </h5>
                <form action="manage" method="POST">
                    <input type="hidden" name="action" value="update">
                    <div class="mb-3">
                        <label for="updateUsername" class="form-label small fw-semibold text-light mb-1">Admin Username</label>
                        <input type="text" class="form-control admin-input-dark" id="updateUsername" name="username" 
                               placeholder="Existing admin username" required>
                    </div>
                    <div class="mb-3">
                        <label for="updatePassword" class="form-label small fw-semibold text-light mb-1">New Password</label>
                        <input type="password" class="form-control admin-input-dark" id="updatePassword" name="password" 
                               placeholder="Enter updated password" required>
                    </div>
                    <button type="submit" class="btn btn-warning w-100 py-2 fw-semibold">
                        <i class="bi bi-arrow-repeat me-1"></i> Update Credentials
                    </button>
                </form>
            </div>
        </div>

        <!-- Admins Directory Table -->
        <div class="col-lg-7">
            <div class="admin-card-dark p-4 h-100 animate-fade-in">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold text-white mb-0 d-flex align-items-center gap-2">
                        <i class="bi bi-shield-check text-primary"></i> Active Administrators
                    </h5>
                    <span class="badge bg-primary bg-opacity-25 text-primary border border-primary border-opacity-50 px-2.5 py-1 rounded">
                        <%= adminList.size() %> Authorized
                    </span>
                </div>

                <div class="table-responsive">
                    <table class="table admin-table align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Admin User</th>
                                <th>Role</th>
                                <th style="text-align: right;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (adminList != null && !adminList.isEmpty()) {
                                for (AdminLog admin : adminList) { 
                                    String initial = admin.getUsername() != null && !admin.getUsername().isEmpty() ? 
                                                     admin.getUsername().substring(0, 1).toUpperCase() : "A";
                            %>
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center gap-2">
                                        <div class="user-avatar" style="width: 32px; height: 32px; font-size: 0.8rem; background: #6366f1;">
                                            <%= initial %>
                                        </div>
                                        <span class="fw-semibold text-white"><%= admin.getUsername() %></span>
                                    </div>
                                </td>
                                <td>
                                    <span class="badge bg-success bg-opacity-25 text-success border border-success border-opacity-50 rounded-pill px-2.5 py-1">
                                        Super Admin
                                    </span>
                                </td>
                                <td style="text-align: right;">
                                    <form id="delForm_<%= admin.getUsername() %>" action="manage" method="POST" class="d-inline m-0">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="username" value="<%= admin.getUsername() %>">
                                        <button type="button" class="btn btn-outline-danger btn-sm" onclick="confirmDeleteAdmin('<%= admin.getUsername() %>')">
                                            <i class="bi bi-trash3 me-1"></i> Revoke
                                        </button>
                                    </form>
                                </td>
                            </tr>
                            <% } } else { %>
                            <tr>
                                <td colspan="3" class="text-center text-muted py-4">No administrators configured.</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

</div>

<!-- Footer -->
<footer class="py-3 text-center text-muted small border-top border-secondary border-opacity-10 mt-5">
    &copy; 2026 Online Examination Management System &bull; Admin Access Control
</footer>

<script>
    function confirmDeleteAdmin(username) {
        Swal.fire({
            title: 'Revoke Administrator Access?',
            text: "Are you sure you want to delete admin account: " + username + "?",
            icon: 'warning',
            background: '#111827',
            color: '#f9fafb',
            showCancelButton: true,
            confirmButtonColor: '#ef4444',
            cancelButtonColor: '#374151',
            confirmButtonText: 'Yes, revoke access'
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById('delForm_' + username).submit();
            }
        });
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
