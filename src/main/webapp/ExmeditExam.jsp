<%@ page import="com.jsp.exam.model.ExamPaper" %>
<%@ page import="java.util.List" %>
<%
    ExamPaper exam = (ExamPaper) session.getAttribute("exam");
    List<String[]> questions = (List<String[]>) session.getAttribute("questions");

    String qTitle = "", qA = "", qB = "", qC = "", qD = "", correct = "", qNum = "";

    String selectedQuestionNumber = request.getParameter("questionNumber");
    if (selectedQuestionNumber == null || selectedQuestionNumber.isEmpty()) {
        selectedQuestionNumber = "1";
    }

    if (selectedQuestionNumber != null && questions != null) {
        for (String[] q : questions) {
            if (q.length >= 12 && q[10].equals(selectedQuestionNumber)) {
                qTitle = q[5];
                qA = q[6];
                qB = q[7];
                qC = q[8];
                qD = q[9];
                correct = q[11];
                qNum = q[10];
                break;
            }
        }
    }
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Edit Exam Paper - Admin Console</title>
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
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

<!-- Navigation -->
<nav class="navbar navbar-expand-lg admin-nav sticky-top py-3">
    <div class="container">
        <a class="navbar-brand text-white fw-bold d-flex align-items-center gap-2" href="Exmindex.jsp">
            <div class="brand-icon-box" style="background: linear-gradient(135deg, #4f46e5 0%, #06b6d4 100%);">
                <i class="bi bi-pencil-square"></i>
            </div>
            <span>ExamManager</span>
        </a>

        <div class="d-flex align-items-center gap-2">
            <a href="Exmindex.jsp" class="btn btn-outline-light btn-sm rounded-pill px-3">
                <i class="bi bi-arrow-left me-1"></i> Paper List
            </a>
            <a href="admindashboard.jsp" class="btn btn-outline-secondary btn-sm rounded-pill px-3">
                <i class="bi bi-speedometer2 me-1"></i> Dashboard
            </a>
        </div>
    </div>
</nav>

