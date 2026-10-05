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
        adminService = new Adminservice();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String inputUsername = request.getParameter("username");
        String inputPassword = request.getParameter("password");

        if (inputUsername == null || inputPassword == null || inputUsername.trim().isEmpty() || inputPassword.trim().isEmpty()) {
            response.sendRedirect("adminlogin.jsp?error=empty");
            return;
        }

        inputUsername = inputUsername.trim();
        inputPassword = inputPassword.trim();

        AdminLog adminLog = new AdminLog(inputUsername, inputPassword, "MySQL");
        boolean isAuthenticated = adminService.authenticate(adminLog);

        if (isAuthenticated) {
            HttpSession session = request.getSession();
            session.setAttribute("inputUsername", inputUsername);
            AdminLogger.log(null, inputUsername, "Login successful");
            response.sendRedirect("admindashboard.jsp");
        } else {
            AdminLogger.log(null, inputUsername, "Login failed");
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<!DOCTYPE html><html lang='en'><head><meta charset='UTF-8'>");
            out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
            out.println("<title>Login Failed</title>");
            out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css' rel='stylesheet'>");
            out.println("</head><body class='bg-light'><div class='container mt-5'>");
            out.println("<div class='card shadow-sm p-4 text-center' style='max-width: 450px; margin: auto;'>");
            out.println("<h3 class='text-danger mb-3'>Invalid Admin Credentials!</h3>");
            out.println("<p class='text-muted'>Please verify your username and password.</p>");
            out.println("<a href='adminlogin.jsp' class='btn btn-primary mt-2'>Back to Login</a>");
            out.println("</div></div></body></html>");
            out.close();
        }
    }
}
