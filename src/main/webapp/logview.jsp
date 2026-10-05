<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.jsp.exam.util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Activity Logs - Online Exam Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f4f6f9;
            color: #333;
        }
        .log-card {
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.06);
            border: none;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold mb-1">🛡️ Admin Activity Logs</h2>
            <p class="text-muted mb-0">System audit trail persisted in MySQL database</p>
        </div>
        <div>
            <a href="manage.jsp" class="btn btn-primary me-2">Admin Panel</a>
            <a href="admindashboard.jsp" class="btn btn-outline-secondary">Dashboard</a>
        </div>
    </div>

    <div class="card log-card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th scope="col" class="ps-4">ID</th>
                            <th scope="col">Admin User</th>
                            <th scope="col">Action Performed</th>
                            <th scope="col">Timestamp</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        boolean hasLogs = false;
                        String sql = "SELECT id, username, action, log_time FROM admin_logs ORDER BY id DESC";
                        try (Connection conn = DBConnection.getConnection();
                             PreparedStatement ps = conn.prepareStatement(sql);
                             ResultSet rs = ps.executeQuery()) {
                            while (rs.next()) {
                                hasLogs = true;
                    %>
                        <tr>
                            <td class="ps-4 fw-semibold">#<%= rs.getInt("id") %></td>
                            <td><span class="badge bg-primary px-3 py-2"><%= rs.getString("username") %></span></td>
                            <td class="fw-medium"><%= rs.getString("action") %></td>
                            <td class="text-muted"><%= rs.getTimestamp("log_time") %></td>
                        </tr>
                    <%
                            }
                        } catch (Exception e) {
                    %>
                        <tr>
                            <td colspan="4" class="text-center text-danger py-4">Error loading logs: <%= e.getMessage() %></td>
                        </tr>
                    <%
                        }
                        if (!hasLogs) {
                    %>
                        <tr>
                            <td colspan="4" class="text-center text-muted py-4">No activity logs recorded yet.</td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
