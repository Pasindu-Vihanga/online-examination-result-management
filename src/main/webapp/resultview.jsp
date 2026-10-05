<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map, com.jsp.exam.service.ExamResultService" %>
<%
    String studentId = request.getParameter("studentId");
    String examCode = request.getParameter("examCode");
    ExamResultService examService = new ExamResultService();

    Map<String, Boolean> results = new java.util.HashMap<>();
    int score = 0;
    if (studentId != null && examCode != null) {
        results = examService.evaluateStudentAnswers(studentId, examCode);
        score = examService.calculateScore(studentId, examCode);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Candidate Result Summary - ExamHub</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Custom Theme -->
    <link href="css/modern-theme.css" rel="stylesheet">
</head>
<body class="bg-mesh pb-5">

<!-- Top Navigation -->
<nav class="navbar navbar-expand-lg navbar-modern sticky-top">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">
            <div class="brand-icon-box">
                <i class="bi bi-mortarboard-fill"></i>
            </div>
            <span>ExamHub<span style="color: var(--primary);">.io</span></span>
        </a>
        <div class="d-flex align-items-center gap-2">
            <a href="results.jsp" class="btn btn-modern-secondary btn-sm">
                <i class="bi bi-search me-1"></i> Results Inquiry
            </a>
            <a href="dashboard.jsp" class="btn btn-modern-secondary btn-sm">
                <i class="bi bi-speedometer2 me-1"></i> Dashboard
            </a>
        </div>
    </div>
</nav>

<div class="container my-4" style="max-width: 760px;">

    <div class="modern-card text-center mb-4 animate-fade-in">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-1.5 rounded-pill fw-semibold">
                <%= examCode != null ? examCode : "Exam" %>
            </span>
            <span class="badge bg-success-subtle text-success border border-success-subtle px-3 py-1.5 rounded-pill fw-semibold">
                <i class="bi bi-check-circle-fill me-1"></i>Official Score
            </span>
        </div>

        <div class="score-badge-circle">
            <span class="score-num"><%= score %></span>
            <span class="score-total">Score</span>
        </div>

        <h4 class="fw-bold mb-1">Candidate: <%= studentId != null ? studentId : "Unknown" %></h4>
        <p class="text-muted small mb-4">Evaluated against certified answer keys</p>

        <div class="d-flex justify-content-center gap-2">
            <button class="btn btn-modern-secondary btn-sm" onclick="window.print()">
                <i class="bi bi-printer me-1"></i> Print Result
            </button>
            <a href="examPortal.jsp" class="btn btn-modern-primary btn-sm">
                <i class="bi bi-arrow-repeat me-1"></i> Exam Portal
            </a>
        </div>
    </div>

    <% if (!results.isEmpty()) { %>
    <div class="modern-card animate-fade-in">
        <h6 class="fw-bold mb-3 d-flex align-items-center gap-2">
            <i class="bi bi-list-check text-primary"></i> Detailed Answer Key Breakdown
        </h6>
        <div class="table-responsive">
            <table class="table-modern w-100">
                <thead>
                    <tr>
                        <th>Question No.</th>
                        <th>Evaluation</th>
                        <th style="text-align: right;">Status</th>
                    </tr>
                </thead>
                <tbody>
                <% for (Map.Entry<String, Boolean> entry : results.entrySet()) { %>
                <tr>
                    <td class="fw-semibold">Question <%= entry.getKey() %></td>
                    <td>
                        <%= entry.getValue() 
                            ? "<span class='text-success'><i class='bi bi-check-circle-fill me-1'></i>Correct</span>" 
                            : "<span class='text-danger'><i class='bi bi-x-circle-fill me-1'></i>Incorrect</span>" 
                        %>
                    </td>
                    <td style="text-align: right;">
                        <span class="badge <%= entry.getValue() ? "bg-success-subtle text-success border border-success-subtle" : "bg-danger-subtle text-danger border border-danger-subtle" %> rounded-pill px-2.5 py-1">
                            <%= entry.getValue() ? "PASS" : "FAIL" %>
                        </span>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
    <% } else { %>
    <div class="modern-card text-center p-4">
        <p class="text-muted mb-0">No recorded answers found for this candidate index on this subject.</p>
    </div>
    <% } %>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
