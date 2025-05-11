package com.jsp.exam.model;

public class ExamPaper {
    private String title;
    private String faculty;
    private String code;
    private String duration;
    private String totalQuestions;

    public ExamPaper(String title, String faculty, String code, String duration, String totalQuestions) {
        this.title = title;
        this.faculty = faculty;
        this.code = code;
        this.duration = duration;
        this.totalQuestions = totalQuestions;
    }

    public String getTitle() { return title; }
    public String getFaculty() { return faculty; }
    public String getCode() { return code; }
    public String getDuration() { return duration; }
    public String getTotalQuestions() { return totalQuestions; }
}