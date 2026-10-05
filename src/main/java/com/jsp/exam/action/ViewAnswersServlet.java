package com.jsp.exam.action;

import java.io.IOException;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.jsp.exam.service.ExamResultService;

@WebServlet("/ViewAnswersServlet")
public class ViewAnswersServlet extends HttpServlet {
    private ExamResultService examService = new ExamResultService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentId = request.getParameter("studentId");
        String examCode = request.getParameter("examCode");

        if (studentId != null && examCode != null) {
            // Evaluate answers and calculate score
            Map<String, Boolean> results = examService.evaluateStudentAnswers(studentId, examCode);
            int score = examService.calculateScore(studentId, examCode);

            // Save the exam result
            boolean isSaved = examService.saveExamResult(studentId, examCode);

            // Prepare JSON response
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            StringBuilder jsonOutput = new StringBuilder("{");
            jsonOutput.append("\"studentId\":\"").append(studentId).append("\", ");
            jsonOutput.append("\"examCode\":\"").append(examCode).append("\", ");
            jsonOutput.append("\"score\":").append(score).append(", ");
            jsonOutput.append("\"resultSaved\":").append(isSaved).append(", ");
            jsonOutput.append("\"answers\":[");

            for (Map.Entry<String, Boolean> entry : results.entrySet()) {
                jsonOutput.append("{\"questionNumber\":\"").append(entry.getKey())
                        .append("\", \"correct\":").append(entry.getValue()).append("},");
            }
            if (jsonOutput.length() > 1) jsonOutput.setLength(jsonOutput.length() - 1); // Remove last comma
            jsonOutput.append("]}");

            response.getWriter().write(jsonOutput.toString());
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request parameters.");
        }
    }
}
