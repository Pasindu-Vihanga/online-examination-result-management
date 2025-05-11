package com.jsp.exam.action;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

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

        Student newStudent = new Student(regname, regpassword, regemail);
        boolean isRegistered = studentservice.addStudent(newStudent);

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html lang='en'>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("<title>Registration Status</title>");
        out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css' rel='stylesheet'>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class='container mt-5'>");

        if (isRegistered) {
            out.println("<div class='alert alert-success text-center'>");
            out.println("<h3>Registration successful!</h3>");
            out.println("<p>Welcome, <strong>" + regname + "</strong></p>");
            out.println("<a href='login.jsp' class='btn btn-primary'>Go to Login</a>");
            out.println("</div>");
        } else {
            out.println("<div class='alert alert-danger text-center'>");
            out.println("<h3>Registration failed! Please check your details.</h3>");
            out.println("<a href='registration.jsp' class='btn btn-warning'>Try Again</a>");
            out.println("</div>");
        }

        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
    }
}
