<%@ page import="com.jsp.exam.model.ExamPaper" %>
<%@ page import="java.util.List" %>
<%
    ExamPaper exam = (ExamPaper) session.getAttribute("exam"); // ✅ Access from session
    List<String[]> questions = (List<String[]>) session.getAttribute("questions");

    String qTitle = "", qA = "", qB = "", qC = "", qD = "", correct = "", qNum = "";

    // 👉 Default to question 1 if no param
    String selectedQuestionNumber = request.getParameter("questionNumber");
    if (selectedQuestionNumber == null) {
        selectedQuestionNumber = "1";
        System.out.println("[JSP] No questionNumber passed, defaulting to 1");
    } else {
        System.out.println("[JSP] Selected questionNumber: " + selectedQuestionNumber);
    }

    if (selectedQuestionNumber != null && questions != null) {
        for (String[] q : questions) {
            if (q.length >= 12 && q[10].equals(selectedQuestionNumber)) {  // ✅ index 10 is question number
                qTitle = q[5];
                qA = q[6];
                qB = q[7];
                qC = q[8];
                qD = q[9];
                correct = q[11];  // ✅ correct answer
                qNum = q[10];
                break;
            }
        }
    }

    System.out.println("[JSP] Total questions loaded: " + (questions != null ? questions.size() : 0));

%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Online Examination System</title>
    <link rel="stylesheet" href="css/Dashboard.css" />
    <link rel="stylesheet" href="css/addExamPaper.css">
    <link rel="stylesheet" href="css/editExamPaper.css">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<!-- Sidebar -->
<aside class="sidebar" id="sidebar">
    <h2><i class="fa fa-graduation-cap" style="margin-right: 10px;"></i>Edu Smart</h2>
    <ul class="nav">

        <a href="Exmindex.jsp" style="text-decoration: none; color: #ffffff">
            <li  style="cursor: pointer;">
                <i class="fa fa-home"></i> Dashboard
            </li>
        </a>

        <a href="ExmaddExam.jsp" style="text-decoration: none; color: #ffffff">
            <li   style="cursor: pointer;">
                <i class="fa fa-file-alt"></i> Exam Paper
            </li>
        </a>
        <li><i class="fa fa-sign-out"></i> Logout</li>
    </ul>
</aside>

<!-- Main Content -->
<div class="main">
    <div class="topbar">
        <div class="menu-search">
            <i class="ri-menu-line icon" id="sidebarToggle"></i>
            <input type="text" class="search-bar" placeholder="Search" />
        </div>
        <div class="profile-area">
            <i class="ri-notification-line icon"></i>
            <img src="/pictures/profile.png" class="profile-pic" />
        </div>
    </div>

    <div class="admin-settings-container">
        <h3>Edit Exam Paper</h3>

        <div class="admin-form-card">

            <!-- Question Selector Buttons -->
            <div class="section">
                <h4>Question Settings</h4>
                <form action="ExmeditExam.jsp" method="get">
                    <input type="hidden" name="examCode" value="<%= exam != null ? exam.getCode() : "" %>">
                    <div class="question-format">
                        <%
                            int totalQuestions = questions != null ? questions.size() : 0;
                            for (int i = 1; i <= totalQuestions; i++) {
                        %>
                        <button class="save-btn" type="submit" name="questionNumber" value="<%= i %>"><%= i %></button>
                        <%
                            }
                        %>

                    </div>
                </form>
            </div>

            <!-- Question Edit Form -->
            <form action="UpdateExamQuestion" method="post">
                <!-- Basic Information -->
                <div class="section">
                    <h4>Basic Information</h4>
                    <div class="form-grid">
                        <input type="text" name="examTitle" value="<%= exam != null ? exam.getTitle() : "" %>" required>
                        <input type="text" name="faculty" value="<%= exam != null ? exam.getFaculty() : "" %>" required>
                    </div>
                    <div class="form-grid">
                        <input type="text" name="moduleCode" value="<%= exam != null ? exam.getCode() : "" %>" required>
                        <input type="text" name="duration" value="<%= exam != null ? exam.getDuration() : "" %>" required>
                        <input type="text" name="numberQuestions" value="<%= exam != null ? exam.getTotalQuestions() : "" %>" required>
                    </div>
                </div>

                <!-- Question Details -->
                <div class="section">
                    <input type="hidden" name="questionNumber" value="<%= qNum %>">
                    <input type="text" name="questionTitle" placeholder="Question Title" value="<%= qTitle %>" required readonly>
                    <div class="form-grid">
                        <input type="text" name="optionA" placeholder="Option A" value="<%= qA %>" required readonly>
                        <input type="text" name="optionB" placeholder="Option B" value="<%= qB %>" required readonly>
                    </div>
                    <div class="form-grid">
                        <input type="text" name="optionC" placeholder="Option C" value="<%= qC %>" required readonly>
                        <input type="text" name="optionD" placeholder="Option D" value="<%= qD %>" required readonly>
                    </div>
                    <input type="text" name="correctAnswer" placeholder="Correct Answer" value="<%= correct %>" required readonly>
                </div>

                <div class="setup btn">
                    <button type="button" class="save-btn" onclick="enableEditing()">Edit</button>
                    <button class="save-btn">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- SweetAlert script -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    function enableEditing() {
        const fields = document.querySelectorAll('input:not([type="hidden"])');
        fields.forEach(input => input.removeAttribute('readonly'));
        console.log("Editing enabled");
    }
</script>

<script>
    console.log("Loaded ExmeditExam.jsp with question <%= selectedQuestionNumber %>");
</script>

<%
    String status = request.getParameter("status");
    if ("success".equals(status)) {
%>
<script>
    Swal.fire({
        title: 'Success!',
        text: 'Question added successfully.',
        icon: 'success',
        confirmButtonColor: '#6c63ff'
    });
    console.log("Loaded question <%= qNum %>: <%= qTitle %>");
</script>
<% } %>




</body>
</html>
