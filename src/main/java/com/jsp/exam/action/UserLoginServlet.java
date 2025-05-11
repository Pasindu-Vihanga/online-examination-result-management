package com.jsp.exam.action;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

import com.jsp.exam.model.Student;
import com.jsp.exam.service.Studentservice;

@WebServlet("/login")
public class UserLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final Studentservice studentservice = new Studentservice();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String inputUsername = request.getParameter("username");
        String inputPassword = request.getParameter("password");

        boolean isAuthenticated = authenticateStudent(inputUsername, inputPassword);

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html lang='en'>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("<title>Login Response</title>");
        out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css' rel='stylesheet'>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class='container mt-5'>");

        if (isAuthenticated) {
            HttpSession session = request.getSession();
            session.setAttribute("username", inputUsername);

            out.println("<div class='alert alert-success text-center'>");
            out.println("<h3>Login successful!</h3>");
            out.println("<p>Welcome, <strong>" + inputUsername + "</strong></p>");
            out.println("<a href='dashboard.jsp' class='btn btn-primary'>Go to Dashboard</a>");
            out.println("</div>");
        } else {
            out.println("<div class='alert alert-danger text-center'>");
            out.println("<h3>Invalid username or password!</h3>");
            out.println("<p>Please try again or register for an account.</p>");
            out.println("<a href='registration.jsp' class='btn btn-warning'>Register Here</a>");
            out.println("<a href='login.jsp' class='btn btn-secondary'>Back to Login</a>");
            out.println("</div>");
        }

        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
    }

    private boolean authenticateStudent(String username, String password) {
        for (Student student : studentservice.readStudents()) {
            if (student.getStudent_name().equals(username) && student.getStudent_password().equals(password)) {
                return true;
            }
        }
        return false;
    }
}
