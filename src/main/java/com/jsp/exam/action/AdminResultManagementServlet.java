package com.jsp.exam.action;

import java.io.IOException;
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
        String sort = request.getParameter("sort");  // e.g. "allAsc", or null if none

        List<String[]> results = examService.getAllResults();

        if ("allAsc".equals(sort)) {
            // Sort by studentId, then examCode, then marks ascending
            results.sort((a, b) -> {
                int cmp = a[0].compareToIgnoreCase(b[0]); // studentId
                if (cmp != 0) return cmp;
                cmp = a[1].compareToIgnoreCase(b[1]);     // examCode
                if (cmp != 0) return cmp;
                return Integer.compare(Integer.parseInt(a[2]), Integer.parseInt(b[2])); // marks
            });
        }

        // Pass current sort param to JSP for forms or links if needed
        request.setAttribute("sort", sort);
        request.setAttribute("results", results);
        request.getRequestDispatcher("adminResultmanage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String studentId = request.getParameter("studentId");
        String examCode = request.getParameter("examCode");
        boolean success = false;

        if ("delete".equals(action)) {
            success = examService.deleteResult(studentId, examCode);
        } else if ("update".equals(action)) {
            try {
                int newScore = Integer.parseInt(request.getParameter("newScore"));
                success = examService.updateResult(studentId, examCode, newScore);
            } catch (NumberFormatException e) {
                success = false;
            }
        }

        // Get current sort parameter from the request so we can preserve it on redirect
        String sort = request.getParameter("sort");
        if (sort == null) sort = "";

        // Redirect back to GET with current sort parameter, to refresh the results list
        String redirectUrl = "AdminResultManagementServlet";
        if (!sort.isEmpty()) {
            redirectUrl += "?sort=" + sort;
        }

        // Optionally, you can store a status message in session to show after redirect
        HttpSession session = request.getSession();
        session.setAttribute("statusMessage", success ?
                (action.equals("delete") ? "Record deleted successfully!" : "Record updated successfully!") :
                (action.equals("delete") ? "Failed to delete record." : "Failed to update record."));

        response.sendRedirect(redirectUrl);
    }
}
