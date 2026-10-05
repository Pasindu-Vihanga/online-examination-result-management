<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.jsp.exam.service.ExamResultService" %>
<%
    ExamResultService examService = new ExamResultService();
    List<String> examCodes = examService.getExamCodes();

    String paramStudentId = request.getParameter("studentId");
    if (paramStudentId == null || paramStudentId.trim().isEmpty()) {
        paramStudentId = (String) session.getAttribute("studentId");
        if (paramStudentId == null) {
            paramStudentId = (String) session.getAttribute("loggedUserName");
        }
    }

    String paramExamCode = request.getParameter("examCode");
    if (paramExamCode == null || paramExamCode.trim().isEmpty()) {
        paramExamCode = (String) session.getAttribute("examCode");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Academic Results & Performance - ExamHub</title>
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
            <a href="examPortal.jsp" class="btn btn-modern-secondary btn-sm">
                <i class="bi bi-pencil-square me-1"></i> Exam Portal
            </a>
            <a href="dashboard.jsp" class="btn btn-modern-secondary btn-sm">
                <i class="bi bi-speedometer2 me-1"></i> Dashboard
            </a>
        </div>
    </div>
</nav>

<div class="container my-4" style="max-width: 800px;">

    <!-- Inquiry Card -->
    <div class="modern-card mb-4 animate-fade-in">
        <div class="d-flex align-items-center gap-2 mb-3">
            <div class="stat-icon-box icon-purple" style="width: 40px; height: 40px; font-size: 1.1rem;">
                <i class="bi bi-search"></i>
            </div>
            <div>
                <h5 class="fw-bold mb-0">Examination Result Inquiry</h5>
                <p class="text-muted small mb-0">Enter candidate credentials to look up performance records</p>
            </div>
        </div>

        <form id="resultQueryForm" class="row g-3 align-items-end">
            <div class="col-md-5">
                <label for="studentId" class="form-label-modern">Student Index Number</label>
                <div class="input-icon-group">
                    <i class="bi bi-person-badge input-icon"></i>
                    <input type="text" class="form-control form-control-modern" id="studentId" name="studentId" 
                           value="<%= paramStudentId != null ? paramStudentId : "" %>" required placeholder="e.g. IT1150">
                </div>
            </div>

            <div class="col-md-5">
                <label for="examCode" class="form-label-modern">Examination Code</label>
                <div class="input-icon-group">
                    <i class="bi bi-book input-icon"></i>
                    <select class="form-select form-control-modern" id="examCode" name="examCode" required>
                        <option value="" disabled <%= paramExamCode == null ? "selected" : "" %>>-- Select Exam Code --</option>
                        <% for (String code : examCodes) { %>
                        <option value="<%= code %>" <%= (paramExamCode != null && paramExamCode.equals(code)) ? "selected" : "" %>><%= code %></option>
                        <% } %>
                    </select>
                </div>
            </div>

            <div class="col-md-2">
                <button type="submit" class="btn btn-modern-primary w-100 py-2 justify-content-center" id="searchBtn">
                    <i class="bi bi-search"></i> Search
                </button>
            </div>
        </form>
    </div>

    <!-- Loading Spinner -->
    <div id="loadingBox" class="text-center py-5 d-none">
        <div class="spinner-border text-primary" role="status">
            <span class="visually-hidden">Loading...</span>
        </div>
        <p class="text-muted small mt-2">Retrieving examination metrics...</p>
    </div>

    <!-- Error Box -->
    <div id="errorBox" class="alert alert-danger d-none animate-fade-in align-items-center gap-2" role="alert">
        <i class="bi bi-exclamation-triangle-fill fs-5"></i>
        <span id="errorMessage">Unable to fetch examination score. Please check the index number and exam code.</span>
    </div>

    <!-- Result Display Card (Initially Hidden) -->
    <div id="resultContainer" class="d-none animate-fade-in">
        <div class="modern-card text-center mb-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-1.5 rounded-pill fw-semibold" id="subjectBadge">
                    Exam Code
                </span>
                <span class="badge bg-success-subtle text-success border border-success-subtle px-3 py-1.5 rounded-pill fw-semibold">
                    <i class="bi bi-check-circle-fill me-1"></i>Verified Record
                </span>
            </div>

            <div class="score-badge-circle">
                <span class="score-num" id="scoreNum">--</span>
                <span class="score-total">Score</span>
            </div>

            <h4 class="fw-bold mb-1" id="candidateName">Candidate Result</h4>
            <p class="text-muted small mb-3" id="scoreFeedback">Detailed breakdown of answers submitted during this session.</p>

            <div class="d-flex justify-content-center gap-2">
                <button class="btn btn-modern-secondary btn-sm" onclick="window.print()">
                    <i class="bi bi-printer me-1"></i> Print Report
                </button>
                <a href="examPortal.jsp" class="btn btn-modern-primary btn-sm">
                    <i class="bi bi-arrow-repeat me-1"></i> Take Another Exam
                </a>
            </div>
        </div>

        <!-- Answers Breakdown Card -->
        <div class="modern-card">
            <h6 class="fw-bold mb-3 d-flex align-items-center gap-2">
                <i class="bi bi-list-check text-primary"></i> Question Evaluation Breakdown
            </h6>
            <div class="table-responsive">
                <table class="table-modern w-100">
                    <thead>
                        <tr>
                            <th style="width: 25%;">Question No.</th>
                            <th style="width: 50%;">Evaluation Status</th>
                            <th style="width: 25%; text-align: right;">Result</th>
                        </tr>
                    </thead>
                    <tbody id="resultsTableBody">
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    const queryForm = document.getElementById("resultQueryForm");
    const loadingBox = document.getElementById("loadingBox");
    const errorBox = document.getElementById("errorBox");
    const resultContainer = document.getElementById("resultContainer");

    function fetchResults(studentId, examCode) {
        if (!studentId || !examCode) return;

        loadingBox.classList.remove("d-none");
        errorBox.classList.add("d-none");
        resultContainer.classList.add("d-none");

        fetch("ViewAnswersServlet?studentId=" + encodeURIComponent(studentId) + "&examCode=" + encodeURIComponent(examCode))
            .then(res => {
                if (!res.ok) throw new Error("Result inquiry failed.");
                return res.json();
            })
            .then(data => {
                loadingBox.classList.add("d-none");

                // Populate scorecard
                document.getElementById("scoreNum").innerText = data.score;
                document.getElementById("subjectBadge").innerText = data.examCode;
                document.getElementById("candidateName").innerText = "Candidate: " + data.studentId;

                const score = parseInt(data.score);
                const feedbackElem = document.getElementById("scoreFeedback");
                if (score >= 75) {
                    feedbackElem.innerText = "Excellent performance! Distinction standard achieved.";
                } else if (score >= 50) {
                    feedbackElem.innerText = "Good effort! Examination passed successfully.";
                } else {
                    feedbackElem.innerText = "Below passing threshold. Further revision recommended.";
                }

                // Populate questions table
                const tableBody = document.getElementById("resultsTableBody");
                tableBody.innerHTML = "";

                if (data.answers && data.answers.length > 0) {
                    data.answers.forEach(item => {
                        const tr = document.createElement("tr");
                        tr.innerHTML = `
                            <td class="fw-semibold">Q${item.questionNumber}</td>
                            <td>
                                ${item.correct 
                                    ? '<span class="text-success"><i class="bi bi-check-circle-fill me-1"></i>Correct Answer</span>' 
                                    : '<span class="text-danger"><i class="bi bi-x-circle-fill me-1"></i>Incorrect Answer</span>'
                                }
                            </td>
                            <td style="text-align: right;">
                                <span class="badge ${item.correct ? 'bg-success-subtle text-success border border-success-subtle' : 'bg-danger-subtle text-danger border border-danger-subtle'} rounded-pill px-2.5 py-1">
                                    ${item.correct ? 'PASS' : 'FAIL'}
                                </span>
                            </td>
                        `;
                        tableBody.appendChild(tr);
                    });
                } else {
                    tableBody.innerHTML = `<tr><td colspan="3" class="text-center text-muted py-3">No specific question breakdowns available for this entry.</td></tr>`;
                }

                resultContainer.classList.remove("d-none");
            })
            .catch(err => {
                loadingBox.classList.add("d-none");
                errorBox.classList.remove("d-none");
                document.getElementById("errorMessage").innerText = "No submitted attempt found for candidate '" + studentId + "' on subject '" + examCode + "'.";
            });
    }

    queryForm.addEventListener("submit", function(e) {
        e.preventDefault();
        const studentId = document.getElementById("studentId").value.trim();
        const examCode = document.getElementById("examCode").value.trim();
        fetchResults(studentId, examCode);
    });

    // Auto-search if parameters are pre-populated
    window.addEventListener("DOMContentLoaded", () => {
        const urlParams = new URLSearchParams(window.location.search);
        const sId = urlParams.get("studentId") || "<%= paramStudentId != null ? paramStudentId : "" %>";
        const eCode = urlParams.get("examCode") || "<%= paramExamCode != null ? paramExamCode : "" %>";

        if (sId && eCode) {
            document.getElementById("studentId").value = sId;
            document.getElementById("examCode").value = eCode;
            fetchResults(sId, eCode);
        }
    });
</script>
</body>
</html>
