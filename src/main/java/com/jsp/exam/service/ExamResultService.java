package com.jsp.exam.service;

import java.io.*;
import java.util.*;

import com.jsp.exam.model.ExamAnswer;

public class ExamResultService {
    private static final String STUDENT_ANSWER_FILE = "D:/IP/proj/Online-Exam-System/src/main/webapp/Questions/student_attempts.txt";
    private static final String QUESTION_FILE = "D:/IP/proj/Online-Exam-System/src/main/webapp/Questions/questions.txt";

    public boolean storeAnswers(String studentId, String examCode, Map<String, String> answers) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(STUDENT_ANSWER_FILE, true))) {
            StringBuilder line = new StringBuilder(studentId).append("|").append(examCode);
            for (Map.Entry<String, String> entry : answers.entrySet()) {
                line.append("|").append(entry.getKey()).append(":").append(entry.getValue());
            }
            writer.write(line.toString());
            writer.newLine();
            return true;
        } catch (IOException e) {
            System.err.println("[storeAnswers] Error: " + e.getMessage());
            return false;
        }
    }

    public Map<String, String> getCorrectAnswers(String examCode) {
        Map<String, String> correctAnswers = new HashMap<>();
        File file = new File(QUESTION_FILE);

        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split("\\|");
                    if (parts.length >= 12 && parts[2].equals(examCode)) {
                        correctAnswers.put(parts[10], parts[11]); // QuestionNumber -> Correct Answer
                    }
                }
            } catch (IOException e) {
                System.err.println("[getCorrectAnswers] Error: " + e.getMessage());
            }
        }
        return correctAnswers;
    }

    public Map<String, Boolean> evaluateStudentAnswers(String studentId, String examCode) {
        Map<String, Boolean> resultMap = new HashMap<>();
        File file = new File(STUDENT_ANSWER_FILE);

        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                Map<String, String> correctAnswers = getCorrectAnswers(examCode);
                String line;

                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split("\\|");
                    if (parts.length >= 3 && parts[0].equals(studentId) && parts[1].equals(examCode)) {
                        for (int i = 2; i < parts.length; i++) {
                            String[] answerParts = parts[i].split(":");
                            if (answerParts.length == 2) {
                                String questionNumber = answerParts[0];
                                String selectedAnswer = answerParts[1];
                                resultMap.put(questionNumber, correctAnswers.getOrDefault(questionNumber, "").equals(selectedAnswer));
                            }
                        }
                    }
                }
            } catch (IOException e) {
                System.err.println("[evaluateStudentAnswers] Error: " + e.getMessage());
            }
        }
        return resultMap;
    }

    public int calculateScore(String studentId, String examCode) {
        Map<String, Boolean> results = evaluateStudentAnswers(studentId, examCode);
        int score = 0;

        for (boolean isCorrect : results.values()) {
            if (isCorrect) {
                score += 1; // Assuming each correct answer gives 1 point
            }
        }
        return score;
    }
}
