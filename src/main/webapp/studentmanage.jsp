<%@ page import="java.util.List" %>
<%@ page import="com.jsp.exam.model.StudentLog" %>
<%@ page import="com.jsp.exam.service.StudentMGservice" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Candidate Directory - Admin Console</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- jQuery & SweetAlert2 -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
            <div class="brand-icon-box" style="background: linear-gradient(135deg, #06b6d4 0%, #3b82f6 100%);">
                <i class="bi bi-people-fill"></i>
            </div>
            <span>CandidateManager</span>
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
            <h3 class="fw-bold text-white mb-1">Student Candidate Directory</h3>
            <p class="text-muted small mb-0">Enroll student test candidates, view credentials, and revoke access</p>
        </div>
    </div>

    <div class="row g-4 mb-4">
        <!-- Add Candidate Card -->
        <div class="col-lg-4">
            <div class="admin-card-dark p-4 h-100 animate-fade-in">
                <h5 class="fw-bold text-white mb-3 d-flex align-items-center gap-2">
                    <i class="bi bi-person-plus text-info"></i> Enroll Candidate
                </h5>
                <form id="addStudentForm">
                    <div class="mb-3">
                        <label for="username" class="form-label small fw-semibold text-light mb-1">Student Username / Index</label>
                        <input type="text" class="form-control admin-input-dark" id="username" name="username" 
                               placeholder="e.g. IT202401" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label small fw-semibold text-light mb-1">Email Address</label>
                        <input type="email" class="form-control admin-input-dark" id="email" name="email" 
                               placeholder="student@example.com" required>
                    </div>
                    <div class="mb-4">
                        <label for="password" class="form-label small fw-semibold text-light mb-1">Initial Password</label>
                        <input type="password" class="form-control admin-input-dark" id="password" name="password" 
                               placeholder="Enter secure password" required>
                    </div>
                    <button type="submit" class="btn btn-modern-primary w-100 py-2 justify-content-center">
                        <i class="bi bi-plus-circle"></i> Add Student
                    </button>
                </form>
            </div>
        </div>

        <!-- Candidate Directory Table -->
        <div class="col-lg-8">
            <div class="admin-card-dark p-4 h-100 animate-fade-in">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold text-white mb-0 d-flex align-items-center gap-2">
                        <i class="bi bi-person-lines-fill text-primary"></i> Registered Students
                    </h5>
                    <%
                        StudentMGservice studentService = new StudentMGservice();
                        List<StudentLog> students = studentService.readStudent();
                    %>
                    <span class="badge bg-primary bg-opacity-25 text-primary border border-primary border-opacity-50 px-2.5 py-1 rounded">
                        <%= students.size() %> Enrolled
                    </span>
                </div>

                <div class="table-responsive">
                    <table class="table admin-table align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Candidate</th>
                                <th>Email</th>
                                <th style="text-align: right;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (students != null && !students.isEmpty()) {
                                for (StudentLog student : students) { 
                                    String initial = student.getUsername() != null && !student.getUsername().isEmpty() ? 
                                                     student.getUsername().substring(0, 1).toUpperCase() : "S";
                            %>
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center gap-2">
                                        <div class="user-avatar" style="width: 32px; height: 32px; font-size: 0.8rem; background: #0891b2;">
                                            <%= initial %>
                                        </div>
                                        <span class="fw-semibold text-white"><%= student.getUsername() %></span>
                                    </div>
                                </td>
                                <td class="text-muted"><%= student.getEmail() %></td>
                                <td style="text-align: right;">
                                    <button class="btn btn-outline-danger btn-sm delete-btn" data-username="<%= student.getUsername() %>">
                                        <i class="bi bi-trash3 me-1"></i> Delete
                                    </button>
                                </td>
                            </tr>
                            <% } } else { %>
                            <tr>
                                <td colspan="3" class="text-center text-muted py-4">No candidates enrolled yet.</td>
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
    &copy; 2026 Online Examination Management System &bull; Candidate Directory
</footer>

<script>
    $(document).ready(function() {
        $("#addStudentForm").submit(function(event) {
            event.preventDefault();

            $.post("student", {
                action: "add",
                username: $("#username").val().trim(),
                password: $("#password").val().trim(),
                email: $("#email").val().trim()
            }, function(response) {
                Swal.fire({
                    title: 'Student Enrolled!',
                    text: response,
                    icon: 'success',
                    background: '#111827',
                    color: '#f9fafb',
                    confirmButtonColor: '#4f46e5'
                }).then(() => {
                    location.reload();
                });
            }).fail(function() {
                Swal.fire({
                    title: 'Error',
                    text: 'Failed to add student. Please try again.',
                    icon: 'error',
                    background: '#111827',
                    color: '#f9fafb'
                });
            });
        });

        $(".delete-btn").click(function() {
            var username = $(this).data("username");

            Swal.fire({
                title: 'Delete Candidate?',
                text: "Revoke access for candidate: " + username,
                icon: 'warning',
                background: '#111827',
                color: '#f9fafb',
                showCancelButton: true,
                confirmButtonColor: '#ef4444',
                cancelButtonColor: '#374151',
                confirmButtonText: 'Yes, delete student'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.post("student", { action: "delete", username: username }, function(response) {
                        Swal.fire({
                            title: 'Deleted!',
                            text: response,
                            icon: 'success',
                            background: '#111827',
                            color: '#f9fafb',
                            confirmButtonColor: '#4f46e5'
                        }).then(() => {
                            location.reload();
                        });
                    });
                }
            });
        });
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
