<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.jsp.exam.service.ExamResultService, com.jsp.exam.service.Examservice, com.jsp.exam.service.Studentservice" %>
<%
    String adminName = (session.getAttribute("inputUsername") != null) ? (String) session.getAttribute("inputUsername") : "Admin";

    ExamResultService resultService = new ExamResultService();
    List<String> examCodes = resultService.getExamCodes();

    Examservice examService = new Examservice();
    List<String[]> questions = examService.getExamQuestions("");

    Studentservice studentService = new Studentservice();
    int studentCount = studentService.readStudents().size();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administrator Console - ExamHub</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Custom Theme -->
    <link href="css/modern-theme.css" rel="stylesheet">
    <style>
        body {
            background-color: #0b0f19;
            background-image: 
                radial-gradient(at 0% 0%, rgba(79, 70, 229, 0.12) 0px, transparent 50%),
                radial-gradient(at 100% 100%, rgba(6, 182, 212, 0.08) 0px, transparent 50%);
            color: #f1f5f9;
            min-height: 100vh;
        }
        .admin-nav {
            background: rgba(17, 24, 39, 0.9);
            border-bottom: 1px solid #1f2937;
            backdrop-filter: blur(12px);
        }
        .admin-stat-card {
            background: #111827;
            border: 1px solid #1f2937;
            border-radius: 14px;
            padding: 1.5rem;
            transition: var(--transition-normal);
        }
        .admin-stat-card:hover {
            border-color: #374151;
            transform: translateY(-2px);
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.4);
        }
        .admin-module-card {
            background: #111827;
            border: 1px solid #1f2937;
            border-radius: 16px;
            padding: 1.75rem;
            transition: var(--transition-normal);
            height: 100%;
            display: flex;
            flex-direction: column;
            text-decoration: none;
            color: inherit;
        }
        .admin-module-card:hover {
            border-color: #6366f1;
            background: #141c2e;
            transform: translateY(-4px);
            box-shadow: 0 12px 30px -5px rgba(99, 102, 241, 0.2);
            color: inherit;
        }
        .admin-module-icon {
            width: 52px;
            height: 52px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-bottom: 1.25rem;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

<!-- Navigation -->
<nav class="navbar navbar-expand-lg admin-nav sticky-top py-3">
    <div class="container">
        <a class="navbar-brand text-white fw-bold d-flex align-items-center gap-2" href="admindashboard.jsp">
            <div class="brand-icon-box" style="background: linear-gradient(135deg, #4f46e5 0%, #06b6d4 100%);">
                <i class="bi bi-shield-lock-fill"></i>
            </div>
            <span>AdminConsole<span class="text-primary">.io</span></span>
        </a>

        <div class="d-flex align-items-center gap-3">
            <span class="badge bg-dark border border-secondary border-opacity-50 text-light px-3 py-2 rounded-pill small">
                <i class="bi bi-person-fill text-primary me-1"></i> <%= adminName %>
            </span>
            <a href="feedbackrecords.jsp" class="btn btn-outline-light btn-sm rounded-pill px-3">
                <i class="bi bi-chat-left-text me-1"></i> Feedbacks
            </a>
            <a href="index.jsp" class="btn btn-danger btn-sm rounded-pill px-3">
                <i class="bi bi-box-arrow-right me-1"></i> Logout
            </a>
        </div>
    </div>
</nav>

<div class="container my-4 flex-grow-1">

    <!-- Header Banner -->
    <div class="p-4 p-md-5 rounded-4 mb-4" 
         style="background: linear-gradient(135deg, #1e1b4b 0%, #1e293b 100%); border: 1px solid #312e81;">
        <div class="row align-items-center">
            <div class="col-lg-8">
                <div class="badge bg-primary bg-opacity-25 text-primary border border-primary border-opacity-50 px-3 py-1 rounded-pill mb-2 small fw-semibold">
                    <i class="bi bi-check-circle-fill me-1"></i> Operational &bull; MySQL Active
                </div>
                <h2 class="fw-bold text-white mb-2">Welcome, <%= adminName %></h2>
                <p class="text-muted mb-0" style="max-width: 620px;">
                    Comprehensive administrative overview. Manage candidate registrations, question items, examination schedules, system audit logs, and instant grading.
                </p>
            </div>
            <div class="col-lg-4 text-lg-end mt-3 mt-lg-0">
                <a href="ExmaddExam.jsp" class="btn btn-modern-primary">
                    <i class="bi bi-plus-circle me-1"></i> Create New Exam
                </a>
            </div>
        </div>
    </div>

    <!-- Metrics Row -->
    <div class="row g-3 mb-4">
        <div class="col-md-3 col-6">
            <div class="admin-stat-card">
                <div class="text-muted small mb-1">Active Modules</div>
                <div class="fs-3 fw-bold text-white"><%= examCodes.size() %></div>
                <div class="small text-primary mt-1"><i class="bi bi-journals me-1"></i>Subject Codes</div>
            </div>
        </div>

        <div class="col-md-3 col-6">
            <div class="admin-stat-card">
                <div class="text-muted small mb-1">Total Questions</div>
                <div class="fs-3 fw-bold text-white"><%= questions.size() %></div>
                <div class="small text-info mt-1"><i class="bi bi-question-circle me-1"></i>Registered items</div>
            </div>
        </div>

        <div class="col-md-3 col-6">
            <div class="admin-stat-card">
                <div class="text-muted small mb-1">Student Candidates</div>
                <div class="fs-3 fw-bold text-white"><%= studentCount %></div>
                <div class="small text-success mt-1"><i class="bi bi-people me-1"></i>Registered users</div>
            </div>
        </div>

        <div class="col-md-3 col-6">
            <div class="admin-stat-card">
                <div class="text-muted small mb-1">Audit Security</div>
                <div class="fs-3 fw-bold text-success">Enabled</div>
                <div class="small text-warning mt-1"><i class="bi bi-shield-check me-1"></i>Logging events</div>
            </div>
        </div>
    </div>

    <!-- Management Modules Grid -->
    <h5 class="fw-bold text-white mb-3 d-flex align-items-center gap-2">
        <i class="bi bi-grid-fill text-primary"></i> Administrative Tooling
    </h5>

    <div class="row g-4">
        <!-- 1. Exam Management -->
        <div class="col-md-4">
            <a href="Exmindex.jsp" class="admin-module-card">
                <div class="admin-module-icon" style="background: rgba(99, 102, 241, 0.15); color: #818cf8;">
                    <i class="bi bi-pencil-square"></i>
                </div>
                <h5 class="fw-bold text-white mb-2">Exam Paper Management</h5>
                <p class="text-muted small mb-4">Create new test papers, define durations, write questions, and update answer keys.</p>
                <div class="mt-auto d-flex align-items-center text-primary fw-semibold small">
                    Open Manager <i class="bi bi-arrow-right ms-2"></i>
                </div>
            </a>
        </div>

        <!-- 2. Student Management -->
        <div class="col-md-4">
            <a href="studentmanage.jsp" class="admin-module-card">
                <div class="admin-module-icon" style="background: rgba(6, 182, 212, 0.15); color: #22d3ee;">
                    <i class="bi bi-person-lines-fill"></i>
                </div>
                <h5 class="fw-bold text-white mb-2">Candidate Directory</h5>
                <p class="text-muted small mb-4">View enrolled students, update access profiles, and manage student authorization records.</p>
                <div class="mt-auto d-flex align-items-center text-info fw-semibold small">
                    Manage Students <i class="bi bi-arrow-right ms-2"></i>
                </div>
            </a>
        </div>

        <!-- 3. Results Management -->
        <div class="col-md-4">
            <a href="AdminResultManagementServlet?sort=" class="admin-module-card">
                <div class="admin-module-icon" style="background: rgba(16, 185, 129, 0.15); color: #34d399;">
                    <i class="bi bi-bar-chart-line-fill"></i>
                </div>
                <h5 class="fw-bold text-white mb-2">Results & Analytics</h5>
                <p class="text-muted small mb-4">Evaluate examination outcomes, sort rankings with custom LinkedList structures, and export scores.</p>
                <div class="mt-auto d-flex align-items-center text-success fw-semibold small">
                    View Results <i class="bi bi-arrow-right ms-2"></i>
                </div>
            </a>
        </div>

        <!-- 4. Administrator Accounts -->
        <div class="col-md-4">
            <a href="manage.jsp" class="admin-module-card">
                <div class="admin-module-icon" style="background: rgba(245, 158, 11, 0.15); color: #fbbf24;">
                    <i class="bi bi-person-badge-fill"></i>
                </div>
                <h5 class="fw-bold text-white mb-2">Administrator Access</h5>
                <p class="text-muted small mb-4">Provision new system administrators, modify security credentials, and view admin rosters.</p>
                <div class="mt-auto d-flex align-items-center text-warning fw-semibold small">
                    Manage Admins <i class="bi bi-arrow-right ms-2"></i>
                </div>
            </a>
        </div>

        <!-- 5. Audit Logs -->
        <div class="col-md-4">
            <a href="logview.jsp" class="admin-module-card">
                <div class="admin-module-icon" style="background: rgba(244, 63, 94, 0.15); color: #fb7185;">
                    <i class="bi bi-shield-shaded"></i>
                </div>
                <h5 class="fw-bold text-white mb-2">Security Audit Logs</h5>
                <p class="text-muted small mb-4">Track administrative sign-in history, security events, and timestamped actions from MySQL.</p>
                <div class="mt-auto d-flex align-items-center text-danger fw-semibold small">
                    Inspect Logs <i class="bi bi-arrow-right ms-2"></i>
                </div>
            </a>
        </div>

        <!-- 6. Student Feedbacks -->
        <div class="col-md-4">
            <a href="feedbackrecords.jsp" class="admin-module-card">
                <div class="admin-module-icon" style="background: rgba(139, 92, 246, 0.15); color: #a78bfa;">
                    <i class="bi bi-chat-heart-fill"></i>
                </div>
                <h5 class="fw-bold text-white mb-2">Candidate Feedbacks</h5>
                <p class="text-muted small mb-4">Review student satisfaction ratings, issues reported, and system suggestions.</p>
                <div class="mt-auto d-flex align-items-center text-primary fw-semibold small">
                    Review Feedbacks <i class="bi bi-arrow-right ms-2"></i>
                </div>
            </a>
        </div>
    </div>

</div>

<!-- Footer -->
<footer class="py-3 text-center text-muted small border-top border-secondary border-opacity-10 mt-5">
    &copy; 2026 Online Examination Management System &bull; Enterprise Administrator Dashboard
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
