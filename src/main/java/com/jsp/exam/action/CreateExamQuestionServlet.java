package com.jsp.exam.action;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.jsp.exam.service.Examservice;

@WebServlet("/CreateExamQuestion")
public class CreateExamQuestionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String examTitle = request.getParameter("examTitle");
        String faculty = request.getParameter("faculty");
        String moduleCode = request.getParameter("moduleCode");
        String duration = request.getParameter("duration");
        String numberQuestions = request.getParameter("numberQuestions");
        String questionTitle = request.getParameter("questionTitle");
        String optionA = request.getParameter("optionA");
        String optionB = request.getParameter("optionB");
        String optionC = request.getParameter("optionC");
        String optionD = request.getParameter("optionD");
        String questionNumber = request.getParameter("questionNumber");
        String correctAnswer = request.getParameter("correctAnswer");

        System.out.println("[CreateExamQuestion] Processing exam: " + moduleCode + ", Q" + questionNumber);

        // Instantiate Examservice without passing FILE_PATH
        Examservice examService = new Examservice();

        boolean created = examService.createExamQuestion(examTitle, faculty, moduleCode, duration, numberQuestions,
                questionTitle, optionA, optionB, optionC, optionD, questionNumber, correctAnswer);

        if (created) {
            response.sendRedirect("ExmaddExam.jsp?status=success");
        } else {
            response.sendRedirect("ExmaddExam.jsp?status=failure");
        }
    }
}
