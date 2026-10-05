<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Examination & Result Management System</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Custom Modern Theme -->
    <link href="css/modern-theme.css" rel="stylesheet">
</head>
<body class="bg-mesh">

<!-- Sticky Glass Navbar -->
<nav class="navbar navbar-expand-lg navbar-modern sticky-top">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">
            <div class="brand-icon-box">
                <i class="bi bi-mortarboard-fill"></i>
            </div>
            <span>ExamHub<span style="color: var(--primary);">.io</span></span>
        </a>
        <button class="navbar-toggler border-0 shadow-none" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
            <i class="bi bi-list fs-2 text-dark"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarMain">
            <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link active" href="index.jsp"><i class="bi bi-house-door me-1"></i>Home</a></li>
                <li class="nav-item"><a class="nav-link" href="examPortal.jsp"><i class="bi bi-pencil-square me-1"></i>Exam Portal</a></li>
                <li class="nav-item"><a class="nav-link" href="results.jsp"><i class="bi bi-award me-1"></i>Check Results</a></li>
                <li class="nav-item"><a class="nav-link" href="feedback.jsp"><i class="bi bi-chat-heart me-1"></i>Feedback</a></li>
            </ul>
            <div class="d-flex align-items-center gap-2">
                <a href="adminlogin.jsp" class="btn btn-modern-secondary btn-sm">
                    <i class="bi bi-shield-lock me-1"></i>Admin Portal
                </a>
                <a href="login.jsp" class="btn btn-modern-primary btn-sm">
                    <i class="bi bi-box-arrow-in-right me-1"></i>Student Login
                </a>
            </div>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<header class="hero-wrapper text-center animate-fade-in">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-9">
                <div class="badge-pill-soft">
                    <i class="bi bi-stars"></i> Next-Gen Examination Engine v2.0
                </div>
                <h1 class="hero-title">
                    Intelligent & Secure <br>
                    <span class="gradient-text">Online Examination</span> Platform
                </h1>
                <p class="hero-desc mx-auto">
                    Experience seamless digital assessments with real-time countdown tracking, automated grading, and instant performance feedback backed by enterprise-grade persistence.
                </p>
                <div class="d-flex flex-wrap justify-content-center gap-3">
                    <a href="login.jsp" class="btn btn-modern-primary px-4 py-3">
                        <i class="bi bi-person-badge fs-5"></i> Enter Student Portal
                    </a>
                    <a href="results.jsp" class="btn btn-modern-secondary px-4 py-3">
                        <i class="bi bi-search fs-5"></i> View Exam Results
                    </a>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- Quick Stats Bar -->
<section class="py-4">
    <div class="container">
        <div class="row g-3">
            <div class="col-md-3 col-6">
                <div class="stat-widget">
                    <div>
                        <div class="stat-title">System Status</div>
                        <div class="stat-val text-success" style="font-size: 1.35rem;">Online & Active</div>
                    </div>
                    <div class="stat-icon-box icon-emerald">
                        <i class="bi bi-hdd-rack"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="stat-widget">
                    <div>
                        <div class="stat-title">Database Storage</div>
                        <div class="stat-val" style="font-size: 1.35rem;">MySQL 8.0</div>
                    </div>
                    <div class="stat-icon-box icon-cyan">
                        <i class="bi bi-database-check"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="stat-widget">
                    <div>
                        <div class="stat-title">Result Accuracy</div>
                        <div class="stat-val text-primary" style="font-size: 1.35rem;">100% Automated</div>
                    </div>
                    <div class="stat-icon-box icon-purple">
                        <i class="bi bi-lightning-charge"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="stat-widget">
                    <div>
                        <div class="stat-title">Role Security</div>
                        <div class="stat-val text-warning" style="font-size: 1.35rem;">RBAC Protected</div>
                    </div>
                    <div class="stat-icon-box icon-amber">
                        <i class="bi bi-shield-check"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Features Grid -->
<section class="py-5">
    <div class="container">
        <div class="text-center mb-5">
            <h6 class="text-uppercase fw-bold text-primary mb-2" style="letter-spacing: 0.08em;">Core Architecture</h6>
            <h2 class="fw-bold" style="letter-spacing: -0.02em;">Engineered for High-Stakes Assessments</h2>
            <p class="text-muted mx-auto" style="max-width: 580px;">Everything educators and students require for smooth test administration from question authoring to score publication.</p>
        </div>

        <div class="row g-4">
            <div class="col-md-4">
                <div class="feature-card">
                    <div class="feature-icon-wrapper icon-purple">
                        <i class="bi bi-clock-history"></i>
                    </div>
                    <h5 class="fw-bold mb-2">Automated Time Synchronizer</h5>
                    <p class="text-muted mb-0">Built-in active session timer with persistence across unexpected browser refreshes, guaranteeing fair testing constraints.</p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="feature-card">
                    <div class="feature-icon-wrapper icon-cyan">
                        <i class="bi bi-check2-circle"></i>
                    </div>
                    <h5 class="fw-bold mb-2">Instant Grade Generation</h5>
                    <p class="text-muted mb-0">Calculates candidate marks against verified answer keys the instant submission triggers, eliminating manual evaluation delays.</p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="feature-card">
                    <div class="feature-icon-wrapper icon-emerald">
                        <i class="bi bi-sliders"></i>
                    </div>
                    <h5 class="fw-bold mb-2">Comprehensive Admin Suite</h5>
                    <p class="text-muted mb-0">Full control over question banks, subject durations, student credentials, and real-time audit logs of administrative actions.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Call to Action Banner -->
<section class="py-5">
    <div class="container">
        <div class="p-5 rounded-4 text-white text-center position-relative overflow-hidden" 
             style="background: linear-gradient(135deg, #1e1b4b 0%, #312e81 50%, #4338ca 100%); box-shadow: var(--shadow-xl);">
            <div class="position-relative" style="z-index: 2;">
                <h2 class="fw-bold mb-3">Ready to begin your test?</h2>
                <p class="lead mb-4 opacity-75 mx-auto" style="max-width: 600px;">
                    Ensure you have your Student Index Number and selected exam code ready before opening the test portal.
                </p>
                <div class="d-flex flex-wrap justify-content-center gap-3">
                    <a href="examPortal.jsp" class="btn btn-modern-primary px-4 py-2">
                        <i class="bi bi-play-circle-fill me-1"></i> Start Exam Now
                    </a>
                    <a href="feedback.jsp" class="btn btn-modern-secondary px-4 py-2">
                        <i class="bi bi-chat-text me-1"></i> Send Feedback
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="footer-modern mt-5">
    <div class="container text-center">
        <div class="d-flex align-items-center justify-content-center gap-2 mb-3">
            <div class="brand-icon-box" style="width: 30px; height: 30px; font-size: 0.9rem;">
                <i class="bi bi-mortarboard-fill"></i>
            </div>
            <span class="fw-bold text-dark">Online Examination & Result Management System</span>
        </div>
        <p class="text-muted small mb-2">&copy; 2026 Pasindu Vihanga. All Rights Reserved.</p>
        <div class="d-flex justify-content-center gap-3 small">
            <a href="index.jsp" class="text-decoration-none text-muted">Home</a>
            <a href="examPortal.jsp" class="text-decoration-none text-muted">Exam Portal</a>
            <a href="results.jsp" class="text-decoration-none text-muted">Results</a>
            <a href="adminlogin.jsp" class="text-decoration-none text-muted">Admin Access</a>
        </div>
    </div>
</footer>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
