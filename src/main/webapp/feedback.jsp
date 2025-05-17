<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List, com.jsp.exam.model.feedbackmodel, com.jsp.exam.service.feedbackservice" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Feedback</title>
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
        .feedback-form, .recent-feedback .card {
            background-color: #ffffff;
            transition: background-color 0.3s, color 0.3s;
        }
        .dark-mode .feedback-form,
        .dark-mode .recent-feedback .card {
            background-color: #1e1e1e;
            color: #ffffff;
        }
        .feedback-form {
            max-width: 500px;
            margin: 60px auto;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        }
        .form-header {
            font-size: 1.5rem;
            font-weight: bold;
            text-align: center;
            margin-bottom: 25px;
        }
        .btn-submit {
            width: 100%;
        }
        .top-controls {
            position: absolute;
            top: 20px;
            right: 20px;
            display: flex;
            gap: 10px;
        }
        .recent-feedback {
            max-width: 600px;
            margin: 30px auto;
        }
    </style>
</head>
<body>
<div class="top-controls">
    <button id="themeToggle" class="btn btn-outline-dark">🌙 Dark Mode</button>
</div>

<div class="feedback-form">
    <div class="form-header">Feedback Form</div>
    <form action="feedbackS" method="post">
        <div class="mb-3">
            <label for="name" class="form-label">Name:</label>
            <input type="text" name="name" class="form-control" id="name" required>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email:</label>
            <input type="email" name="email" class="form-control" id="email" required>
        </div>
        <div class="mb-3">
            <label for="message" class="form-label">Comment:</label>
            <textarea name="message" class="form-control" id="message" rows="3" required></textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">Rating:</label><br>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="rating" value="Good" required>
                <label class="form-check-label">Good</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="rating" value="Bad">
                <label class="form-check-label">Bad</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="rating" value="Excellent">
                <label class="form-check-label">Excellent</label>
            </div>
        </div>
        <button type="submit" class="btn btn-success btn-submit">Submit</button>
    </form>
</div>

<!-- Recent Feedback Section (without delete option) -->
<div class="recent-feedback">
    <div class="card shadow-sm">
        <div class="card-header bg-success text-white text-center">
            <h5>Recent Feedback</h5>
        </div>
        <div class="card-body">
            <ul class="list-group list-group-flush">
                <%
                    feedbackservice feedbackService = new feedbackservice();
                    List<feedbackmodel> feedbackList = feedbackService.readFeedback();
                    for (feedbackmodel feedback : feedbackList) {
                %>
                <li class="list-group-item">
                    <strong><%= feedback.getName() %></strong>: <%= feedback.getMessage() %>
                </li>
                <% } %>
            </ul>
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
