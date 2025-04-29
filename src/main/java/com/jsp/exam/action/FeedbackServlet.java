package com.jsp.exam.action;

import java.io.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

    @WebServlet("/FeedbackServlet")
    public class FeedbackServlet extends HttpServlet {
        private static final String FILE_PATH = "D:/IP/proj/Examination/Online-Examinations-and-result-management-system/src/main/webapp/logincreds/feedback.txt"; // Change path as needed

        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String message = request.getParameter("message");

            try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
                writer.write(name + "," + email + "," + message);
                writer.newLine();
            }

            response.sendRedirect("feedback.jsp");
        }

        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            response.setContentType("text/html");

            try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] data = line.split(",");
                    response.getWriter().println("<p>" + data[0] + " - " + data[2] + "</p>");
                }
            }
        }
    }


