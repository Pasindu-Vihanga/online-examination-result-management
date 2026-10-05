<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%
    List<String[]> results = (List<String[]>) request.getAttribute("results");
    String sort = (String) request.getAttribute("sort");
    if (sort == null) sort = "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Results & Performance Management - Admin Console</title>
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
            <div class="brand-icon-box" style="background: linear-gradient(135deg, #10b981 0%, #06b6d4 100%);">
                <i class="bi bi-bar-chart-line-fill"></i>
            </div>
            <span>ResultsManager</span>
        </a>

        <div class="d-flex align-items-center gap-2">
            <a href="admindashboard.jsp" class="btn btn-outline-light btn-sm rounded-pill px-3">
                <i class="bi bi-speedometer2 me-1"></i> Admin Dashboard
            </a>
        </div>
    </div>
</nav>

<div class="container my-4 flex-grow-1">

    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
        <div>
            <h3 class="fw-bold text-white mb-1">Student Examination Results</h3>
            <p class="text-muted small mb-0">Review scores, modify evaluated marks, or sort rankings via custom LinkedList data structure</p>
        </div>
        <div class="d-flex gap-2">
            <form method="GET" action="AdminResultManagementServlet" class="m-0">
                <input type="hidden" name="sort" value="allAsc" />
                <button type="submit" class="btn btn-modern-primary btn-sm">
                    <i class="bi bi-sort-numeric-down me-1"></i> Sort Scores Ascending (LinkedList)
                </button>
            </form>
            <a href="AdminResultManagementServlet?sort=" class="btn btn-outline-secondary btn-sm">
                <i class="bi bi-arrow-clockwise me-1"></i> Reset View
            </a>
        </div>
    </div>

    <!-- Results Table Card -->
    <div class="admin-card-dark p-4 shadow-sm animate-fade-in">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <span class="fw-bold text-white">Candidate Score Records</span>
            <% if ("allAsc".equalsIgnoreCase(sort)) { %>
                <span class="badge bg-info bg-opacity-25 text-info border border-info border-opacity-50 px-2.5 py-1 rounded">
                    <i class="bi bi-funnel-fill me-1"></i>Sorted: Ascending Order
                </span>
            <% } %>
        </div>

        <div class="table-responsive">
            <table class="table admin-table align-middle mb-0 text-center">
                <thead>
                    <tr>
                        <th style="text-align: left;">Candidate Index</th>
                        <th>Subject Code</th>
                        <th>Marks</th>
                        <th>Evaluation Status</th>
                        <th style="text-align: right;">Modify / Manage</th>
                    </tr>
                </thead>
                <tbody>
                <% if (results != null && !results.isEmpty()) {
                    for (String[] result : results) {
                        String studentId = result[0];
                        String examCode = result[1];
                        int score = 0;
                        try { score = Integer.parseInt(result[2]); } catch (Exception ignored) {}
                        boolean isPass = score >= 45;
                %>
                <tr>
                    <td style="text-align: left;" class="fw-semibold">
                        <i class="bi bi-person-fill text-primary me-2"></i><%= studentId %>
                    </td>
                    <td>
                        <span class="badge bg-primary bg-opacity-25 text-primary border border-primary border-opacity-50 px-2.5 py-1 rounded">
                            <%= examCode %>
                        </span>
                    </td>
                    <td class="fw-bold fs-6"><%= score %></td>
                    <td>
                        <span class="badge <%= isPass ? "bg-success bg-opacity-25 text-success border border-success border-opacity-50" : "bg-danger bg-opacity-25 text-danger border border-danger border-opacity-50" %> rounded-pill px-3 py-1">
                            <%= isPass ? "PASSED" : "FAILED" %>
                        </span>
                    </td>
                    <td style="text-align: right;">
                        <div class="d-inline-flex align-items-center gap-2">
                            <!-- Update Score Form -->
                            <form method="POST" action="AdminResultManagementServlet" class="d-inline-flex align-items-center gap-1 m-0">
                                <input type="hidden" name="studentId" value="<%= studentId %>">
                                <input type="hidden" name="examCode" value="<%= examCode %>">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="sort" value="<%= sort %>">
                                <input type="number" name="newScore" class="form-control admin-input-dark form-control-sm text-center" 
                                       placeholder="Score" style="width: 70px;" min="0" max="100" required>
                                <button type="submit" class="btn btn-warning btn-sm" title="Update Score">
                                    <i class="bi bi-check2"></i>
                                </button>
                            </form>

                            <!-- Delete Form -->
                            <form method="POST" action="AdminResultManagementServlet" class="d-inline m-0">
                                <input type="hidden" name="studentId" value="<%= studentId %>">
                                <input type="hidden" name="examCode" value="<%= examCode %>">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="sort" value="<%= sort %>">
                                <button type="submit" class="btn btn-outline-danger btn-sm" title="Delete Result">
                                    <i class="bi bi-trash3"></i>
                                </button>
                            </form>
                        </div>
                    </td>
                </tr>
                <%   }
                } else { %>
                <tr>
                    <td colspan="5" class="text-center text-muted py-5">
                        <i class="bi bi-journal-x fs-1 d-block mb-2"></i>
                        No student examination results recorded yet.
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>

</div>

<!-- Footer -->
<footer class="py-3 text-center text-muted small border-top border-secondary border-opacity-10 mt-5">
    &copy; 2026 Online Examination Management System &bull; Results Engine
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
