<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Registration - Online Examination Portal</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Custom Theme -->
    <link href="css/modern-theme.css" rel="stylesheet">
</head>
<body class="bg-mesh">

<!-- Simple Topbar -->
<nav class="navbar navbar-expand-lg navbar-modern">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">
            <div class="brand-icon-box">
                <i class="bi bi-mortarboard-fill"></i>
            </div>
            <span>ExamHub<span style="color: var(--primary);">.io</span></span>
        </a>
        <div class="d-flex align-items-center gap-2">
            <a href="index.jsp" class="btn btn-modern-secondary btn-sm">
                <i class="bi bi-arrow-left me-1"></i> Back to Home
            </a>
        </div>
    </div>
</nav>

<div class="auth-wrapper">
    <div class="auth-card animate-fade-in">
        <div class="text-center mb-4">
            <div class="brand-icon-box mx-auto mb-3" style="width: 50px; height: 50px; font-size: 1.4rem;">
                <i class="bi bi-person-plus-fill"></i>
            </div>
            <h3 class="fw-bold text-dark mb-1">Create Student Account</h3>
            <p class="text-muted small">Register to participate in online evaluations</p>
        </div>

        <%-- Alerts --%>
        <% if ("failed".equals(request.getParameter("error"))) { %>
        <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center gap-2 py-2" role="alert">
            <i class="bi bi-exclamation-triangle-fill fs-5"></i>
            <div class="small">Registration failed. Username may already exist or inputs are invalid.</div>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } else if ("empty".equals(request.getParameter("error"))) { %>
        <div class="alert alert-warning alert-dismissible fade show d-flex align-items-center gap-2 py-2" role="alert">
            <i class="bi bi-exclamation-circle-fill fs-5"></i>
            <div class="small">Please fill in all registration fields.</div>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } %>

        <form action="register" method="POST" class="mt-3">
            <div class="mb-3">
                <label for="name" class="form-label-modern">Full Name / Student ID</label>
                <div class="input-icon-group">
                    <i class="bi bi-person input-icon"></i>
                    <input type="text" class="form-control form-control-modern" id="name" name="name" 
                           placeholder="e.g. John Doe or IT21004" required autocomplete="name">
                </div>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label-modern">Email Address</label>
                <div class="input-icon-group">
                    <i class="bi bi-envelope input-icon"></i>
                    <input type="email" class="form-control form-control-modern" id="email" name="email" 
                           placeholder="student@example.com" required autocomplete="email">
                </div>
            </div>

            <div class="mb-4">
                <label for="password" class="form-label-modern">Create Password</label>
                <div class="input-icon-group">
                    <i class="bi bi-key input-icon"></i>
                    <input type="password" class="form-control form-control-modern" id="password" name="password" 
                           placeholder="Create a secure password" required autocomplete="new-password">
                    <button type="button" class="password-toggle" id="togglePasswordBtn" title="Toggle password visibility">
                        <i class="bi bi-eye" id="toggleIcon"></i>
                    </button>
                </div>
            </div>

            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-modern-primary py-2 justify-content-center">
                    <i class="bi bi-check2-circle"></i> Complete Registration
                </button>
            </div>
        </form>

        <div class="mt-4 pt-3 border-top text-center">
            <p class="text-muted small mb-0">Already registered? <a href="login.jsp" class="fw-semibold text-primary text-decoration-none">Sign In Here</a></p>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const toggleBtn = document.getElementById('togglePasswordBtn');
    const passwordInput = document.getElementById('password');
    const toggleIcon = document.getElementById('toggleIcon');

    if (toggleBtn && passwordInput) {
        toggleBtn.addEventListener('click', () => {
            const isPassword = passwordInput.getAttribute('type') === 'password';
            passwordInput.setAttribute('type', isPassword ? 'text' : 'password');
            toggleIcon.className = isPassword ? 'bi bi-eye-slash' : 'bi bi-eye';
        });
    }
</script>
</body>
</html>
