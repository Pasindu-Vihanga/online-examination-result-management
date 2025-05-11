<%@ page import="java.util.*, com.jsp.exam.model.ExamPaper, com.jsp.exam.service.Examservice" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Online Examination System</title>
    <link rel="stylesheet" href="css/Dashboard.css">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<aside class="sidebar" id="sidebar">
    <h2><i class="fa fa-graduation-cap" style="margin-right: 10px;"></i>Edu Smart</h2>
    <ul class="nav">
        <a href="Exmindex.jsp" style="text-decoration: none; color: #ffffff">
            <li style="cursor: pointer;"><i class="fa fa-home"></i> Dashboard</li>
        </a>
        <a href="ExmaddExam.jsp" style="text-decoration: none; color: #ffffff">
            <li style="cursor: pointer;"><i class="fa fa-file-alt"></i> Exam Paper</li>
        </a>
        <li>
            <i class="fa fa-sign-out"></i>
            <a class="nav-link text-danger" href="admindashboard.jsp" style="text-decoration: none; color: #ffffff;">Logout</a>
        </li>

    </ul>
</aside>

<div class="main">
    <div class="topbar">
        <div class="menu-search">
            <i class="ri-menu-line icon" id="sidebarToggle"></i>
            <input type="text" class="search-bar" placeholder="Search" />
        </div>
        <div class="profile-area">
            <i class="ri-notification-line icon"></i>
            <img src="pictures/profile.png" class="profile-pic" />
        </div>
    </div>

    <div class="dashboard-header">
        <div class="section-header">
            <h2>Dashboard</h2>
            <p class="section-subtext">Overview of your exam, students, and other resources</p>
        </div>

        <div class="summary-cards">
            <div class="card">
                <div class="icon-wrapper"><i class="ri-group-line icon blue-bg"></i></div>
                <div class="card-title">Students at exams</div>
                <div class="card-value">432</div>
            </div>
            <div class="card">
                <div class="icon-wrapper"><i class="ri-flag-line icon blue-bg"></i></div>
                <div class="card-title">Exam Finishes</div>
                <div class="card-value">12</div>
            </div>
            <div class="card">
                <div class="icon-wrapper"><i class="ri-play-circle-line icon blue-bg"></i></div>
                <div class="card-title">Running Exam</div>
                <div class="card-value">10</div>
            </div>
            <div class="card">
                <div class="icon-wrapper"><i class="ri-check-double-line icon blue-bg"></i></div>
                <div class="card-title">Completed Rate</div>
                <div class="card-value">86%</div>
            </div>
        </div>
    </div>

    <div class="projects-table">
        <div class="section-header">
            <h3>Exam Papers</h3>
            <form action="addExamPaper" method="get" style="margin: 0;">
                <button type="submit" class="create-admin-btn"> Add Exam Paper</button>
            </form>
        </div>

        <div class="row-card">
            <table class="projects">
                <thead>
                <tr>
                    <th>Exam Title</th>
                    <th>Duration</th>
                    <th>Faculty</th>
                    <th>Code</th>
                    <th>No. Questions</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <%
                    Examservice examService = new Examservice();
                    List<String[]> allQuestions = examService.getExamQuestions(null); // null => all exams
                    Map<String, ExamPaper> uniqueExams = new HashMap<>();

                    for (String[] parts : allQuestions) {
                        if (parts.length >= 12) {
                            String code = parts[2];
                            if (!uniqueExams.containsKey(code)) {
                                ExamPaper paper = new ExamPaper(parts[0], parts[1], parts[2], parts[3], parts[4]);
                                uniqueExams.put(code, paper);
                            }
                        }
                    }

                    for (ExamPaper exam : uniqueExams.values()) {
                %>
                <tr>
                    <td><i class="fa fa-file-alt"></i> <%= exam.getTitle() %></td>
                    <td><%= exam.getDuration() %></td>
                    <td><%= exam.getFaculty() %></td>
                    <td><%= exam.getCode() %></td>
                    <td><%= exam.getTotalQuestions() %></td>
                    <td>
                        <form action="EditExamNavi" method="get" style="display:inline;">
                            <input type="hidden" name="examCode" value="<%= exam.getCode() %>">
                            <button class="action-btn edit">Edit</button>
                        </form>
                        <form id="deleteForm_<%= exam.getCode() %>" action="DeleteExam" method="post" style="display:inline;">
                            <input type="hidden" name="examCode" value="<%= exam.getCode() %>">
                            <button type="button" class="delete-btn" onclick="confirmDelete('<%= exam.getCode() %>')">Delete</button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>

        <div class="view-link">
            <a href="#">View All Exam Papers</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    function confirmDelete(examCode) {
        Swal.fire({
            title: 'Are you sure?',
            text: "This will permanently delete the exam and all its questions.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById('deleteForm_' + examCode).submit();
            }
        });
    }
</script>

</body>
</html>
