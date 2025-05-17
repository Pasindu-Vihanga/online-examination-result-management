<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List, com.jsp.exam.model.feedbackmodel, com.jsp.exam.service.feedbackservice" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Feedback Records</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8fafc;
            transition: background-color 0.3s, color 0.3s;
        }
        .dark-mode {
            background-color: #121212;
            color: #ffffff;
        }
        .dark-mode .card,
        .dark-mode .table {
            background-color: #1e1e1e;
            color: #ffffff;
        }
        .top-controls {
            position: absolute;
            top: 20px;
            right: 20px;
            display: flex;
            gap: 10px;
        }
        .badge-good {
            background-color: #cce5ff;
            color: #004085;
        }
        .badge-bad {
            background-color: #f8d7da;
            color: #721c24;
        }
        .badge-excellent {
            background-color: #d4edda;
            color: #155724;
        }
        .table td, .table th {
            vertical-align: middle;
        }
    </style>
</head>
<body>

<div class="top-controls">
    <a href="feedback.jsp" class="btn btn-outline-secondary">Back to Form</a>
    <button id="themeToggle" class="btn btn-outline-dark">🌙 Dark Mode</button>
</div>

<div class="container mt-5">
    <h2 class="mb-4">Feedback Records</h2>
    <div class="card shadow-sm">
        <div class="card-body">
            <h5 class="card-title mb-3">All Submissions</h5>
            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle">
                    <thead class="table-light">
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Rating</th>
                        <th>Comment</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        feedbackservice feedbackService = new feedbackservice();
                        List<feedbackmodel> feedbackList = feedbackService.readFeedback();
                        for (feedbackmodel feedback : feedbackList) {
                            String badgeClass = "";
                            String rating = feedback.getRating().toLowerCase();
                            switch (rating) {
                                case "good": badgeClass = "badge-good"; break;
                                case "bad": badgeClass = "badge-bad"; break;
                                case "excellent": badgeClass = "badge-excellent"; break;
                                default: badgeClass = "bg-secondary text-white";
                            }
                    %>
                    <tr>
                        <td><%= feedback.getName() %></td>
                        <td><%= feedback.getEmail() %></td>
                        <td><span class="badge <%= badgeClass %> text-capitalize px-2 py-1"><%= feedback.getRating() %></span></td>
                        <td><%= feedback.getMessage() %></td>
                        <td>
                            <form action="feedbackS" method="post">
                                <input type="hidden" name="name" value="<%= feedback.getName() %>">
                                <input type="hidden" name="action" value="delete">
                                <button type="submit" class="btn btn-danger btn-sm">🗑️ Delete</button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    const toggleBtn = document.getElementById("themeToggle");
    toggleBtn.addEventListener("click", () => {
        document.body.classList.toggle("dark-mode");
        if (document.body.classList.contains("dark-mode")) {
            toggleBtn.textContent = "☀️ Light Mode";
            toggleBtn.classList.remove("btn-outline-dark");
            toggleBtn.classList.add("btn-outline-light");
        } else {
            toggleBtn.textContent = "🌙 Dark Mode";
            toggleBtn.classList.remove("btn-outline-light");
            toggleBtn.classList.add("btn-outline-dark");
        }
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
