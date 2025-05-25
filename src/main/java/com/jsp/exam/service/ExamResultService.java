package com.jsp.exam.service;

import java.io.*;
import java.util.*;

import com.jsp.exam.dsa.Node;
import com.jsp.exam.dsa.ResultLinkedList;
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

    // Evaluate student answers and return map of questionNumber -> correctness (true/false)
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

    // Get correct answers for a given exam code
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

    // Calculate total correct score for student and exam
    public int calculateScore(String studentId, String examCode) {
        Map<String, Boolean> results = evaluateStudentAnswers(studentId, examCode);
        return (int) results.values().stream().filter(Boolean::booleanValue).count();
    }

    // Save final exam result (studentId|examCode|score) to result file
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

    // --- Now methods using your custom ResultLinkedList ---

    // Get all results from file, return as List<String[]> for compatibility
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
                            StudentResult result = new StudentResult(studentId, examCode, score);
                            list.add(result);
                        } catch (NumberFormatException e) {
                            System.err.println("[getAllResults] Invalid score: " + parts[2]);
                        }
                    }
                }
            } catch (IOException e) {
                System.err.println("[getAllResults] Error: " + e.getMessage());
            }
        }

        List<String[]> resultsList = new ArrayList<>();
        Node curr = list.getHead();
        while (curr != null) {
            StudentResult data = curr.data;
            resultsList.add(new String[] {
                    data.getStudentId(),
                    data.getExamCode(),
                    String.valueOf(data.getMarks())
            });
            curr = curr.next;
        }

        return resultsList;
    }

    // Delete a result from linked list and rewrite file
    public boolean deleteResult(String studentId, String examCode) {
        ResultLinkedList list = new ResultLinkedList();

        // Load from file
        List<String[]> allResults = getAllResults();
        for (String[] rec : allResults) {
            StudentResult res = new StudentResult(rec[0], rec[1], Integer.parseInt(rec[2]));
            list.add(res);
        }

        boolean deleted = list.delete(studentId, examCode);
        if (!deleted) return false;

        return rewriteFileFromLinkedList(list);
    }

    // Update a result's score and rewrite file
    public boolean updateResult(String studentId, String examCode, int newScore) {
        ResultLinkedList list = new ResultLinkedList();

        // Load from file
        List<String[]> allResults = getAllResults();
        for (String[] rec : allResults) {
            StudentResult res = new StudentResult(rec[0], rec[1], Integer.parseInt(rec[2]));
            list.add(res);
        }

        boolean updated = list.update(studentId, examCode, newScore);
        if (!updated) return false;

        return rewriteFileFromLinkedList(list);
    }

    // Rewrite the entire results file from linked list data
    private boolean rewriteFileFromLinkedList(ResultLinkedList list) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(RESULT_FILE))) {
            Node curr = list.getHead();
            while (curr != null) {
                StudentResult data = curr.data;
                writer.write(data.getStudentId() + "|" + data.getExamCode() + "|" + data.getMarks());
                writer.newLine();
                curr = curr.next;
            }
            return true;
        } catch (IOException e) {
            System.err.println("[rewriteFileFromLinkedList] Error: " + e.getMessage());
            return false;
        }
    }
}
