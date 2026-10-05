package com.jsp.exam.action;

import java.io.IOException;
import java.util.Map;
import java.util.HashMap;
import java.util.Enumeration;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.jsp.exam.service.Exmpservice;

@WebServlet("/ExamAttendanceServlet")
public class ExmpAttendanceServlet extends HttpServlet {
    private final Exmpservice examService = new Exmpservice();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String studentId = request.getParameter("studentId");
        String examCode = request.getParameter("examCode");

        if ("submitAll".equals(action)) {
            Map<String, String> answers = new HashMap<>();
            Enumeration<String> parameterNames = request.getParameterNames();

            while (parameterNames.hasMoreElements()) {
                String paramName = parameterNames.nextElement();
                if (paramName.startsWith("answer_")) {
                    String questionNumber = paramName.substring(7);
                    String selectedAnswer = request.getParameter(paramName);
                    answers.put(questionNumber, selectedAnswer);
                }
            }

            boolean success = examService.submitAnswer(studentId, examCode, answers);
            sendResponse(response, success, studentId, examCode, "All answers submitted successfully!", "Error submitting answers.");
        } else if ("endExam".equals(action)) {
            boolean success = examService.endExamSession(studentId, examCode);
            sendResponse(response, success, studentId, examCode, "Exam session ended successfully!", "Error ending exam session.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentId = request.getParameter("studentId");
        String examCode = request.getParameter("examCode");

        if (studentId != null && examCode != null) {
            int marks = examService.getStudentMarks(studentId, examCode);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"studentId\":\"" + studentId + "\", \"examCode\":\"" + examCode + "\", \"marks\":" + marks + "}");
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request parameters.");
        }
    }

    private void sendResponse(HttpServletResponse response, boolean success, String studentId, String examCode, String successMessage, String errorMessage) throws IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        String message = success ? successMessage : errorMessage;

        response.getWriter().write(
                "<!DOCTYPE html>" +
                "<html lang='en'>" +
                "<head>" +
                "    <meta charset='UTF-8'>" +
                "    <meta name='viewport' content='width=device-width, initial-scale=1'>" +
                "    <title>Submission Status</title>" +
                "    <link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css' rel='stylesheet'>" +
                "    <link href='https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css' rel='stylesheet'>" +
                "    <link href='css/modern-theme.css' rel='stylesheet'>" +
                "</head>" +
                "<body class='bg-mesh d-flex align-items-center justify-content-center' style='min-height: 100vh;'>" +
                "    <div class='container' style='max-width: 520px;'>" +
                "        <div class='modern-card text-center p-4 p-md-5 animate-fade-in'>" +
                (success ?
                "            <div class='brand-icon-box mx-auto mb-3' style='width: 60px; height: 60px; font-size: 1.8rem; background: #d1fae5; color: #059669; box-shadow: 0 4px 15px rgba(16, 185, 129, 0.2);'>" +
                "                <i class='bi bi-check-lg'></i>" +
                "            </div>" +
                "            <h3 class='fw-bold text-dark mb-2'>" + message + "</h3>" +
                "            <p class='text-muted mb-4'>Your examination responses for <strong>" + (examCode != null ? examCode : "") + "</strong> have been securely recorded in the database.</p>" +
                "            <div class='d-grid gap-2'>" +
                "                <a href='results.jsp?studentId=" + (studentId != null ? studentId : "") + "&examCode=" + (examCode != null ? examCode : "") + "' class='btn btn-modern-primary py-2 justify-content-center'>" +
                "                    <i class='bi bi-award'></i> View Evaluated Results" +
                "                </a>" +
                "                <a href='dashboard.jsp' class='btn btn-modern-secondary py-2 justify-content-center'>" +
                "                    <i class='bi bi-speedometer2'></i> Return to Dashboard" +
                "                </a>" +
                "            </div>"
                :
                "            <div class='brand-icon-box mx-auto mb-3' style='width: 60px; height: 60px; font-size: 1.8rem; background: #fee2e2; color: #dc2626; box-shadow: 0 4px 15px rgba(220, 38, 38, 0.2);'>" +
                "                <i class='bi bi-exclamation-triangle'></i>" +
                "            </div>" +
                "            <h3 class='fw-bold text-danger mb-2'>" + message + "</h3>" +
                "            <p class='text-muted mb-4'>An error occurred during submission. Please try again or notify your instructor.</p>" +
                "            <div class='d-grid gap-2'>" +
                "                <a href='examPortal.jsp' class='btn btn-modern-primary py-2 justify-content-center'>" +
                "                    <i class='bi bi-arrow-left'></i> Back to Exam Portal" +
                "                </a>" +
                "            </div>"
                ) +
                "        </div>" +
                "    </div>" +
                "</body>" +
                "</html>"
        );
    }
}
