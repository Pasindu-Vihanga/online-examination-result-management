package com.jsp.exam.model;

public class StudentResult {
    private String studentId;
    private String examCode;
    private int marks;

    public StudentResult(String studentId, String examCode, int marks) {
        this.studentId = studentId;
        this.examCode = examCode;
        this.marks = marks;
    }

    public String getStudentId() {
        return studentId;
    }

    public String getExamCode() {
        return examCode;
    }

    public int getMarks() {
        return marks;
    }

    public void setMarks(int marks) {
        this.marks = marks;
    }
}
