package com.jsp.exam.action;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.util.List;
import com.jsp.exam.model.ExamPaper;
import com.jsp.exam.service.Examservice;

@WebServlet("/EditExamNavi")
public class EditExamQuestionServlet extends HttpServlet {


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String examCode = request.getParameter("examCode");
        System.out.println("[EditExamQuestion] Received examCode: " + examCode);

        Examservice examService = new Examservice();

        ExamPaper exam = examService.getExamDetails(examCode);
        List<String[]> questionList = examService.getExamQuestions(examCode);

        if (exam != null) {
            request.setAttribute("exam", exam);
            request.getSession().setAttribute("exam", exam); // Persist exam details
            request.getSession().setAttribute("questions", questionList); // Persist questions list
        }

        request.getRequestDispatcher("ExmeditExam.jsp").forward(request, response);
    }
}
