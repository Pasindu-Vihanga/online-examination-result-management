package com.jsp.exam.service;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

import com.jsp.exam.model.Student;

public class Studentservice { // Corrected class name (Capitalized 'S')
    private static final String STUDENT_CRED_FILE = "D:/IP/proj/Examination/Online-Examinations-and-result-management-system/src/main/webapp/logincreds/credentials.txt";

    // Create student
    public boolean addStudent(Student student) {
        if (!student.isValid()) {
            return false;
        }
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(STUDENT_CRED_FILE, true))) {
            writer.write(student.getStudent_name() + "," + student.getStudent_password() + "," + student.getStudent_email());
            writer.newLine();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Read students
    public List<Student> readStudents() {
        List<Student> readStudents = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(STUDENT_CRED_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {  // Corrected condition
                String[] parts = line.split(",");
                if (parts.length == 3) {
                    readStudents.add(new Student(parts[0], parts[1], parts[2]));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return readStudents;
    }

    // Delete student
    public boolean deleteStudent(String student_name) {
        List<Student> students = readStudents(); // Retrieve current students
        boolean deleted = false;

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(STUDENT_CRED_FILE))) {
            for (Student student : students) {
                if (!student.getStudent_name().equals(student_name)) {
                    writer.write(student.getStudent_name() + "," + student.getStudent_password() + "," + student.getStudent_email());
                    writer.newLine();
                } else {
                    deleted = true;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return deleted;
    }

    // Modify student
    public boolean updateStudent(String student_name, String student_password, String student_email) {
        List<Student> students = readStudents();
        boolean updated = false;

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(STUDENT_CRED_FILE))) {
            for (Student student : students) {
                if (student.getStudent_name().equals(student_name)) {
                    student = new Student(student_name, student_password, student_email); // Update student details
                    updated = true;
                }
                writer.write(student.getStudent_name() + "," + student.getStudent_password() + "," + student.getStudent_email());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return updated;
    }
}
