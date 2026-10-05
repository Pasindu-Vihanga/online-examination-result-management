<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.jsp.exam.service.ExamResultService, com.jsp.exam.service.Examservice" %>
<%
    String loggedUserName = (session.getAttribute("loggedUserName") != null && !((String) session.getAttribute("loggedUserName")).isEmpty())
            ? (String) session.getAttribute("loggedUserName") : "Student";
    String loggedUserEmail = (session.getAttribute("loggedUserEmail") != null)
            ? (String) session.getAttribute("loggedUserEmail") : "";
    String updateStatus = request.getParameter("update");
    String errorMessage = (String) request.getAttribute("errorMessage");

    String userInitial = loggedUserName.substring(0, 1).toUpperCase();

    ExamResultService examResultService = new ExamResultService();
    List<String> examCodes = examResultService.getExamCodes();

    Examservice examService = new Examservice();
    List<String[]> allQuestions = examService.getExamQuestions("");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - ExamHub</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Custom Theme -->
    <link href="css/modern-theme.css" rel="stylesheet">
</head>
<body class="bg-mesh">

<div class="dashboard-layout">
    <!-- Sidebar -->
    <aside class="dashboard-sidebar">
        <a class="sidebar-brand" href="dashboard.jsp">
            <div class="brand-icon-box" style="width: 32px; height: 32px; font-size: 1rem;">
                <i class="bi bi-mortarboard-fill"></i>
            </div>
            <span>ExamHub<span style="color: var(--primary);">.io</span></span>
        </a>

        <ul class="sidebar-nav">
            <li class="nav-section-title">Navigation</li>
            <li class="nav-item active"><a href="dashboard.jsp"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
            <li class="nav-item"><a href="examPortal.jsp"><i class="bi bi-pencil-square"></i> Take Examination</a></li>
            <li class="nav-item"><a href="results.jsp"><i class="bi bi-award"></i> View Exam Results</a></li>
            <li class="nav-item"><a href="feedback.jsp"><i class="bi bi-chat-dots"></i> Submit Feedback</a></li>

            <li class="nav-section-title">System</li>
            <li class="nav-item"><a href="index.jsp"><i class="bi bi-house"></i> Home Page</a></li>
            <li class="nav-item"><a href="login.jsp" class="text-danger"><i class="bi bi-box-arrow-right"></i> Log Out</a></li>
        </ul>

        <div class="mt-auto pt-3 border-top">
            <div class="d-flex align-items-center gap-2">
                <div class="user-avatar" style="background: var(--primary); width: 36px; height: 36px; font-size: 0.9rem;">
                    <%= userInitial %>
                </div>
                <div class="overflow-hidden">
                    <div class="fw-bold small text-truncate"><%= loggedUserName %></div>
                    <div class="text-muted small text-truncate" style="font-size: 0.75rem;"><%= loggedUserEmail.isEmpty() ? "Candidate Account" : loggedUserEmail %></div>
                </div>
            </div>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="dashboard-content">
        <!-- Topbar -->
        <header class="navbar-modern rounded-3 mb-4 p-3 d-flex align-items-center justify-content-between">
            <div>
                <h5 class="fw-bold mb-0">Candidate Overview</h5>
                <span class="text-muted small">Welcome back, <strong><%= loggedUserName %></strong>!</span>
            </div>
            <div class="d-flex align-items-center gap-2">
                <a href="examPortal.jsp" class="btn btn-modern-primary btn-sm">
                    <i class="bi bi-pencil-fill me-1"></i> Start Exam
                </a>
            </div>
        </header>

        <%-- Status Alerts --%>
        <% if ("success".equals(updateStatus)) { %>
        <div class="alert alert-success alert-dismissible fade show d-flex align-items-center gap-2 py-2" role="alert">
            <i class="bi bi-check-circle-fill fs-5"></i>
            <div class="small">Your profile details have been updated successfully!</div>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } else if ("fail".equals(updateStatus)) { %>
        <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center gap-2 py-2" role="alert">
            <i class="bi bi-exclamation-triangle-fill fs-5"></i>
            <div class="small">Failed to update profile information. Please verify inputs.</div>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } %>

        <% if (errorMessage != null) { %>
        <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center gap-2 py-2" role="alert">
            <i class="bi bi-exclamation-triangle-fill fs-5"></i>
            <div class="small"><%= errorMessage %></div>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } %>

        <!-- Metrics Row -->
        <div class="row g-3 mb-4">
            <div class="col-md-4">
                <div class="stat-widget">
                    <div>
                        <div class="stat-title">Available Modules</div>
                        <div class="stat-val"><%= examCodes.size() %></div>
                        <div class="small text-muted mt-1"><i class="bi bi-journal-text me-1"></i>Active exam subjects</div>
                    </div>
                    <div class="stat-icon-box icon-purple">
                        <i class="bi bi-book"></i>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="stat-widget">
                    <div>
                        <div class="stat-title">Question Repository</div>
                        <div class="stat-val"><%= allQuestions.size() %></div>
                        <div class="small text-muted mt-1"><i class="bi bi-database me-1"></i>Stored in MySQL</div>
                    </div>
                    <div class="stat-icon-box icon-cyan">
                        <i class="bi bi-question-square"></i>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="stat-widget">
                    <div>
                        <div class="stat-title">Student Index</div>
                        <div class="stat-val text-success" style="font-size: 1.4rem;"><%= loggedUserName %></div>
                        <div class="small text-muted mt-1"><i class="bi bi-shield-check text-success me-1"></i>Verified Session</div>
                    </div>
                    <div class="stat-icon-box icon-emerald">
                        <i class="bi bi-patch-check"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Available Exams & Profile Settings -->
        <div class="row g-4">
            <!-- Available Examinations Table -->
            <div class="col-lg-8">
                <div class="modern-card h-100">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="fw-bold mb-0 d-flex align-items-center gap-2">
                            <i class="bi bi-list-stars text-primary"></i> Available Examination Papers
                        </h6>
                        <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-2 py-1 rounded">
                            <%= examCodes.size() %> Active
                        </span>
                    </div>

                    <div class="table-responsive">
                        <table class="table-modern w-100">
                            <thead>
                                <tr>
                                    <th>Subject Code</th>
                                    <th>Status</th>
                                    <th style="text-align: right;">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (!examCodes.isEmpty()) { 
                                    for (String code : examCodes) { %>
                                    <tr>
                                        <td class="fw-semibold">
                                            <i class="bi bi-file-earmark-text text-primary me-2"></i><%= code %>
                                        </td>
                                        <td>
                                            <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill px-2.5 py-1">
                                                Ready to Take
                                            </span>
                                        </td>
                                        <td style="text-align: right;">
                                            <a href="examPortal.jsp?examCode=<%= code %>" class="btn btn-modern-primary btn-sm py-1 px-3">
                                                <i class="bi bi-play-circle"></i> Start
                                            </a>
                                        </td>
                                    </tr>
                                <% } } else { %>
                                    <tr>
                                        <td colspan="3" class="text-center text-muted py-4">No examination papers are currently published.</td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Profile Info Update -->
            <div class="col-lg-4">
                <div class="modern-card">
                    <h6 class="fw-bold mb-3 d-flex align-items-center gap-2">
                        <i class="bi bi-person-gear text-primary"></i> Update Credentials
                    </h6>
                    <form action="dashboard" method="POST">
                        <div class="mb-3">
                            <label for="name" class="form-label-modern">Username</label>
                            <input type="text" name="name" class="form-control form-control-modern" id="name" 
                                   value="<%= loggedUserName %>" required readonly style="background-color: #f1f5f9;">
                            <div class="form-text small">Username acts as your unique student ID.</div>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label-modern">Email Address</label>
                            <input type="email" name="email" class="form-control form-control-modern" id="email" 
                                   value="<%= loggedUserEmail %>" required placeholder="name@example.com">
                        </div>

                        <div class="mb-4">
                            <label for="password" class="form-label-modern">New Password</label>
                            <input type="password" name="password" class="form-control form-control-modern" id="password" 
                                   required placeholder="Enter new password">
                        </div>

                        <button type="submit" class="btn btn-modern-primary w-100 py-2 justify-content-center">
                            <i class="bi bi-save"></i> Save Changes
                        </button>
                    </form>
                </div>
            </div>
        </div>

    </main>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>