<div class="container my-4 flex-grow-1" style="max-width: 860px;">

    <!-- Question Navigation Buttons -->
    <div class="admin-card-dark p-3 mb-4 animate-fade-in">
        <div class="d-flex flex-wrap align-items-center justify-content-between gap-2">
            <span class="small fw-semibold text-muted">Select Question to Edit:</span>
            <div class="d-flex flex-wrap gap-2">
                <%
                    int totalQuestions = questions != null ? questions.size() : 0;
                    for (int i = 1; i <= totalQuestions; i++) {
                        boolean isSelected = String.valueOf(i).equals(selectedQuestionNumber);
                %>
                <a href="ExmeditExam.jsp?questionNumber=<%= i %>" 
                   class="btn <%= isSelected ? "btn-primary" : "btn-outline-secondary" %> btn-sm px-3 fw-bold">
                    Q<%= i %>
                </a>
                <%
                    }
                %>
            </div>
        </div>
    </div>

    <!-- Edit Form Card -->
    <div class="admin-card-dark p-4 p-md-5 animate-fade-in">
        <div class="d-flex align-items-center justify-content-between mb-4 pb-3 border-bottom border-secondary border-opacity-25">
            <div>
                <h4 class="fw-bold text-white mb-1">Edit Examination Details</h4>
                <p class="text-muted small mb-0">Currently editing <strong>Question <%= selectedQuestionNumber %></strong></p>
            </div>
            <span class="badge bg-primary bg-opacity-25 text-primary border border-primary border-opacity-50 px-3 py-2 rounded-pill">
                <%= exam != null ? exam.getCode() : "Module" %>
            </span>
        </div>

        <form action="UpdateExamQuestion" method="POST">
            <!-- Basic Information -->
            <div class="mb-4">
                <h6 class="text-uppercase fw-bold text-primary mb-3" style="font-size: 0.8rem; letter-spacing: 0.05em;">
                    <i class="bi bi-1-circle-fill me-1"></i> Subject Header
                </h6>
                <div class="row g-3">
                    <div class="col-md-8">
                        <label class="form-label small fw-semibold text-light mb-1">Exam Title</label>
                        <input type="text" name="examTitle" class="form-control admin-input-dark" value="<%= exam != null ? exam.getTitle() : "" %>" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small fw-semibold text-light mb-1">Faculty</label>
                        <input type="text" name="faculty" class="form-control admin-input-dark" value="<%= exam != null ? exam.getFaculty() : "" %>" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small fw-semibold text-light mb-1">Module Code</label>
                        <input type="text" name="moduleCode" class="form-control admin-input-dark" value="<%= exam != null ? exam.getCode() : "" %>" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small fw-semibold text-light mb-1">Duration (mins)</label>
                        <input type="number" name="duration" class="form-control admin-input-dark" value="<%= exam != null ? exam.getDuration() : "" %>" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small fw-semibold text-light mb-1">Total Questions</label>
                        <input type="number" name="numberQuestions" class="form-control admin-input-dark" value="<%= exam != null ? exam.getTotalQuestions() : "" %>" required>
                    </div>
                </div>
            </div>

            <!-- Question Details -->
            <div class="mb-4">
                <h6 class="text-uppercase fw-bold text-info mb-3" style="font-size: 0.8rem; letter-spacing: 0.05em;">
                    <i class="bi bi-2-circle-fill me-1"></i> Question Details
                </h6>

                <input type="hidden" name="questionNumber" value="<%= qNum %>">

                <div class="mb-3">
                    <label class="form-label small fw-semibold text-light mb-1">Question Prompt</label>
                    <input type="text" name="questionTitle" class="form-control admin-input-dark" value="<%= qTitle %>" required>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label small fw-semibold text-light mb-1">Option A</label>
                        <div class="input-group">
                            <span class="input-group-text bg-dark border-secondary text-primary fw-bold">A</span>
                            <input type="text" name="optionA" class="form-control admin-input-dark" value="<%= qA %>" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small fw-semibold text-light mb-1">Option B</label>
                        <div class="input-group">
                            <span class="input-group-text bg-dark border-secondary text-primary fw-bold">B</span>
                            <input type="text" name="optionB" class="form-control admin-input-dark" value="<%= qB %>" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small fw-semibold text-light mb-1">Option C</label>
                        <div class="input-group">
                            <span class="input-group-text bg-dark border-secondary text-primary fw-bold">C</span>
                            <input type="text" name="optionC" class="form-control admin-input-dark" value="<%= qC %>" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small fw-semibold text-light mb-1">Option D</label>
                        <div class="input-group">
                            <span class="input-group-text bg-dark border-secondary text-primary fw-bold">D</span>
                            <input type="text" name="optionD" class="form-control admin-input-dark" value="<%= qD %>" required>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label small fw-semibold text-light mb-1">Correct Answer</label>
                    <select name="correctAnswer" class="form-select admin-input-dark" required>
                        <option value="A" <%= "A".equalsIgnoreCase(correct) ? "selected" : "" %>>Option A</option>
                        <option value="B" <%= "B".equalsIgnoreCase(correct) ? "selected" : "" %>>Option B</option>
                        <option value="C" <%= "C".equalsIgnoreCase(correct) ? "selected" : "" %>>Option C</option>
                        <option value="D" <%= "D".equalsIgnoreCase(correct) ? "selected" : "" %>>Option D</option>
                    </select>
                </div>
            </div>

            <div class="d-flex justify-content-end gap-3 pt-3 border-top border-secondary border-opacity-25">
                <a href="Exmindex.jsp" class="btn btn-outline-secondary px-4">Done</a>
                <button type="submit" class="btn btn-modern-primary px-4">
                    <i class="bi bi-save me-1"></i> Update Question
                </button>
            </div>
        </form>
    </div>

</div>

<!-- Footer -->
<footer class="py-3 text-center text-muted small border-top border-secondary border-opacity-10 mt-5">
    &copy; 2026 Online Examination Management System
</footer>

<!-- SweetAlert feedback -->
<%
    String status = request.getParameter("status");
    if ("success".equals(status)) {
%>
<script>
    Swal.fire({
        title: 'Question Updated!',
        text: 'Changes saved to the database successfully.',
        icon: 'success',
        background: '#111827',
        color: '#f9fafb',
        confirmButtonColor: '#4f46e5'
    });
</script>
<% } %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
