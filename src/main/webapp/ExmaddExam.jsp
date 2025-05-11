<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Online Examination System</title>
  <link rel="stylesheet" href="css/Dashboard.css" />
  <link rel="stylesheet" href="css/addExamPaper.css">
  <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<!-- Sidebar -->
<aside class="sidebar" id="sidebar">
  <h2><i class="fa fa-graduation-cap" style="margin-right: 10px;"></i>Edu Smart</h2>


  <ul class="nav">
    <a href="Exmindex.jsp" style="text-decoration: none;">
      <li class="active" style="cursor: pointer;">
        <i class="fa fa-home"></i> Dashboard
      </li>
    </a>
    <li><i class="fa fa-file-alt"></i> Exam Paper</li>



    <li><i class="fa fa-sign-out"></i> Logout</li>
  </ul>
</aside>


<!-- Main Content -->
<div class="main">
  <div class="topbar">
    <div class="menu-search">
      <i class="ri-menu-line icon" id="sidebarToggle"></i>
      <input type="text" class="search-bar" placeholder="Search" />
    </div>
    <div class="profile-area">
      <i class="ri-notification-line icon"></i>
      <img src="/pictures/profile.png" class="profile-pic" />
    </div>
  </div>

  <!-- Admin Settings Section -->
  <div class="admin-settings-container">
    <h3>Create Exam Paper</h3>
    <div></div>
    <div class="admin-form-card">
      <form action="CreateExamQuestion" method="post" >


        <!-- Basic Information -->
        <div class="section">
          <h4>Basic Information</h4>
          <div class="form-grid">
            <input type="text" name="examTitle" placeholder="Exam Title" >
            <input type="text" name="faculty" placeholder="Faculty" >
          </div>

          <div class="form-grid">
            <input type="text" name="moduleCode" placeholder="Module Code" >
            <input type="text" name="duration" placeholder="Duration" >
            <input type="text" name="numberQuestions" placeholder="Number of Questions" >
          </div>

        </div>

        <div class="section">
          <h4>Question Settings</h4>

          <input type="text" name="questionTitle" placeholder="Question Title">


          <div class="form-grid">
            <input type="text" name="optionA" placeholder="option A" >
            <input type="text" name="optionB" placeholder="option B" >
          </div>
          <div class="form-grid">
            <input type="text" name="optionC" placeholder="Option C">
            <input type="text" name="optionD" placeholder="Option D">
          </div>
          <div class="form-grid">
            <input type="text" name="questionNumber" placeholder="Question Number">
            <input type="text" name="correctAnswer" placeholder="Correct Answer">
          </div>


        </div>




        <div class="setup btn">
          <button class="save-btn">Save</button>
          <button class="save-btn" type="button" onclick="location.href='Exmindex.jsp'">Finish</button>
        </div>


      </form>
    </div>
  </div>
</div>

<!-- SweetAlert script -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<%
  String status = request.getParameter("status");
  if ("success".equals(status)) {
%>
<script>
  Swal.fire({
    title: 'Success!',
    text: 'Question added successfully.',
    icon: 'success',
    confirmButtonColor: '#6c63ff'
  });
</script>
<% } %>

</body>
</html>
