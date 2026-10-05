package com.jsp.exam.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

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
            int n = results.size(); // Retrieve number of elements in linked list

            /*
            Outer Loop – Moves Selection Point,

                for (int i = 0; i < n - 1; i++) {
                    int minIndex = i;
        Loops over the entire list, selecting each index i to begin finding the smallest element.

        Initializes
                    minIndex = i,
        assuming the current element is the smallest.

              */
            for (int i = 0; i < n - 1; i++) {
                int minIndex = i;
                    // Inner Loop – Find the Smallest Marks
                for (int j = i + 1; j < n; j++) {
                    int marksJ = Integer.parseInt(results.get(j)[2]);  //Extracts: marks (results.get(j)[2]) and converts them from String to Integer.
                    int marksMin = Integer.parseInt(results.get(minIndex)[2]); //Updates: minIndex when a smaller mark is found

                    if (marksJ < marksMin) {
                        minIndex = j;
                    }
                }

                // Swap the Elements (Selection Sort Step)
                if (minIndex != i) {
                    String[] temp = results.get(i); //Checks if minIndex changed (meaning a smaller value was found).

                    //Swaps the student result at i with the student result at minIndex.

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
