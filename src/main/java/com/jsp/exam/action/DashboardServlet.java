package com.jsp.exam.action;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html>");
        out.println("<head>");
        out.println("</head>");
        out.println("<body>");
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
    }
}
