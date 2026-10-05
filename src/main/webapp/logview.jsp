<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.jsp.exam.util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Security Audit Logs - Admin Console</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
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
            <div class="brand-icon-box" style="background: linear-gradient(135deg, #ef4444 0%, #f97316 100%);">
                <i class="bi bi-shield-shaded"></i>
            </div>
            <span>AuditTrail</span>
        </a>

        <div class="d-flex align-items-center gap-2">
            <a href="manage.jsp" class="btn btn-outline-light btn-sm rounded-pill px-3">
                <i class="bi bi-people me-1"></i> Admin Access
            </a>
            <a href="admindashboard.jsp" class="btn btn-outline-secondary btn-sm rounded-pill px-3">
                <i class="bi bi-speedometer2 me-1"></i> Admin Dashboard
            </a>
        </div>
    </div>
</nav>

<div class="container my-4 flex-grow-1">

    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
        <div>
            <h3 class="fw-bold text-white mb-1">Security Audit Trail</h3>
            <p class="text-muted small mb-0">Immutable administrative activity log persisted to MySQL database</p>
        </div>
        <div>
            <button class="btn btn-outline-light btn-sm" onclick="location.reload()">
                <i class="bi bi-arrow-clockwise me-1"></i> Refresh Logs
            </button>
        </div>
    </div>

    <div class="admin-card-dark p-4 shadow-sm animate-fade-in">
        <div class="table-responsive">
            <table class="table admin-table align-middle mb-0">
                <thead>
                    <tr>
                        <th style="width: 10%;">Log ID</th>
                        <th style="width: 25%;">Admin Operator</th>
                        <th style="width: 40%;">Action Performed</th>
                        <th style="width: 25%;">Recorded Timestamp</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    boolean hasLogs = false;
                    String sql = "SELECT id, username, action, log_time FROM admin_logs ORDER BY id DESC LIMIT 100";
                    try (Connection conn = DBConnection.getConnection();
                         PreparedStatement ps = conn.prepareStatement(sql);
                         ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            hasLogs = true;
                            String act = rs.getString("action");
                            String badgeColor = "bg-primary text-primary border-primary";
                            if (act != null && act.toLowerCase().contains("fail")) {
                                badgeColor = "bg-danger text-danger border-danger";
                            } else if (act != null && act.toLowerCase().contains("success")) {
                                badgeColor = "bg-success text-success border-success";
                            }
                %>
                    <tr>
                        <td class="text-muted font-monospace">#<%= rs.getInt("id") %></td>
                        <td>
                            <div class="d-flex align-items-center gap-2">
                                <span class="badge bg-secondary bg-opacity-25 text-light border border-secondary border-opacity-50 px-2.5 py-1">
                                    <i class="bi bi-person-fill me-1"></i><%= rs.getString("username") %>
                                </span>
                            </div>
                        </td>
                        <td>
                            <span class="badge <%= badgeColor %> bg-opacity-25 border border-opacity-50 px-2.5 py-1 rounded">
                                <%= act %>
                            </span>
                        </td>
                        <td class="text-muted font-monospace small"><%= rs.getTimestamp("log_time") %></td>
                    </tr>
                <%
                        }
                    } catch (Exception e) {
                %>
                    <tr>
                        <td colspan="4" class="text-center text-danger py-4">Database Log Access Error: <%= e.getMessage() %></td>
                    </tr>
                <%
                    }
                    if (!hasLogs) {
                %>
                    <tr>
                        <td colspan="4" class="text-center text-muted py-5">
                            <i class="bi bi-clock-history fs-1 d-block mb-2"></i>
                            No administrative audit records logged yet.
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

</div>

<!-- Footer -->
<footer class="py-3 text-center text-muted small border-top border-secondary border-opacity-10 mt-5">
    &copy; 2026 Online Examination Management System &bull; System Audit Trail
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
