<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administrator Portal - Secure Sign In</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Custom Theme -->
    <link href="css/modern-theme.css" rel="stylesheet">
    <style>
        body {
            background-color: #0b0f19;
            background-image: 
                radial-gradient(at 0% 0%, rgba(79, 70, 229, 0.15) 0px, transparent 50%),
                radial-gradient(at 100% 100%, rgba(6, 182, 212, 0.1) 0px, transparent 50%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: #f1f5f9;
        }
        .admin-card {
            background: #111827;
            border: 1px solid #1f2937;
            border-radius: 20px;
            box-shadow: 0 20px 40px -15px rgba(0, 0, 0, 0.5);
            max-width: 440px;
            width: 100%;
            padding: 2.5rem;
        }
        .admin-input {
            background-color: #1f2937 !important;
            border-color: #374151 !important;
            color: #f9fafb !important;
        }
        .admin-input:focus {
            border-color: #6366f1 !important;
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.25) !important;
        }
        .admin-input::placeholder {
            color: #6b7280;
        }
    </style>
</head>
<body>

<!-- Minimal Header -->
<nav class="navbar py-3">
    <div class="container">
        <a class="navbar-brand text-white fw-bold d-flex align-items-center gap-2" href="index.jsp">
            <div class="brand-icon-box" style="background: linear-gradient(135deg, #4f46e5 0%, #06b6d4 100%);">
                <i class="bi bi-shield-lock-fill"></i>
            </div>
            <span>AdminConsole</span>
        </a>
        <a href="index.jsp" class="btn btn-outline-light btn-sm rounded-pill px-3">
            <i class="bi bi-arrow-left me-1"></i> Public Portal
        </a>
    </div>
</nav>

<div class="container d-flex align-items-center justify-content-center flex-grow-1 my-4">
    <div class="admin-card animate-fade-in">
        <div class="text-center mb-4">
            <div class="d-inline-flex p-3 rounded-circle mb-3" style="background: rgba(99, 102, 241, 0.15); color: #818cf8;">
                <i class="bi bi-fingerprint fs-1"></i>
            </div>
            <h3 class="fw-bold text-white mb-1">Administrative Access</h3>
            <p class="text-muted small">Enter your authorized credentials to manage the platform</p>
        </div>

        <%-- Alerts --%>
        <% if ("success".equals(request.getParameter("registered"))) { %>
        <div class="alert alert-success alert-dismissible fade show d-flex align-items-center gap-2 py-2" role="alert">
            <i class="bi bi-check-circle-fill fs-5"></i>
            <div class="small">Admin account created! Please sign in below.</div>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } %>

        <% if ("invalid".equals(request.getParameter("error"))) { %>
        <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center gap-2 py-2" role="alert">
            <i class="bi bi-exclamation-triangle-fill fs-5"></i>
            <div class="small">Invalid administrative username or password.</div>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } else if ("empty".equals(request.getParameter("error"))) { %>
        <div class="alert alert-warning alert-dismissible fade show d-flex align-items-center gap-2 py-2" role="alert">
            <i class="bi bi-exclamation-circle-fill fs-5"></i>
            <div class="small">Please provide both administrative credentials.</div>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } %>

        <form action="memberslogin" method="POST" class="mt-3">
            <div class="mb-3">
                <label for="username" class="form-label small fw-semibold text-light mb-1">Admin Username</label>
                <div class="input-icon-group">
                    <i class="bi bi-person input-icon text-muted"></i>
                    <input type="text" class="form-control form-control-modern admin-input" id="username" name="username" 
                           placeholder="Enter admin username" required autocomplete="username">
                </div>
            </div>

            <div class="mb-4">
                <label for="password" class="form-label small fw-semibold text-light mb-1">Admin Password</label>
                <div class="input-icon-group">
                    <i class="bi bi-lock input-icon text-muted"></i>
                    <input type="password" class="form-control form-control-modern admin-input" id="password" name="password" 
                           placeholder="Enter password" required autocomplete="current-password">
                    <button type="button" class="password-toggle text-muted" id="togglePasswordBtn" title="Toggle password visibility">
                        <i class="bi bi-eye" id="toggleIcon"></i>
                    </button>
                </div>
            </div>

            <button type="submit" class="btn btn-modern-primary w-100 py-2 justify-content-center">
                <i class="bi bi-shield-check"></i> Authenticate & Proceed
            </button>
        </form>

        <div class="mt-4 pt-3 border-top border-secondary border-opacity-25 text-center">
            <p class="text-muted small mb-2">Need a new admin account? <a href="adminreg.jsp" class="text-primary text-decoration-none fw-semibold">Register New Admin</a></p>
            <p class="text-muted small mb-0">Taking a test? <a href="login.jsp" class="text-light text-decoration-none opacity-75">Student Login</a></p>
        </div>
    </div>
</div>

<footer class="text-center py-3 text-muted small border-top border-secondary border-opacity-10">
    &copy; 2026 Online Examination Management System &bull; Secure Administrative Console
</footer>

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
