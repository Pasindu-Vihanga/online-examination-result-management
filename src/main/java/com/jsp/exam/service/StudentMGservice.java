 package com.jsp.exam.service;

import com.jsp.exam.model.StudentLog;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class StudentMGservice {
    private static final String STUDENT_CREDENTIAL_FILE = "D:/IP/proj/Examination/Online-Examinations-and-result-management-system/src/main/webapp/logincreds/credentials.txt";

    // Create user
    public boolean addStudent(StudentLog studentLog) {
        if (!studentLog.isValid()) {
            return false;
        }
        try (BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(STUDENT_CREDENTIAL_FILE, true))) {
            bufferedWriter.write(studentLog.getUsername() + "," + studentLog.getPassword() + "," + studentLog.getEmail());
            bufferedWriter.newLine();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Read users
    public List<StudentLog> readStudent() {
        List<StudentLog> readStudents = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(STUDENT_CREDENTIAL_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 3) {
                    readStudents.add(new StudentLog(parts[0], parts[1], parts[2])); // Fixed incorrect parameter
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return readStudents;
    }

    // Delete user
    public boolean deleteStudent(String username) {
        List<StudentLog> readStudents = readStudent();
        boolean deleted = false;

        try (BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(STUDENT_CREDENTIAL_FILE))) {
            for (StudentLog student : readStudents) {
                if (!student.getUsername().equals(username)) { // Fix: compare usernames correctly
                    bufferedWriter.write(student.getUsername() + "," + student.getPassword() + "," + student.getEmail());
                    bufferedWriter.newLine();
                } else {
                    deleted = true;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return deleted;
    }

}
