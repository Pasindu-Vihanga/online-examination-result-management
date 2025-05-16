package com.jsp.exam.service;

import java.io.*;
import java.util.*;

public class ExamResultService {
    private static final String STUDENT_ANSWER_FILE = "D:/IP/proj/Online-Exam-System/src/main/webapp/Questions/student_attempts.txt";
    private static final String QUESTION_FILE = "D:/IP/proj/Online-Exam-System/src/main/webapp/Questions/questions.txt";
    private static final String RESULT_FILE = "D:/IP/proj/Online-Exam-System/src/main/webapp/Questions/marks.txt"; // File to store exam results

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

    public List<String> getExamCodes() {
        List<String> examCodes = new ArrayList<>();
        File file = new File(QUESTION_FILE);

        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split("\\|");
                    if (parts.length >= 3 && !examCodes.contains(parts[2])) {
                        examCodes.add(parts[2]); // Ensures only unique exam codes are stored
                    }
                }
            } catch (IOException e) {
                System.err.println("[getExamCodes] Error: " + e.getMessage());
            }
        }
        return examCodes;
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

    public Map<String, String> getCorrectAnswers(String examCode) {
        Map<String, String> correctAnswers = new HashMap<>();
        File file = new File(QUESTION_FILE);

        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split("\\|");
                    if (parts.length >= 12 && parts[2].equals(examCode)) {
                        correctAnswers.put(parts[10], parts[11]); // Mapping QuestionNumber -> Correct Answer
                    }
                }
            } catch (IOException e) {
                System.err.println("[getCorrectAnswers] Error: " + e.getMessage());
            }
        }
        return correctAnswers;
    }

    public int calculateScore(String studentId, String examCode) {
        Map<String, Boolean> results = evaluateStudentAnswers(studentId, examCode);
        return (int) results.values().stream().filter(Boolean::booleanValue).count();
    }

    public boolean saveExamResult(String studentId, String examCode) {
        int score = calculateScore(studentId, examCode);
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(RESULT_FILE, true))) {
            writer.write(studentId + "|" + examCode + "|" + score);
            writer.newLine();
            return true;
        } catch (IOException e) {
            System.err.println("[saveExamResult] Error: " + e.getMessage());
            return false;
        }
    }

    public List<String[]> getAllResults() {
        List<String[]> results = new ArrayList<>();
        File file = new File(RESULT_FILE);

        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] data = line.split("\\|");
                    if (data.length == 3) {
                        results.add(data); // Ensure only valid records are stored
                    }
                }
            } catch (IOException e) {
                System.err.println("[getAllResults] Error: " + e.getMessage());
            }
        }
        return results;
    }

    public boolean deleteResult(String studentId, String examCode) {
        List<String[]> results = getAllResults();
        boolean found = false;

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(RESULT_FILE))) {
            for (String[] record : results) {
                if (record.length == 3 && record[0].equals(studentId) && record[1].equals(examCode)) {
                    found = true; // Mark as deleted
                } else {
                    writer.write(String.join("|", record));
                    writer.newLine();
                }
            }
        } catch (IOException e) {
            System.err.println("[deleteResult] Error: " + e.getMessage());
            return false;
        }
        return found;
    }

    public boolean updateResult(String studentId, String examCode, int newScore) {
        List<String[]> results = getAllResults();
        boolean found = false;

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(RESULT_FILE))) {
            for (String[] record : results) {
                if (record.length == 3 && record[0].equals(studentId) && record[1].equals(examCode)) {
                    record[2] = String.valueOf(newScore); // Update score
                    found = true;
                }
                writer.write(String.join("|", record));
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("[updateResult] Error: " + e.getMessage());
            return false;
        }
        return found;
    }
}
