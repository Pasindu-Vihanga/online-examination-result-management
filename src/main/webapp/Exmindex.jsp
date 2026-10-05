<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.jsp.exam.model.ExamPaper, com.jsp.exam.service.Examservice" %>
<%
    Examservice examService = new Examservice();
    List<String[]> allQuestions = examService.getExamQuestions(null);
    Map<String, ExamPaper> uniqueExams = new LinkedHashMap<>();

    for (String[] parts : allQuestions) {
        if (parts.length >= 12) {
            String code = parts[2];
            if (!uniqueExams.containsKey(code)) {
                ExamPaper paper = new ExamPaper(parts[0], parts[1], parts[2], parts[3], parts[4]);
                uniqueExams.put(code, paper);
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exam Management - Admin Console</title>
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
            <div class="brand-icon-box" style="background: linear-gradient(135deg, #4f46e5 0%, #06b6d4 100%);">
                <i class="bi bi-journal-bookmark-fill"></i>
            </div>
            <span>ExamManager</span>
        </a>

        <div class="d-flex align-items-center gap-2">
            <a href="admindashboard.jsp" class="btn btn-outline-light btn-sm rounded-pill px-3">
                <i class="bi bi-speedometer2 me-1"></i> Admin Dashboard
            </a>
            <a href="ExmaddExam.jsp" class="btn btn-modern-primary btn-sm">
                <i class="bi bi-plus-circle me-1"></i> Add Exam Paper
            </a>
        </div>
    </div>
</nav>

<div class="container my-4 flex-grow-1">

    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
        <div>
            <h3 class="fw-bold text-white mb-1">Examination Paper Repository</h3>
            <p class="text-muted small mb-0">Publish, modify, or archive examination papers and question sets</p>
        </div>
        <div>
            <a href="ExmaddExam.jsp" class="btn btn-modern-primary">
                <i class="bi bi-plus-lg me-1"></i> Create New Paper
            </a>
        </div>
    </div>

    <!-- Metrics -->
    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="admin-card-dark p-3">
                <div class="text-muted small">Distinct Modules</div>
                <div class="fs-3 fw-bold text-white"><%= uniqueExams.size() %></div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="admin-card-dark p-3">
                <div class="text-muted small">Total Questions Stored</div>
                <div class="fs-3 fw-bold text-primary"><%= allQuestions.size() %></div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="admin-card-dark p-3">
                <div class="text-muted small">Storage Engine</div>
                <div class="fs-3 fw-bold text-success">MySQL Database</div>
            </div>
        </div>
    </div>

    <!-- Exam Table Card -->
    <div class="admin-card-dark p-4 shadow-sm animate-fade-in">
        <div class="table-responsive">
            <table class="table admin-table align-middle mb-0">
                <thead>
                    <tr>
                        <th>Subject Title</th>
                        <th>Subject Code</th>
                        <th>Faculty</th>
                        <th>Duration</th>
                        <th>Questions</th>
                        <th style="text-align: right;">Management Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (!uniqueExams.isEmpty()) {
                        for (ExamPaper exam : uniqueExams.values()) { %>
                        <tr>
                            <td class="fw-semibold">
                                <i class="bi bi-file-earmark-text text-primary me-2"></i><%= exam.getTitle() %>
                            </td>
                            <td>
                                <span class="badge bg-primary bg-opacity-25 text-primary border border-primary border-opacity-50 px-2.5 py-1 rounded">
                                    <%= exam.getCode() %>
                                </span>
                            </td>
                            <td class="text-muted"><%= exam.getFaculty() %></td>
                            <td><%= exam.getDuration() %> mins</td>
                            <td><%= exam.getTotalQuestions() %> items</td>
                            <td style="text-align: right;">
                                <div class="d-inline-flex gap-2">
                                    <form action="EditExamNavi" method="GET" class="d-inline m-0">
                                        <input type="hidden" name="examCode" value="<%= exam.getCode() %>">
                                        <button type="submit" class="btn btn-outline-info btn-sm">
                                            <i class="bi bi-pencil-square me-1"></i> Edit
                                        </button>
                                    </form>
                                    <form id="deleteForm_<%= exam.getCode() %>" action="DeleteExam" method="POST" class="d-inline m-0">
                                        <input type="hidden" name="examCode" value="<%= exam.getCode() %>">
                                        <button type="button" class="btn btn-outline-danger btn-sm" onclick="confirmDelete('<%= exam.getCode() %>')">
                                            <i class="bi bi-trash3 me-1"></i> Delete
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    <% } } else { %>
                        <tr>
                            <td colspan="6" class="text-center py-5 text-muted">
                                <i class="bi bi-folder2-open fs-1 d-block mb-2"></i>
                                No examination papers have been created yet. Click "Create New Paper" above to start.
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
    &copy; 2026 Online Examination Management System &bull; Exam Management Module
</footer>

<script>
    function confirmDelete(examCode) {
        Swal.fire({
            title: 'Delete Exam Paper?',
            text: "This will remove subject '" + examCode + "' and all associated questions from the database.",
            icon: 'warning',
            background: '#111827',
            color: '#f9fafb',
            showCancelButton: true,
            confirmButtonColor: '#ef4444',
            cancelButtonColor: '#374151',
            confirmButtonText: 'Yes, delete paper'
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById('deleteForm_' + examCode).submit();
            }
        });
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
