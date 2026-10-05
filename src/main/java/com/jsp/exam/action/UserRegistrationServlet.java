package com.jsp.exam.action;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.jsp.exam.model.Student;
import com.jsp.exam.service.Studentservice;

@WebServlet("/register")
public class UserRegistrationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final Studentservice studentservice = new Studentservice();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String regname = request.getParameter("name");
        String regpassword = request.getParameter("password");
        String regemail = request.getParameter("email");

        if (regname == null || regpassword == null || regemail == null ||
                regname.trim().isEmpty() || regpassword.trim().isEmpty() || regemail.trim().isEmpty()) {
            response.sendRedirect("registration.jsp?error=empty");
            return;
        }

        Student newStudent = new Student(regname.trim(), regpassword.trim(), regemail.trim());
        boolean isRegistered = studentservice.addStudent(newStudent);

        if (isRegistered) {
            response.sendRedirect("login.jsp?registered=success");
        } else {
            response.sendRedirect("registration.jsp?error=failed");
        }
    }
}
