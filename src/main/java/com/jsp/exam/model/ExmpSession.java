package com.jsp.exam.model;

import java.util.Random;

public class ExmpSession {
    private String studentId;
    private String examCode;
    private long startTime;
    private int marks;

    public ExmpSession(String studentId, String examCode, long startTime) {
        this.studentId = studentId;
        this.examCode = examCode;
        this.startTime = startTime;
        this.marks = generateMarks(); // Generate marks when creating session
    }

    public String getStudentId() {
        return studentId;
    }

    public String getExamCode() {
        return examCode;
    }

    public long getStartTime() {
        return startTime;
    }

    public int getMarks() {
        return marks;
    }

    private int generateMarks() {
        Random random = new Random();
        return random.nextInt(101); // Generate random marks between 0 and 100
    }

    @Override
    public String toString() {
        return "ExmpSession{" +
                "studentId='" + studentId + '\'' +
                ", examCode='" + examCode + '\'' +
                ", startTime=" + startTime +
                ", marks=" + marks +
                '}';
    }
}
