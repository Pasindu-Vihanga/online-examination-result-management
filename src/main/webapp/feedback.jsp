<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.jsp.exam.model.feedbackmodel, com.jsp.exam.service.feedbackservice" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Feedback</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white text-center">
            <h4>Submit Feedback</h4>
        </div>
        <div class="card-body">
            <form action="feedbackS" method="post" class="needs-validation">
                <div class="input-group mb-2">
                    <span class="input-group-text">👤</span>
                    <input type="text" name="name" class="form-control" placeholder="Your Name" required>
                </div>
                <div class="input-group mb-2">
                    <span class="input-group-text">📧</span>
                    <input type="email" name="email" class="form-control" placeholder="Your Email" required>
                </div>
                <div class="mb-2">
                    <textarea name="message" class="form-control" placeholder="Your Message" rows="3" required></textarea>
                </div>
                <button type="submit" class="btn btn-success w-100">Send Feedback</button>
            </form>
        </div>
    </div>

    <!-- Compact Feedback List -->
    <div class="card mt-4 shadow-sm">
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
                <li class="list-group-item d-flex justify-content-between">
                    <div>
                        <strong><%= feedback.getName() %></strong>: <%= feedback.getMessage() %>
                    </div>
                    <form action="feedbackS" method="post">
                        <input type="hidden" name="name" value="<%= feedback.getName() %>">
                        <input type="hidden" name="action" value="delete">
                        <button type="submit" class="btn btn-danger btn-sm">🗑️</button>
                    </form>
                </li>
                <% } %>
            </ul>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
