package com.jsp.exam.action;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import com.jsp.exam.service.Studentservice;

@WebServlet("/dashboard")
public class UserDashboardServlet extends HttpServlet {

    private final Studentservice studentDAO = new Studentservice();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate form data
        if (name == null || email == null || password == null ||
                name.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty()) {
            // Forwarding error message to the JSP
            request.setAttribute("errorMessage", "Name, Email, and Password are required!");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
            return;
        }

        // Save student using DAO
        boolean isSaved = studentDAO.updateStudent(name, password, email);

        // Assuming successful update, store name in session
        if (isSaved) {
            HttpSession session = request.getSession();
            session.setAttribute("loggedUserName", name);
            session.setAttribute("loggedUserEmail", email);
            // Redirecting after successful update
            response.sendRedirect("dashboard.jsp?update=success");
        } else {
            // Redirecting after failure
            response.sendRedirect("dashboard.jsp?update=fail");
        }
    }
}
