package com.jsp.exam.action;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import com.jsp.exam.service.Examservice;

@WebServlet("/UpdateExamQuestion")
public class UpdateExamQuestionServlet extends HttpServlet {

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
        String correctAnswer = request.getParameter("correctAnswer");
        String questionNumber = request.getParameter("questionNumber");

        System.out.println("[UpdateExamQuestion] Updating exam: " + moduleCode + ", Q" + questionNumber);

        Examservice examService = new Examservice();

        boolean updated = examService.updateExamQuestion(examTitle, faculty, moduleCode, duration, numberQuestions,
                questionTitle, optionA, optionB, optionC, optionD, correctAnswer, questionNumber);

        if (updated) {
            response.sendRedirect("Exmindex.jsp?examCode=" + moduleCode + "&questionNumber=" + questionNumber + "&status=success");
        } else {
            response.sendRedirect("Exmindex.jsp?examCode=" + moduleCode + "&questionNumber=" + questionNumber + "&status=failure");
        }
    }
}
