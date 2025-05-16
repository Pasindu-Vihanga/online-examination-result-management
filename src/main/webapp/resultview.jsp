<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map, com.jsp.exam.service.ExamResultService" %>
<%
    String studentId = request.getParameter("studentId");
    String examCode = request.getParameter("examCode");
    ExamResultService examService = new ExamResultService();

    Map<String, Boolean> results = examService.evaluateStudentAnswers(studentId, examCode);
    int score = examService.calculateScore(studentId, examCode);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Exam Results</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center">Exam Results for <%= studentId %> - <%= examCode %></h2>
    <h4 class="text-center text-success">Final Score: <%= score %></h4>

    <form action="ViewAnswersServlet" method="post">
        <input type="hidden" name="studentId" value="<%= studentId %>">
        <input type="hidden" name="examCode" value="<%= examCode %>">
        <button type="submit" class="btn btn-primary d-block mx-auto">Save Result</button>
    </form>

    <% if (!results.isEmpty()) { %>
    <table class="table table-bordered mt-3">
        <thead>
        <tr>
            <th>Question Number</th>
            <th>Correct</th>
        </tr>
        </thead>
        <tbody>
        <% for (Map.Entry<String, Boolean> entry : results.entrySet()) { %>
        <tr>
            <td><%= entry.getKey() %></td>
            <td class="<%= entry.getValue() ? "text-success" : "text-danger" %>"><%= entry.getValue() ? "✔" : "✘" %></td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <% } else { %>
    <p class="alert alert-warning text-center mt-4">No answers found for this exam.</p>
    <% } %>
</div>
</body>
</html>
