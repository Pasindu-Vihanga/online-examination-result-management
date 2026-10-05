package com.jsp.exam.action;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import com.jsp.exam.model.Student;
import com.jsp.exam.service.Studentservice;

@WebServlet("/login")
public class UserLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final Studentservice studentservice = new Studentservice();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String inputUsername = request.getParameter("username");
        String inputPassword = request.getParameter("password");

        if (inputUsername == null || inputPassword == null || inputUsername.trim().isEmpty() || inputPassword.trim().isEmpty()) {
            response.sendRedirect("login.jsp?error=empty");
            return;
        }

        inputUsername = inputUsername.trim();
        inputPassword = inputPassword.trim();

        Student matchedStudent = null;
        for (Student student : studentservice.readStudents()) {
            if (student.getStudent_name().equalsIgnoreCase(inputUsername) && student.getStudent_password().equals(inputPassword)) {
                matchedStudent = student;
                break;
            }
        }

        if (matchedStudent != null) {
            HttpSession session = request.getSession();
            session.setAttribute("username", matchedStudent.getStudent_name());
            session.setAttribute("loggedUserName", matchedStudent.getStudent_name());
            session.setAttribute("loggedUserEmail", matchedStudent.getStudent_email());
            session.setAttribute("studentId", matchedStudent.getStudent_name());

            response.sendRedirect("dashboard.jsp");
        } else {
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}
