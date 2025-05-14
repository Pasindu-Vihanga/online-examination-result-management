package com.jsp.exam.service;

import java.io.*;
import java.util.*;

import com.jsp.exam.model.ExmpSession;

public class Exmpservice {
    private static final String DEFAULT_FILE_PATH = "D:/IP/proj/Online-Examinations-and-result-management-system/src/main/webapp/Questions/student_attempts.txt";
    private String filePath;

    public Exmpservice() {
        this.filePath = DEFAULT_FILE_PATH;
    }

    public Exmpservice(String filePath) {
        this.filePath = filePath;
    }

    private void ensureFileExists() throws IOException {
        File file = new File(filePath);
        if (!file.exists()) {
            file.getParentFile().mkdirs();
            file.createNewFile();
        }
    }

    public boolean startExamSession(String studentId, String examCode) {
        try {
            ensureFileExists();
            ExmpSession session = new ExmpSession(studentId, examCode, System.currentTimeMillis());
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
                writer.write(session.getStudentId() + "|" + session.getExamCode() + "|" + session.getStartTime());
                writer.newLine();
                return true;
            }
        } catch (IOException e) {
            System.err.println("[startExamSession] Error: " + e.getMessage());
            return false;
        }
    }

    public boolean submitAnswer(String studentId, String examCode, Map<String, String> answers) {
        try {
            ensureFileExists();
            StringBuilder line = new StringBuilder(studentId + "|" + examCode);
            for (Map.Entry<String, String> entry : answers.entrySet()) {
                line.append("|").append(entry.getKey()).append(":").append(entry.getValue());
            }
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
                writer.write(line.toString());
                writer.newLine();
                return true;
            }
        } catch (IOException e) {
            System.err.println("[submitAnswer] Error: " + e.getMessage());
            return false;
        }
    }

    public int generateMarks() {
        Random random = new Random();
        return random.nextInt(101); // Generate random marks between 0 and 100
    }

    public boolean endExamSession(String studentId, String examCode) {
        try {
            ensureFileExists();
            int marks = generateMarks(); // Generate marks when ending session
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
                writer.write(studentId + "|" + examCode + "|Marks:" + marks);
                writer.newLine();
                return true;
            }
        } catch (IOException e) {
            System.err.println("[endExamSession] Error: " + e.getMessage());
            return false;
        }
    }

    public int getStudentMarks(String studentId, String examCode) {
        File file = new File(filePath);
        if (!file.exists()) return -1;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length == 3 && parts[0].equals(studentId) && parts[1].equals(examCode)) {
                    String[] marksParts = parts[2].split(":");
                    if (marksParts.length == 2 && marksParts[0].equals("Marks")) {
                        return Integer.parseInt(marksParts[1]);
                    }
                }
            }
        } catch (IOException | NumberFormatException e) {
            System.err.println("[getStudentMarks] Error: " + e.getMessage());
        }
        return -1;
    }
}
