 package com.jsp.exam.action;

import com.jsp.exam.model.StudentLog;
import com.jsp.exam.service.StudentMGservice;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

    @WebServlet("/student")
    public class StudentManageServlet extends HttpServlet {
        private StudentMGservice studentService = new StudentMGservice();

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String action = request.getParameter("action");

            if ("add".equals(action)) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String email = request.getParameter("email");

                StudentLog student = new StudentLog(username, password, email);
                boolean success = studentService.addStudent(student);

                response.setContentType("text/plain");
                response.getWriter().write(success ? "Student added successfully!" : "Failed to add student.");
            } else if ("delete".equals(action)) {
                String username = request.getParameter("username");
                boolean deleted = studentService.deleteStudent(username);

                response.setContentType("text/plain");
                response.getWriter().write(deleted ? "Student deleted successfully!" : "Student not found.");
            }
        }

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            List<StudentLog> students = studentService.readStudent();

            response.setContentType("text/html");
            response.getWriter().write("<html><body><h2>Student List</h2><ul>");
            for (StudentLog student : students) {
                response.getWriter().write("<li>" + student.getUsername() + " - " + student.getEmail() + "</li>");
            }
            response.getWriter().write("</ul></body></html>");
        }
    }

