package com.jsp.exam.service;

import java.io.*;
import java.util.*;

import com.jsp.exam.dsa.ResultLinkedList;
import com.jsp.exam.dsa.ResultLinkedList.Node;
import com.jsp.exam.model.StudentResult;

public class ExamResultService {

    private static final String STUDENT_ANSWER_FILE = "D:/IP/proj/Examination/Online-Examinations-and-result-management-system/src/main/webapp/Questions/student_attempts.txt";
    private static final String QUESTION_FILE = "D:/IP/proj/Examination/Online-Examinations-and-result-management-system/src/main/webapp/Questions/questions.txt";
    private static final String RESULT_FILE = "D:/IP/proj/Examination/Online-Examinations-and-result-management-system/src/main/webapp/Questions/marks.txt";

    // Store student's answers in file
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

    // Get unique exam codes from questions file
    public List<String> getExamCodes() {
        List<String> examCodes = new ArrayList<>();
        File file = new File(QUESTION_FILE);

        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split("\\|");
                    if (parts.length >= 3 && !examCodes.contains(parts[2])) {
                        examCodes.add(parts[2]);
                    }
                }
            } catch (IOException e) {
                System.err.println("[getExamCodes] Error: " + e.getMessage());
            }
        }
        return examCodes;
    }

    // Evaluate student answers correctness
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
                                resultMap.put(questionNumber,
                                        correctAnswers.getOrDefault(questionNumber, "").equals(selectedAnswer));
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

    // Get correct answers for given exam code
    public Map<String, String> getCorrectAnswers(String examCode) {
        Map<String, String> correctAnswers = new HashMap<>();
        File file = new File(QUESTION_FILE);

        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split("\\|");
                    if (parts.length >= 12 && parts[2].equals(examCode)) {
                        correctAnswers.put(parts[10], parts[11]); // questionNumber -> correctAnswer
                    }
                }
            } catch (IOException e) {
                System.err.println("[getCorrectAnswers] Error: " + e.getMessage());
            }
        }
        return correctAnswers;
    }

    // Calculate total correct score
    public int calculateScore(String studentId, String examCode) {
        Map<String, Boolean> results = evaluateStudentAnswers(studentId, examCode);
        return (int) results.values().stream().filter(Boolean::booleanValue).count();
    }

    // Save final exam result
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

    // Load all results into linked list and return as List<String[]>
    public List<String[]> getAllResults() {
        ResultLinkedList list = new ResultLinkedList();
        File file = new File(RESULT_FILE);

        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split("\\|");
                    if (parts.length == 3) {
                        try {
                            String studentId = parts[0];
                            String examCode = parts[1];
                            int score = Integer.parseInt(parts[2].trim());
                            list.add(studentId, examCode, score);
                        } catch (NumberFormatException e) {
                            System.err.println("[getAllResults] Invalid score: " + parts[2]);
                        }
                    }
                }
            } catch (IOException e) {
                System.err.println("[getAllResults] Error: " + e.getMessage());
            }
        }

        return list.toListOfStringArrays();
    }

    // Delete a result and rewrite file
    public boolean deleteResult(String studentId, String examCode) {
        ResultLinkedList list = loadResultsIntoList();
        if (!list.delete(studentId, examCode)) {
            return false;
        }
        return rewriteFileFromLinkedList(list);
    }

    // Update a result and rewrite file
    public boolean updateResult(String studentId, String examCode, int newScore) {
        ResultLinkedList list = loadResultsIntoList();
        if (!list.update(studentId, examCode, newScore)) {
            return false;
        }
        return rewriteFileFromLinkedList(list);
    }

    // Load all results from file into a ResultLinkedList
    private ResultLinkedList loadResultsIntoList() {
        ResultLinkedList list = new ResultLinkedList();
        File file = new File(RESULT_FILE);

        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split("\\|");
                    if (parts.length == 3) {
                        try {
                            String studentId = parts[0];
                            String examCode = parts[1];
                            int score = Integer.parseInt(parts[2].trim());
                            list.add(studentId, examCode, score);
                        } catch (NumberFormatException e) {
                            System.err.println("[loadResultsIntoList] Invalid score: " + parts[2]);
                        }
                    }
                }
            } catch (IOException e) {
                System.err.println("[loadResultsIntoList] Error: " + e.getMessage());
            }
        }

        return list;
    }

    // Rewrite file from linked list
    private boolean rewriteFileFromLinkedList(ResultLinkedList list) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(RESULT_FILE))) {
            Node current = list.getHead();
            while (current != null) {
                StudentResult data = current.data;
                writer.write(data.getStudentId() + "|" + data.getExamCode() + "|" + data.getMarks());
                writer.newLine();
                current = current.next;
            }
            return true;
        } catch (IOException e) {
            System.err.println("[rewriteFileFromLinkedList] Error: " + e.getMessage());
            return false;
        }
    }
}
