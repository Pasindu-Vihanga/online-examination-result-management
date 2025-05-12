<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, java.util.LinkedHashSet" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Online Exam Portal</title>

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <style>
    body {
      background: #eef2f7;
      font-family: 'Segoe UI', sans-serif;
    }
    .container {
      max-width: 900px;
      margin-top: 50px;
    }
    .exam-form, .question-container {
      background-color: #fff;
      border-radius: 10px;
      padding: 25px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.05);
      margin-bottom: 20px;
    }
    .timer {
      font-size: 1.2rem;
      font-weight: bold;
      color: #dc3545;
      text-align: center;
      display: none;
    }
    .submit-btn {
      display: none;
    }
    .question-container p {
      font-weight: 500;
    }
    .form-check {
      margin-left: 15px;
    }
  </style>
</head>
<body>

<div class="container">
  <h2 class="text-center mb-4">Online Exam Portal</h2>

  <form method="GET" action="examPortal.jsp" onsubmit="resetExamSession()" class="exam-form">
    <%
      String studentId = (String) session.getAttribute("studentId");
      if (studentId == null) {
        studentId = request.getParameter("studentId");
        if (studentId != null) {
          session.setAttribute("studentId", studentId);
        }
      }

      String examCode = (String) session.getAttribute("examCode");
      if (request.getParameter("examCode") != null) {
        examCode = request.getParameter("examCode");
        session.setAttribute("examCode", examCode);
      }

      String filePath = "D:/IP/proj/Online-Exam-System/src/main/webapp/Questions/questions.txt";
      LinkedHashSet<String> examCodes = new LinkedHashSet<>();

      File file = new File(filePath);
      if (file.exists()) {
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
          String line;
          while ((line = reader.readLine()) != null) {
            String[] parts = line.split("\\|");
            if (parts.length >= 12) {
              examCodes.add(parts[2]);
            }
          }
        } catch (IOException e) {
          out.println("<p class='text-danger'>Error loading subjects: " + e.getMessage() + "</p>");
        }
      }
    %>

    <div class="mb-3">
      <label for="studentId" class="form-label">Student ID</label>
      <input type="text" class="form-control" name="studentId" value="<%= studentId != null ? studentId : "" %>" required>
    </div>

    <div class="mb-3">
      <label for="examCode" class="form-label">Select Exam</label>
      <select class="form-select" name="examCode" onchange="this.form.submit()" required>
        <option value="">-- Select Subject --</option>
        <% for (String code : examCodes) { %>
        <option value="<%= code %>" <%= (examCode != null && examCode.equals(code)) ? "selected" : "" %>><%= code %></option>
        <% } %>
      </select>
    </div>
  </form>

  <%
    List<String[]> questionList = new ArrayList<>();
    int remainingTime = 0;

    if (examCode != null && !examCode.isEmpty()) {
      if (file.exists()) {
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
          String line;
          while ((line = reader.readLine()) != null) {
            String[] parts = line.split("\\|");
            if (parts.length >= 12 && parts[2].equals(examCode)) {
              questionList.add(parts);
              remainingTime = Integer.parseInt(parts[3]);
            }
          }
        } catch (IOException e) {
          out.println("<p class='text-danger'>Error loading questions: " + e.getMessage() + "</p>");
        }
      }
    }
  %>

  <% if (remainingTime > 0) { %>
  <div class="d-grid">
    <button class="btn btn-primary mt-3" onclick="startExam()">Start Exam</button>
  </div>
  <div class="timer mt-2">Remaining Time: <span id="countdown"><%= remainingTime %></span> minutes</div>
  <% } %>

  <%
    if (!questionList.isEmpty()) {
  %>
  <form action="ExamAttendanceServlet" method="POST">
    <input type="hidden" name="action" value="submitAll">
    <input type="hidden" name="studentId" value="<%= studentId %>">
    <input type="hidden" name="examCode" value="<%= examCode %>">

    <%
      for (String[] question : questionList) {
    %>
    <div class="question-container">
      <p><strong>Q<%= question[10] %>:</strong> <%= question[5] %></p>
      <input type="hidden" name="questionNumber" value="<%= question[10] %>">
      <div class="form-check">
        <input type="radio" class="form-check-input" name="answer_<%= question[10] %>" value="A" id="q<%= question[10] %>a">
        <label class="form-check-label" for="q<%= question[10] %>a"><%= question[6] %></label>
      </div>
      <div class="form-check">
        <input type="radio" class="form-check-input" name="answer_<%= question[10] %>" value="B" id="q<%= question[10] %>b">
        <label class="form-check-label" for="q<%= question[10] %>b"><%= question[7] %></label>
      </div>
      <div class="form-check">
        <input type="radio" class="form-check-input" name="answer_<%= question[10] %>" value="C" id="q<%= question[10] %>c">
        <label class="form-check-label" for="q<%= question[10] %>c"><%= question[8] %></label>
      </div>
      <div class="form-check">
        <input type="radio" class="form-check-input" name="answer_<%= question[10] %>" value="D" id="q<%= question[10] %>d">
        <label class="form-check-label" for="q<%= question[10] %>d"><%= question[9] %></label>
      </div>
    </div>
    <%
      }
    %>
    <div class="d-grid">
      <button type="submit" class="btn btn-success mt-3 submit-btn">Submit All Answers</button>
    </div>
  </form>
  <%
    } else if (examCode != null) {
      out.println("<p class='alert alert-warning'>No questions found for the selected exam.</p>");
    }
  %>
</div>

<script>
  function resetExamSession() {
    sessionStorage.removeItem("timeLeft");
  }

  function startExam() {
    document.querySelector(".timer").style.display = "block";
    document.querySelectorAll(".question-container").forEach(q => q.style.display = "block");
    document.querySelector(".submit-btn").style.display = "block";
    updateTimer();
  }

  let timeLeft = sessionStorage.getItem("timeLeft") ? sessionStorage.getItem("timeLeft") : <%= remainingTime * 60 %>;

  function updateTimer() {
    let minutes = Math.floor(timeLeft / 60);
    let seconds = timeLeft % 60;
    document.getElementById("countdown").innerText = minutes + ":" + (seconds < 10 ? "0" + seconds : seconds);

    if (timeLeft > 0) {
      timeLeft--;
      sessionStorage.setItem("timeLeft", timeLeft);
      setTimeout(updateTimer, 1000);
    } else {
      alert("Time's up! Submitting your answers...");
      document.forms[0].submit();
    }
  }
</script>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
