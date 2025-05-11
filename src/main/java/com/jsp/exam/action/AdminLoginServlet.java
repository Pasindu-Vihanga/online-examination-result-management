package com.jsp.exam.action;

import com.jsp.exam.model.AdminLog;
import com.jsp.exam.service.AdminAuthService;
import com.jsp.exam.service.AdminLogger;
import com.jsp.exam.service.Adminservice;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/memberslogin")
public class AdminLoginServlet extends HttpServlet {
    private AdminAuthService adminService;

    @Override
    public void init() throws ServletException {
        adminService = new Adminservice(); // Dependency injection using interface
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String inputUsername = request.getParameter("username");
        String inputPassword = request.getParameter("password");

        if (inputUsername == null || inputPassword == null || inputUsername.trim().isEmpty() || inputPassword.trim().isEmpty()) {
            request.setAttribute("error", "Invalid input. Username and password are required.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        inputUsername = inputUsername.trim();
        inputPassword = inputPassword.trim();

        AdminLog adminLog = new AdminLog(inputUsername, inputPassword, "D:/IP/proj/Online-Exam-System/src/main/webapp/logincreds/admin.txt");
        boolean isAuthenticated = adminService.authenticate(adminLog);

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
            // **Session Handling: Ensuring only successful login creates session**
            HttpSession session = request.getSession();
            session.setAttribute("inputUsername", inputUsername);
            response.sendRedirect("admindashboard.jsp");
            AdminLogger.log("D:/IP/proj/Online-Exam-System/src/main/webapp/logincreds/log.txt", inputUsername, "Login successful");
            out.println("<div class='alert alert-success text-center'>");
            out.println("<h3>Login successful!</h3>");
            out.println("<p>Welcome, <strong>" + inputUsername + "</strong></p>");
            out.println("<a href='admindashboard.jsp' class='btn btn-primary'>Dashboard</a>");
            out.println("</div>");
        } else {
            AdminLogger.log("D:/IP/proj/Online-Exam-System/src/main/webapp/logincreds/log.txt", inputUsername, "Login failed");
            out.println("<div class='alert alert-danger text-center'>");
            out.println("<h3>Invalid credentials!</h3>");
            out.println("<a href='adminlogin.jsp' class='btn btn-secondary'>Back to Login</a>");
            out.println("</div>");
        }

        out.println("</div></body></html>");
        out.close();
    }
}
