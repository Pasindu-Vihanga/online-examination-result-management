package com.jsp.exam.action;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.jsp.exam.model.ExamPaper;
import com.jsp.exam.service.Examservice;

@WebServlet("/LoadQuestionServlet")
public class LoadQuestionServlet extends HttpServlet {
    private final Examservice examService = new Examservice();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String examCode = request.getParameter("examCode");
        String questionNumber = request.getParameter("questionNumber");

        if (examCode != null && questionNumber != null) {
            List<String[]> questions = examService.getExamQuestions(examCode);
            for (String[] parts : questions) {
                if (parts.length >= 12 && parts[2].equals(examCode) && parts[10].equals(questionNumber)) {
                    ExamPaper exam = new ExamPaper(parts[0], parts[1], parts[2], parts[3], parts[4]);
                    request.setAttribute("exam", exam);

                    request.setAttribute("questionTitle", parts[5]);
                    request.setAttribute("optionA", parts[6]);
                    request.setAttribute("optionB", parts[7]);
                    request.setAttribute("optionC", parts[8]);
                    request.setAttribute("optionD", parts[9]);
                    request.setAttribute("questionNumber", parts[10]);
                    request.setAttribute("correctAnswer", parts[11]);
                    break;
                }
            }
        }

        request.getRequestDispatcher("ExmeditExam.jsp").forward(request, response);
    }
}
