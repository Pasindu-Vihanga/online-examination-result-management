package com.jsp.exam.action;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;

@WebServlet("/result")
public class ResultServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String indexNumber = request.getParameter("indexNumber");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        boolean resultFound = false;

        out.println("<html><head><title>Result</title></head><body>");
        out.println("<h2>Result for Index Number: " + indexNumber + "</h2>");

        try (BufferedReader reader = new BufferedReader(new FileReader("D:/IP/proj/Exam/src/main/webapp/results/results.txt"))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length >= 2 && data[0].equalsIgnoreCase(indexNumber)) {
                    resultFound = true;
                    out.println("<p><strong>Result:</strong> " + data[1] + "</p>");
                    break;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            out.println("<p>Error reading result data.</p>");
        }

        if (!resultFound) {
            out.println("<p style='color:red;'>No result found for the given index number.</p>");
        }

        out.println("<a href='index.jsp'>Back to Home</a>");
        out.println("</body></html>");
    }
}
