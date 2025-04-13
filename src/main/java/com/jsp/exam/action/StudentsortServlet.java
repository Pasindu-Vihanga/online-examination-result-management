package com.jsp.exam.action;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/results")
public class StudentsortServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(StudentsortServlet.class.getName());
    private static final String RESULTS_FILE = "src/main/webapp/logincreds/results.txt";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // LinkedList to hold results data
        LinkedList<String[]> resultsList = new LinkedList<>();

        // Read results file
        File file = new File(RESULTS_FILE);
        if (!file.exists()) {
            out.println("<p>Results file not found!</p>");
            return;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(","); // Split data by commas
                resultsList.add(parts);
            }
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error reading results file", e);
            out.println("<p>Error reading results file: " + e.getMessage() + "</p>");
            return;
        }

        // Display results in an HTML table
        out.println("<!DOCTYPE html>");
        out.println("<html lang='en'>");
        out.println("<head>");
        out.println("<title>Student Results</title>");
        out.println("<style>");
        out.println("table { width: 100%; border-collapse: collapse; }");
        out.println("th, td { border: 1px solid #ddd; padding: 8px; text-align: center; }");
        out.println("th { background-color: #f4f4f4; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h2>Student Results</h2>");
        if (resultsList.isEmpty()) {
            out.println("<p>No results found!</p>");
        } else {
            out.println("<table>");
            out.println("<thead>");
            out.println("<tr>");
            out.println("<th>Student ID</th><th>Student Name</th><th>Date of Birth</th><th>UID</th><th>Parent Name</th>");
            out.println("<th>Grade</th><th>Section</th><th>Subjects</th><th>Total Marks</th><th>Percentage</th>");
            out.println("<th>Remarks</th>");
            out.println("</tr>");
            out.println("</thead>");
            out.println("<tbody>");
            for (String[] result : resultsList) {
                out.println("<tr>");
                out.println("<td>" + result[0] + "</td>"); // Student ID
                out.println("<td>" + result[1] + "</td>"); // Student Name
                out.println("<td>" + result[2] + "</td>"); // Date of Birth
                out.println("<td>" + result[3] + "</td>"); // UID
                out.println("<td>" + result[4] + "</td>"); // Parent Name
                out.println("<td>" + result[5] + "</td>"); // Grade
                out.println("<td>" + result[6] + "</td>"); // Section
                out.println("<td>" + result[36] + "</td>"); // Subjects summary
                out.println("<td>" + result[37] + "</td>"); // Total Marks
                out.println("<td>" + result[38] + "</td>"); // Percentage
                out.println("<td>" + result[40] + "</td>"); // Remarks
                out.println("</tr>");
            }
            out.println("</tbody>");
            out.println("</table>");
        }
        out.println("</body>");
        out.println("</html>");
    }
}
