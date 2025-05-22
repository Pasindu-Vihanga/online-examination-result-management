package com.jsp.exam.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.jsp.exam.service.ExamResultService;

@WebServlet("/AdminResultManagementServlet")
public class AdminResultManagementServlet extends HttpServlet {
    private ExamResultService examService = new ExamResultService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String[]> results = examService.getAllResults();
        request.setAttribute("results", results);

        // Display any status messages
        String statusMessage = request.getParameter("statusMessage");
        if (statusMessage != null) {
            request.setAttribute("statusMessage", statusMessage);
        }

        request.getRequestDispatcher("adminResultmanage.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String studentId = request.getParameter("studentId");
        String examCode = request.getParameter("examCode");
        String statusMessage = "";

        if (action != null && studentId != null && examCode != null) {
            boolean success = false;

            if ("delete".equals(action)) {
                success = examService.deleteResult(studentId, examCode);
                statusMessage = success ? "Record deleted successfully!" : "Failed to delete record.";
            } else if ("update".equals(action)) {
                try {
                    int newScore = Integer.parseInt(request.getParameter("newScore"));
                    success = examService.updateResult(studentId, examCode, newScore);
                    statusMessage = success ? "Record updated successfully!" : "Failed to update record.";
                } catch (NumberFormatException e) {
                    statusMessage = "Invalid score format.";
                }
            }

            // Display feedback messages in HTML format
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<!DOCTYPE html>");
            out.println("<html lang='en'>");
            out.println("<head>");
            out.println("<meta charset='UTF-8'>");
            out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
            out.println("<title>Admin Action Status</title>");
            out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css' rel='stylesheet'>");
            out.println("</head>");
            out.println("<body>");
            out.println("<div class='container mt-5'>");

            out.println("<div class='alert " + (success ? "alert-success" : "alert-danger") + " text-center'>");
            out.println("<h3>Action Status</h3>");
            out.println("<p><strong>" + statusMessage + "</strong></p>");
            out.println("<a href='/adminResultmanage.jsp' class='btn btn-primary'>Back to Management</a>");
            out.println("</div>");

            out.println("</div>");
            out.println("</body>");
            out.println("</html>");
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request parameters.");
        }
    }
}
