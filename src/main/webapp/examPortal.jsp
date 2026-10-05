<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.jsp.exam.service.ExamResultService, com.jsp.exam.service.Examservice" %>
<%
    String studentId = (String) session.getAttribute("studentId");
    if (studentId == null || studentId.isEmpty()) {
        studentId = (String) session.getAttribute("loggedUserName");
    }
    if (request.getParameter("studentId") != null && !request.getParameter("studentId").trim().isEmpty()) {
        studentId = request.getParameter("studentId").trim();
        session.setAttribute("studentId", studentId);
    }

    String examCode = request.getParameter("examCode");
    if (examCode != null && !examCode.trim().isEmpty()) {
        session.setAttribute("examCode", examCode.trim());
    } else {
        examCode = (String) session.getAttribute("examCode");
    }

    ExamResultService resultService = new ExamResultService();
    List<String> examCodes = resultService.getExamCodes();

    List<String[]> questionList = new ArrayList<>();
    int remainingMinutes = 30;

    if (examCode != null && !examCode.isEmpty()) {
        Examservice examService = new Examservice();
        questionList = examService.getExamQuestions(examCode);
        if (!questionList.isEmpty()) {
            try {
                remainingMinutes = Integer.parseInt(questionList.get(0)[3].trim());
            } catch (Exception ignored) {
                remainingMinutes = 30;
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Active Examination Portal - ExamHub</title>
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
            <a href="dashboard.jsp" class="btn btn-modern-secondary btn-sm">
                <i class="bi bi-speedometer2 me-1"></i> Dashboard
            </a>
            <a href="results.jsp" class="btn btn-modern-secondary btn-sm">
                <i class="bi bi-award me-1"></i> Results
            </a>
        </div>
    </div>
</nav>

<div class="container my-4" style="max-width: 860px;">

    <!-- Exam Selector Card -->
    <div class="modern-card mb-4 animate-fade-in">
        <div class="d-flex align-items-center justify-content-between mb-3">
            <div class="d-flex align-items-center gap-2">
                <div class="stat-icon-box icon-purple" style="width: 40px; height: 40px; font-size: 1.1rem;">
                    <i class="bi bi-journal-check"></i>
                </div>
                <div>
                    <h5 class="fw-bold mb-0">Examination Setup</h5>
                    <p class="text-muted small mb-0">Verify your candidate ID and select your assigned test paper</p>
                </div>
            </div>
            <% if (examCode != null && !questionList.isEmpty()) { %>
                <span class="badge bg-success-subtle text-success border border-success-subtle px-3 py-2 rounded-pill fw-semibold">
                    <i class="bi bi-check2-circle me-1"></i> Paper Loaded
                </span>
            <% } %>
        </div>

        <form method="GET" action="examPortal.jsp" class="row g-3 align-items-end" onsubmit="resetTimerStorage()">
            <div class="col-md-5">
                <label for="studentId" class="form-label-modern">Student Index Number / ID</label>
                <div class="input-icon-group">
                    <i class="bi bi-person-badge input-icon"></i>
                    <input type="text" class="form-control form-control-modern" id="studentId" name="studentId"
                           value="<%= studentId != null ? studentId : "" %>" required placeholder="e.g. IT202401">
                </div>
            </div>

            <div class="col-md-5">
                <label for="examCode" class="form-label-modern">Select Assessment Subject</label>
                <div class="input-icon-group">
                    <i class="bi bi-book input-icon"></i>
                    <select class="form-select form-control-modern" id="examCode" name="examCode" required>
                        <option value="" disabled <%= examCode == null ? "selected" : "" %>>-- Choose Subject Code --</option>
                        <% for (String code : examCodes) { %>
                        <option value="<%= code %>" <%= (examCode != null && examCode.equals(code)) ? "selected" : "" %>><%= code %></option>
                        <% } %>
                    </select>
                </div>
            </div>

            <div class="col-md-2">
                <button type="submit" class="btn btn-modern-primary w-100 py-2 justify-content-center">
                    <i class="bi bi-arrow-repeat"></i> Load
                </button>
            </div>
        </form>
    </div>

    <% if (examCode != null && !questionList.isEmpty()) { %>
        <!-- Floating Exam Header (Sticky) -->
        <div class="exam-header-bar animate-fade-in shadow-sm">
            <div>
                <div class="d-flex align-items-center gap-2 mb-1">
                    <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-2 py-1 rounded">
                        <i class="bi bi-tag-fill me-1"></i><%= examCode %>
                    </span>
                    <span class="small text-muted">Candidate: <strong><%= studentId %></strong></span>
                </div>
                <div class="small text-muted">
                    Answered <span id="answeredCount" class="fw-bold text-primary">0</span> of <span class="fw-bold"><%= questionList.size() %></span> questions
                </div>
            </div>

            <div class="d-flex align-items-center gap-3">
                <div class="timer-badge normal" id="timerBadgeBox">
                    <i class="bi bi-stopwatch"></i>
                    <span id="countdown">--:--</span>
                </div>
            </div>
        </div>

        <!-- Progress Bar -->
        <div class="progress mb-4" style="height: 6px; border-radius: 999px;">
            <div id="progressBar" class="progress-bar bg-primary" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
        </div>

        <!-- Questions Form -->
        <form id="examForm" action="ExamAttendanceServlet" method="POST">
            <input type="hidden" name="action" value="submitAll">
            <input type="hidden" name="studentId" value="<%= studentId %>">
            <input type="hidden" name="examCode" value="<%= examCode %>">

            <%
                int index = 1;
                for (String[] q : questionList) {
                    String qNum = q[10];
                    String qText = q[5];
                    String optA = q[6];
                    String optB = q[7];
                    String optC = q[8];
                    String optD = q[9];
            %>
            <div class="modern-card mb-4 animate-fade-in question-block" data-q="<%= qNum %>">
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <div class="d-flex align-items-center gap-2">
                        <span class="badge bg-secondary-subtle text-secondary px-2.5 py-1.5 rounded-pill fw-semibold">
                            Question <%= index %>
                        </span>
                    </div>
                    <span class="small text-muted" id="status_q_<%= qNum %>">
                        <i class="bi bi-circle text-muted me-1"></i>Not answered
                    </span>
                </div>

                <h6 class="fw-bold text-dark mb-4" style="font-size: 1.05rem; line-height: 1.5;">
                    <%= qText %>
                </h6>

                <!-- Option A -->
                <div>
                    <input type="radio" class="option-radio" name="answer_<%= qNum %>" value="A" id="q<%= qNum %>_a" onchange="onAnswerSelected('<%= qNum %>')">
                    <label class="option-label" for="q<%= qNum %>_a">
                        <span class="option-letter">A</span>
                        <span><%= optA %></span>
                    </label>
                </div>

                <!-- Option B -->
                <div>
                    <input type="radio" class="option-radio" name="answer_<%= qNum %>" value="B" id="q<%= qNum %>_b" onchange="onAnswerSelected('<%= qNum %>')">
                    <label class="option-label" for="q<%= qNum %>_b">
                        <span class="option-letter">B</span>
                        <span><%= optB %></span>
                    </label>
                </div>

                <!-- Option C -->
                <div>
                    <input type="radio" class="option-radio" name="answer_<%= qNum %>" value="C" id="q<%= qNum %>_c" onchange="onAnswerSelected('<%= qNum %>')">
                    <label class="option-label" for="q<%= qNum %>_c">
                        <span class="option-letter">C</span>
                        <span><%= optC %></span>
                    </label>
                </div>

                <!-- Option D -->
                <div>
                    <input type="radio" class="option-radio" name="answer_<%= qNum %>" value="D" id="q<%= qNum %>_d" onchange="onAnswerSelected('<%= qNum %>')">
                    <label class="option-label" for="q<%= qNum %>_d">
                        <span class="option-letter">D</span>
                        <span><%= optD %></span>
                    </label>
                </div>
            </div>
            <%
                    index++;
                }
            %>

            <!-- Submit Section -->
            <div class="modern-card text-center p-4">
                <h5 class="fw-bold mb-2">Ready to finish?</h5>
                <p class="text-muted small mb-3">Double-check all responses. Submitting will end your examination session and evaluate your final score.</p>
                <button type="button" class="btn btn-modern-primary px-5 py-2.5 fs-6" data-bs-toggle="modal" data-bs-target="#confirmSubmitModal">
                    <i class="bi bi-send-check me-1"></i> Submit Examination
                </button>
            </div>

            <!-- Confirm Modal -->
            <div class="modal fade" id="confirmSubmitModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content rounded-4 border-0 shadow">
                        <div class="modal-header border-0 pb-0">
                            <h5 class="modal-title fw-bold" id="confirmModalLabel">Confirm Submission</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body py-4 text-center">
                            <div class="stat-icon-box icon-purple mx-auto mb-3" style="width: 50px; height: 50px;">
                                <i class="bi bi-question-circle fs-3"></i>
                            </div>
                            <h6 class="fw-bold mb-2">Are you sure you want to finalize your exam?</h6>
                            <p class="text-muted small mb-0">
                                You have answered <span id="modalAnsweredCount" class="fw-bold text-primary">0</span> out of <span class="fw-bold"><%= questionList.size() %></span> questions.
                            </p>
                        </div>
                        <div class="modal-footer border-0 pt-0 justify-content-center gap-2">
                            <button type="button" class="btn btn-modern-secondary px-4" data-bs-dismiss="modal">Review Answers</button>
                            <button type="button" class="btn btn-modern-primary px-4" onclick="document.getElementById('examForm').submit();">Confirm & Submit</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>

    <% } else if (examCode != null) { %>
        <div class="modern-card text-center p-5 animate-fade-in">
            <div class="stat-icon-box icon-amber mx-auto mb-3" style="width: 50px; height: 50px;">
                <i class="bi bi-exclamation-triangle fs-3"></i>
            </div>
            <h5 class="fw-bold mb-2">No Questions Found</h5>
            <p class="text-muted">There are currently no examination questions registered for <strong><%= examCode %></strong>.</p>
            <a href="examPortal.jsp" class="btn btn-modern-secondary btn-sm">Select Another Exam</a>
        </div>
    <% } else { %>
        <div class="modern-card text-center p-5 animate-fade-in">
            <div class="stat-icon-box icon-cyan mx-auto mb-3" style="width: 50px; height: 50px;">
                <i class="bi bi-lightbulb fs-3"></i>
            </div>
            <h5 class="fw-bold mb-2">Instructions Before Beginning</h5>
            <p class="text-muted small mx-auto" style="max-width: 500px;">
                Enter your student index number, select your examination module, and click <strong>Load</strong> to begin. 
                Ensure your internet connection remains uninterrupted during the testing period.
            </p>
        </div>
    <% } %>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    const totalQuestions = <%= questionList.size() %>;
    const initialSeconds = <%= remainingMinutes * 60 %>;
    const examKey = "exam_timer_<%= examCode != null ? examCode : "default" %>";

    function resetTimerStorage() {
        sessionStorage.removeItem(examKey);
    }

    // Timer Logic
    <% if (examCode != null && !questionList.isEmpty()) { %>
    let storedTime = sessionStorage.getItem(examKey);
    let timeLeft = storedTime !== null ? parseInt(storedTime) : initialSeconds;

    function updateTimer() {
        const timerBadge = document.getElementById("timerBadgeBox");
        const countdownElem = document.getElementById("countdown");

        let minutes = Math.floor(timeLeft / 60);
        let seconds = timeLeft % 60;
        countdownElem.innerText = (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds < 10 ? "0" + seconds : seconds);

        // Styling based on time remaining
        if (timeLeft <= 120) {
            timerBadge.className = "timer-badge"; // red warning
        } else if (timeLeft <= 300) {
            timerBadge.className = "timer-badge warning";
        } else {
            timerBadge.className = "timer-badge normal";
        }

        if (timeLeft > 0) {
            timeLeft--;
            sessionStorage.setItem(examKey, timeLeft);
            setTimeout(updateTimer, 1000);
        } else {
            sessionStorage.removeItem(examKey);
            alert("Examination time has elapsed! Automatically submitting your answers now.");
            document.getElementById("examForm").submit();
        }
    }

    // Answer selection tracking
    const answeredQuestions = new Set();

    function onAnswerSelected(qNum) {
        answeredQuestions.add(qNum);

        const statusElem = document.getElementById("status_q_" + qNum);
        if (statusElem) {
            statusElem.innerHTML = '<i class="bi bi-check-circle-fill text-success me-1"></i><span class="text-success fw-semibold">Answered</span>';
        }

        updateProgress();
    }

    function updateProgress() {
        const answeredCount = answeredQuestions.size;
        document.getElementById("answeredCount").innerText = answeredCount;
        const modalCount = document.getElementById("modalAnsweredCount");
        if (modalCount) modalCount.innerText = answeredCount;

        const percentage = totalQuestions > 0 ? (answeredCount / totalQuestions) * 100 : 0;
        const progressBar = document.getElementById("progressBar");
        if (progressBar) {
            progressBar.style.width = percentage + "%";
        }
    }

    window.addEventListener("DOMContentLoaded", () => {
        updateTimer();
        // Check if any answers were pre-selected
        document.querySelectorAll(".option-radio:checked").forEach(input => {
            const name = input.getAttribute("name");
            if (name && name.startsWith("answer_")) {
                answeredQuestions.add(name.substring(7));
            }
        });
        updateProgress();
    });
    <% } %>
</script>
</body>
</html>
