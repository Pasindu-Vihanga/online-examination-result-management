package com.jsp.exam.service;

import java.io.*;
import java.util.*;

import com.jsp.exam.model.ExamPaper;

public class Examservice {
    private static final String DEFAULT_FILE_PATH = "D:/IP/proj/Examination/Online-Examinations-and-result-management-system/src/main/webapp/Questions/questions.txt";
    private String filePath;

    public Examservice() {
        this.filePath = DEFAULT_FILE_PATH;
    }

    public Examservice(String filePath) {
        this.filePath = filePath;
    }

    private void ensureFileExists() throws IOException {
        File file = new File(filePath);
        if (!file.exists()) {
            file.getParentFile().mkdirs();
            file.createNewFile();
        }
    }

    public boolean createExamQuestion(String examTitle, String faculty, String moduleCode, String duration,
                                      String numberQuestions, String questionTitle, String optionA,
                                      String optionB, String optionC, String optionD, String questionNumber,
                                      String correctAnswer) {
        try {
            ensureFileExists();
            String line = String.join("|",
                    examTitle, faculty, moduleCode, duration, numberQuestions,
                    questionTitle, optionA, optionB, optionC, optionD, questionNumber, correctAnswer
            );
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
                writer.write(line);
                writer.newLine();
                return true;
            }
        } catch (IOException e) {
            System.err.println("[createExamQuestion] Error: " + e.getMessage());
            return false;
        }
    }

    public boolean deleteExam(String examCode) {
        File file = new File(filePath);
        File tempFile = new File(filePath + ".tmp");
        boolean deleted = false;

        if (examCode != null && file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file));
                 BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))) {

                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split("\\|");
                    if (parts.length >= 3 && !parts[2].equals(examCode)) {
                        writer.write(line);
                        writer.newLine();
                    } else {
                        deleted = true;
                    }
                }
            } catch (IOException e) {
                System.err.println("[deleteExam] Error: " + e.getMessage());
            }

            if (deleted && file.delete()) {
                tempFile.renameTo(file);
            }
        }
        return deleted;
    }

    public boolean updateExamQuestion(String examTitle, String faculty, String moduleCode, String duration,
                                      String numberQuestions, String questionTitle, String optionA,
                                      String optionB, String optionC, String optionD, String correctAnswer,
                                      String questionNumber) {
        File file = new File(filePath);
        File tempFile = new File(filePath + ".tmp");
        boolean updated = false;

        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file));
                 BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))) {

                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split("\\|");
                    if (parts.length >= 12 && parts[2].equals(moduleCode) && parts[10].equals(questionNumber)) {
                        String updatedLine = String.join("|",
                                examTitle, faculty, moduleCode, duration, numberQuestions,
                                questionTitle, optionA, optionB, optionC, optionD, questionNumber, correctAnswer
                        );
                        writer.write(updatedLine);
                        updated = true;
                    } else {
                        writer.write(line);
                    }
                    writer.newLine();
                }
            } catch (IOException e) {
                System.err.println("[updateExamQuestion] Error: " + e.getMessage());
            }

            if (updated && file.delete()) {
                tempFile.renameTo(file);
            }
        }
        return updated;
    }

    public ExamPaper getExamDetails(String examCode) {
        File file = new File(filePath);
        ExamPaper exam = null;

        if (examCode != null && file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split("\\|");
                    if (parts.length >= 12 && parts[2].equals(examCode)) {
                        if (exam == null) {
                            exam = new ExamPaper(parts[0], parts[1], parts[2], parts[3], parts[4]);
                        }
                    }
                }
            } catch (IOException e) {
                System.err.println("[getExamDetails] Error: " + e.getMessage());
            }
        }

        return exam;
    }

    public List<String[]> getExamQuestions(String examCode) {
        File file = new File(filePath);
        List<String[]> questionList = new ArrayList<>();

        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split("\\|");
                    if (parts.length >= 12) {
                        if (examCode == null || parts[2].equals(examCode)) {
                            questionList.add(parts);
                        }
                    }
                }
            } catch (IOException e) {
                System.err.println("[getExamQuestions] Error: " + e.getMessage());
            }
        }

        return questionList;
    }
}
