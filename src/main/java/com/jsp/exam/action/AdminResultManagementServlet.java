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
            // Manual selection sort by marks ascending only
            int n = results.size();

            for (int i = 0; i < n - 1; i++) {
                int minIndex = i;

                for (int j = i + 1; j < n; j++) {
                    int marksJ = Integer.parseInt(results.get(j)[2]);
                    int marksMin = Integer.parseInt(results.get(minIndex)[2]);

                    if (marksJ < marksMin) {
                        minIndex = j;
                    }
                }

                if (minIndex != i) {
                    String[] temp = results.get(i);
                    results.set(i, results.get(minIndex));
                    results.set(minIndex, temp);
                }
            }
        }

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

        String sort = request.getParameter("sort");
        if (sort == null) sort = "";

        String redirectUrl = "AdminResultManagementServlet";
        if (!sort.isEmpty()) {
            redirectUrl += "?sort=" + sort;
        }

        HttpSession session = request.getSession();
        session.setAttribute("statusMessage", success ?
                (action.equals("delete") ? "Record deleted successfully!" : "Record updated successfully!") :
                (action.equals("delete") ? "Failed to delete record." : "Failed to update record."));

        response.sendRedirect(redirectUrl);
    }
}
