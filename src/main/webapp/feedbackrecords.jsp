<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.jsp.exam.model.feedbackmodel, com.jsp.exam.service.feedbackservice" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Feedback Submissions - Admin Console</title>
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
            <div class="brand-icon-box" style="background: linear-gradient(135deg, #8b5cf6 0%, #ec4899 100%);">
                <i class="bi bi-chat-quote-fill"></i>
            </div>
            <span>FeedbackRecords</span>
        </a>

        <div class="d-flex align-items-center gap-2">
            <a href="feedback.jsp" class="btn btn-outline-light btn-sm rounded-pill px-3">
                <i class="bi bi-chat-left-dots me-1"></i> Public Feedback Form
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
            <h3 class="fw-bold text-white mb-1">Candidate Feedback Records</h3>
            <p class="text-muted small mb-0">Inspect evaluation ratings and community comments submitted by candidates</p>
        </div>
    </div>

    <% if ("true".equals(request.getParameter("deleted"))) { %>
    <div class="alert alert-success alert-dismissible fade show d-flex align-items-center gap-2 py-2 mb-4" role="alert">
        <i class="bi bi-check-circle-fill fs-5"></i>
        <div class="small">Feedback record deleted successfully.</div>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <div class="admin-card-dark p-4 shadow-sm animate-fade-in">
        <%
            feedbackservice feedbackService = new feedbackservice();
            List<feedbackmodel> feedbackList = feedbackService.readFeedback();
        %>
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h5 class="fw-bold text-white mb-0 d-flex align-items-center gap-2">
                <i class="bi bi-list-stars text-primary"></i> All Feedback Submissions
            </h5>
            <span class="badge bg-primary bg-opacity-25 text-primary border border-primary border-opacity-50 px-2.5 py-1 rounded">
                <%= feedbackList.size() %> Submissions
            </span>
        </div>

        <div class="table-responsive">
            <table class="table admin-table align-middle mb-0">
                <thead>
                    <tr>
                        <th>Candidate Name</th>
                        <th>Email Address</th>
                        <th>Rating</th>
                        <th>Feedback Message</th>
                        <th style="text-align: right;">Action</th>
                    </tr>
                </thead>
                <tbody>
                <% if (!feedbackList.isEmpty()) {
                    for (feedbackmodel feedback : feedbackList) {
                        String r = feedback.getRating();
                        String badgeStyle = "bg-primary bg-opacity-25 text-primary border-primary border-opacity-50";
                        if ("excellent".equalsIgnoreCase(r)) badgeStyle = "bg-success bg-opacity-25 text-success border-success border-opacity-50";
                        else if ("bad".equalsIgnoreCase(r)) badgeStyle = "bg-danger bg-opacity-25 text-danger border-danger border-opacity-50";
                %>
                <tr>
                    <td class="fw-semibold">
                        <i class="bi bi-person-fill text-muted me-1"></i><%= feedback.getName() %>
                    </td>
                    <td class="text-muted"><%= feedback.getEmail() %></td>
                    <td>
                        <span class="badge <%= badgeStyle %> border rounded-pill px-2.5 py-1">
                            <%= r != null && !r.isEmpty() ? r : "Verified" %>
                        </span>
                    </td>
                    <td class="text-light" style="max-width: 320px;"><%= feedback.getMessage() %></td>
                    <td style="text-align: right;">
                        <form id="delFb_<%= feedback.getName().replaceAll("[^a-zA-Z0-9]", "") %>" action="feedbackS" method="POST" class="d-inline m-0">
                            <input type="hidden" name="name" value="<%= feedback.getName() %>">
                            <input type="hidden" name="action" value="delete">
                            <button type="button" class="btn btn-outline-danger btn-sm" onclick="confirmDeleteFeedback('<%= feedback.getName().replaceAll("[^a-zA-Z0-9]", "") %>', '<%= feedback.getName() %>')">
                                <i class="bi bi-trash3 me-1"></i> Delete
                            </button>
                        </form>
                    </td>
                </tr>
                <% } } else { %>
                <tr>
                    <td colspan="5" class="text-center text-muted py-5">
                        <i class="bi bi-chat-left-dots fs-1 d-block mb-2"></i>
                        No feedback records found.
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
    &copy; 2026 Online Examination Management System &bull; Feedback Module
</footer>

<script>
    function confirmDeleteFeedback(formId, candidateName) {
        Swal.fire({
            title: 'Delete Feedback Entry?',
            text: "Are you sure you want to remove feedback from '" + candidateName + "'?",
            icon: 'warning',
            background: '#111827',
            color: '#f9fafb',
            showCancelButton: true,
            confirmButtonColor: '#ef4444',
            cancelButtonColor: '#374151',
            confirmButtonText: 'Yes, delete entry'
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById('delFb_' + formId).submit();
            }
        });
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
