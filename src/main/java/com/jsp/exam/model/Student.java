package com.jsp.exam.model;

public class Student {
    private String student_name;
    private String student_password;
    private String student_email;

    public Student(String student_name, String student_password, String student_email) {
        this.student_name = student_name;
        this.student_password = student_password;
        this.student_email = student_email;
    }

    public String getStudent_name() {
        return student_name;
    }

    public String getStudent_password() {
        return student_password;
    }

    public String getStudent_email() {
        return student_email;
    }

    public boolean isValid() {
        return student_name !=null && !student_name.isEmpty()
                && student_password!=null && !student_password.isEmpty();
    }
}
