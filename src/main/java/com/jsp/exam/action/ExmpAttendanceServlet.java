package com.jsp.exam.action;

import java.io.IOException;
import java.util.Map;
import java.util.HashMap;
import java.util.Enumeration;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.jsp.exam.service.Exmpservice;

@WebServlet("/ExamAttendanceServlet")
public class ExmpAttendanceServlet extends HttpServlet {
    private Exmpservice examService = new Exmpservice();

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
            sendResponse(response, success, "All answers submitted successfully!", "Error submitting answers.");
        } else if ("endExam".equals(action)) {
            boolean success = examService.endExamSession(studentId, examCode);
            sendResponse(response, success, "Exam session ended successfully!", "Error ending exam session.");
        }
    }

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

    private void sendResponse(HttpServletResponse response, boolean success, String successMessage, String errorMessage) throws IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        String message = success ? successMessage : errorMessage;
        String alertClass = success ? "success" : "danger";

        response.getWriter().write(
                "<!DOCTYPE html>" +
                        "<html lang='en'>" +
                        "<head>" +
                        "    <meta charset='UTF-8'>" +
                        "    <meta name='viewport' content='width=device-width, initial-scale=1'>" +
                        "    <title>Submission Status</title>" +
                        "    <link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css' rel='stylesheet'>" +
                        "</head>" +
                        "<body class='bg-light'>" +
                        "    <div class='container py-5'>" +
                        "        <div class='row justify-content-center'>" +
                        "            <div class='col-md-8'>" +
                        "                <div class='alert alert-" + alertClass + " text-center p-4 rounded shadow'>" +
                        "                    <h4 class='alert-heading'>" + message + "</h4>" +
                        "                    <hr>" +
                        "                    <p>You may now close this page or return to the homepage.</p>" +
                        "                    <a href='examPortal.jsp' class='btn btn-outline-primary mt-3'>Back to Exam Portal</a>" +
                        "                </div>" +
                        "            </div>" +
                        "        </div>" +
                        "    </div>" +
                        "</body>" +
                        "</html>"
        );
    }
}
