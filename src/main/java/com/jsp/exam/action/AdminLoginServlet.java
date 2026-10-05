package com.jsp.exam.action;

import com.jsp.exam.model.AdminLog;
import com.jsp.exam.service.AdminAuthService;
import com.jsp.exam.service.AdminLogger;
import com.jsp.exam.service.Adminservice;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

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
            response.sendRedirect("adminlogin.jsp?error=invalid");
        }
    }
}
