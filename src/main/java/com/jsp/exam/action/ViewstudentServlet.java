package com.jsp.exam.action;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ViewstudentServlet")
public class ViewstudentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to the JSP page that reads and displays user data
        request.getRequestDispatcher("viewstudents.jsp").forward(request, response);
    }
}