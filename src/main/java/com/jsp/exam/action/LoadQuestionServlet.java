package com.jsp.exam.action;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

import com.jsp.exam.model.ExamPaper;
import com.jsp.exam.service.Examservice;

@WebServlet("/LoadQuestionServlet")
    public class LoadQuestionServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String examCode = request.getParameter("examCode");
            String questionNumber = request.getParameter("questionNumber");

            System.out.println("[LoadQuestionServlet] examCode: " + examCode);
            System.out.println("[LoadQuestionServlet] questionNumber: " + questionNumber);

            File file = new File("D:/IP/proj/Online-Exam-System/src/mainwebapp/Questions/questions.txt");

            if (examCode != null && questionNumber != null && file.exists()) {
                BufferedReader reader = new BufferedReader(new FileReader(file));
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split("\\|");
                    if (parts.length >= 12) {
                        if (parts[2].equals(examCode) && parts[11].equals(questionNumber)) {
                            // Exam Paper info
                            ExamPaper exam = new ExamPaper(parts[0], parts[1], parts[2], parts[3], parts[4]);
                            request.setAttribute("exam", exam);

                            // Question data
                            request.setAttribute("questionTitle", parts[5]);
                            request.setAttribute("optionA", parts[6]);
                            request.setAttribute("optionB", parts[7]);
                            request.setAttribute("optionC", parts[8]);
                            request.setAttribute("optionD", parts[9]);
                            request.setAttribute("correctAnswer", parts[10]);
                            request.setAttribute("questionNumber", parts[11]);
                            break;
                        }
                    }
                }
                reader.close();
            }

            request.getRequestDispatcher("ExmeditExam.jsp").forward(request, response);
        }
    }

