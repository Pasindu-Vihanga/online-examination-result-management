package com.jsp.exam.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.jsp.exam.service.ExamResultService;

@WebServlet("/AdminResultManagementServlet")
public class AdminResultManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ExamResultService examService = new ExamResultService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // getAllResults() returns List<String[]> not ResultLinkedList
        List<String[]> results = examService.getAllResults();

        request.setAttribute("results", results);
        request.getRequestDispatcher("adminResultmanage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String studentId = request.getParameter("studentId");
        String examCode = request.getParameter("examCode");
        String statusMessage = "";
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
        } else {
            statusMessage = "Invalid action.";
        }

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><head><title>Result Management</title></head><body>");
            out.println("<div style='padding: 10px; font-family: Arial; color: " + (success ? "green" : "red") + ";'>");
            out.println("<h3>" + statusMessage + "</h3>");
            out.println("<a href='AdminResultManagementServlet'>Back to Results</a>");
            out.println("</div></body></html>");
        }
    }
}
