<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.jsp.exam.model.feedbackmodel, com.jsp.exam.service.feedbackservice" %>
<%
    String loggedUser = (String) session.getAttribute("loggedUserName");
    String loggedEmail = (String) session.getAttribute("loggedUserEmail");

    feedbackservice feedbackService = new feedbackservice();
    List<feedbackmodel> feedbackList = feedbackService.readFeedback();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Candidate Feedback & System Reviews - ExamHub</title>
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
            <a href="index.jsp" class="btn btn-modern-secondary btn-sm">
                <i class="bi bi-house me-1"></i> Home
            </a>
            <a href="dashboard.jsp" class="btn btn-modern-secondary btn-sm">
                <i class="bi bi-speedometer2 me-1"></i> Dashboard
            </a>
        </div>
    </div>
</nav>

<div class="container my-4" style="max-width: 900px;">

    <div class="text-center mb-4">
        <h3 class="fw-bold mb-1">Candidate Feedback Portal</h3>
        <p class="text-muted small">Share your thoughts to help us enhance the examination platform</p>
    </div>

    <%-- Alerts --%>
    <% if ("true".equals(request.getParameter("submitted"))) { %>
    <div class="alert alert-success alert-dismissible fade show d-flex align-items-center gap-2 py-2 mb-4" role="alert">
        <i class="bi bi-check-circle-fill fs-5"></i>
        <div class="small">Thank you! Your feedback has been recorded in the system.</div>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } else if ("invalid".equals(request.getParameter("error"))) { %>
    <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center gap-2 py-2 mb-4" role="alert">
        <i class="bi bi-exclamation-triangle-fill fs-5"></i>
        <div class="small">Please fill in all feedback fields before submitting.</div>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <div class="row g-4">
        <!-- Form Column -->
        <div class="col-lg-6">
            <div class="modern-card h-100">
                <h5 class="fw-bold mb-3 d-flex align-items-center gap-2">
                    <i class="bi bi-chat-heart text-primary"></i> Leave Your Review
                </h5>

                <form action="feedbackS" method="POST">
                    <div class="mb-3">
                        <label for="name" class="form-label-modern">Your Name</label>
                        <div class="input-icon-group">
                            <i class="bi bi-person input-icon"></i>
                            <input type="text" name="name" class="form-control form-control-modern" id="name" 
                                   value="<%= loggedUser != null ? loggedUser : "" %>" required placeholder="Enter full name">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label-modern">Email Address</label>
                        <div class="input-icon-group">
                            <i class="bi bi-envelope input-icon"></i>
                            <input type="email" name="email" class="form-control form-control-modern" id="email" 
                                   value="<%= loggedEmail != null ? loggedEmail : "" %>" required placeholder="Enter email address">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label-modern d-block">Experience Rating</label>
                        <div class="d-flex gap-2">
                            <div class="flex-fill">
                                <input type="radio" class="option-radio" name="rating" value="Excellent" id="rate_exc" checked>
                                <label class="option-label text-center py-2 px-1 mb-0" for="rate_exc">
                                    <i class="bi bi-star-fill text-warning d-block mb-1"></i>
                                    <span class="small fw-semibold">Excellent</span>
                                </label>
                            </div>
                            <div class="flex-fill">
                                <input type="radio" class="option-radio" name="rating" value="Good" id="rate_good">
                                <label class="option-label text-center py-2 px-1 mb-0" for="rate_good">
                                    <i class="bi bi-hand-thumbs-up-fill text-primary d-block mb-1"></i>
                                    <span class="small fw-semibold">Good</span>
                                </label>
                            </div>
                            <div class="flex-fill">
                                <input type="radio" class="option-radio" name="rating" value="Bad" id="rate_bad">
                                <label class="option-label text-center py-2 px-1 mb-0" for="rate_bad">
                                    <i class="bi bi-exclamation-circle text-danger d-block mb-1"></i>
                                    <span class="small fw-semibold">Improve</span>
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="message" class="form-label-modern">Comments & Suggestions</label>
                        <textarea name="message" class="form-control form-control-modern" id="message" rows="4" 
                                  required placeholder="Describe your exam experience, platform performance, or suggestions..."></textarea>
                    </div>

                    <button type="submit" class="btn btn-modern-primary w-100 py-2.5 justify-content-center">
                        <i class="bi bi-send-fill"></i> Submit Review
                    </button>
                </form>
            </div>
        </div>

        <!-- Recent Reviews Column -->
        <div class="col-lg-6">
            <div class="modern-card h-100">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold mb-0 d-flex align-items-center gap-2">
                        <i class="bi bi-chat-quote-fill text-primary"></i> Candidate Thoughts
                    </h5>
                    <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-2 py-1 rounded">
                        <%= feedbackList.size() %> Reviews
                    </span>
                </div>

                <div class="overflow-auto" style="max-height: 480px;">
                    <% if (!feedbackList.isEmpty()) { 
                        for (feedbackmodel fb : feedbackList) { 
                            String r = fb.getRating();
                            String badgeClass = "bg-primary-subtle text-primary border-primary-subtle";
                            if ("Excellent".equalsIgnoreCase(r)) badgeClass = "bg-success-subtle text-success border-success-subtle";
                            else if ("Bad".equalsIgnoreCase(r)) badgeClass = "bg-danger-subtle text-danger border-danger-subtle";
                    %>
                    <div class="p-3 mb-2 rounded-3 border bg-white shadow-sm">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <span class="fw-bold text-dark small"><%= fb.getName() %></span>
                            <span class="badge <%= badgeClass %> border px-2 py-0.5 rounded-pill small" style="font-size: 0.72rem;">
                                <%= r != null && !r.isEmpty() ? r : "Verified" %>
                            </span>
                        </div>
                        <p class="text-muted small mb-0"><%= fb.getMessage() %></p>
                    </div>
                    <% } } else { %>
                    <div class="text-center py-5 text-muted">
                        <i class="bi bi-chat-square-dots fs-1 d-block mb-2 text-dim"></i>
                        No feedbacks submitted yet. Be the first to share your thoughts!
                    </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
