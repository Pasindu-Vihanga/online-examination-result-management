-- ========================================================
-- Online Examination & Result Management System
-- Database Schema for MySQL 8.0+
-- Author: Pasindu Vihanga
-- ========================================================

CREATE DATABASE IF NOT EXISTS online_exam_db;
USE online_exam_db;

-- 1. Students Table
CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL UNIQUE,
    student_password VARCHAR(255) NOT NULL,
    student_email VARCHAR(150) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Admins Table
CREATE TABLE IF NOT EXISTS admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Exam Questions Table
CREATE TABLE IF NOT EXISTS questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    exam_type VARCHAR(100) DEFAULT 'MID EXAM',
    faculty VARCHAR(150) DEFAULT 'Faculty of Computing',
    subject_code VARCHAR(50) NOT NULL,
    duration_mins INT DEFAULT 30,
    total_marks INT DEFAULT 10,
    question_text TEXT NOT NULL,
    option1 VARCHAR(255) NOT NULL,
    option2 VARCHAR(255) NOT NULL,
    option3 VARCHAR(255) NOT NULL,
    option4 VARCHAR(255) NOT NULL,
    question_no VARCHAR(20) DEFAULT '01',
    correct_answer VARCHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Student Results Table
CREATE TABLE IF NOT EXISTS student_results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(100) NOT NULL,
    subject_code VARCHAR(50) NOT NULL,
    marks INT NOT NULL,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. Student Exam Attempts (Answers) Table
CREATE TABLE IF NOT EXISTS student_attempts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    subject_code VARCHAR(50) NOT NULL,
    answers TEXT NOT NULL,
    attempted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 6. Candidate Feedbacks Table
CREATE TABLE IF NOT EXISTS feedbacks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    comments TEXT NOT NULL,
    rating VARCHAR(50) NOT NULL,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 7. Admin Activity Logs Table
CREATE TABLE IF NOT EXISTS admin_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    action VARCHAR(255) NOT NULL,
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================================================
-- Seed Initial Demo Data
-- ========================================================

-- Initial Admins
INSERT IGNORE INTO admins (username, password) VALUES 
('admin', 'admin123'),
('pasindu', '123456');

-- Initial Students
INSERT IGNORE INTO students (student_name, student_password, student_email) VALUES 
('Pasindu', '123', 'pasindu@example.com'),
('chamodith', '123456789', 'chamodith@example.com'),
('Kavindu', 'kavi123', 'kavindu@example.com');

-- Initial Questions
INSERT INTO questions (exam_type, faculty, subject_code, duration_mins, total_marks, question_text, option1, option2, option3, option4, question_no, correct_answer) VALUES
('MID EXAM', 'Faculty of Computing', 'IT1150', 30, 10, 'Which type of network cable is used to connect two computers directly?', 'HDMI', 'USB', 'RJ45 Cross-over', 'RJ11', '01', 'C'),
('MID EXAM', 'Faculty of Computing', 'DM1120', 30, 10, 'Evaluate the expression: 5 * 5 + 6 / 3', '27', '30', '45', '12', '01', 'A'),
('MID EXAM', 'Faculty of Computing', 'IT1170', 30, 10, 'What is the full meaning of POP3 in computer networking?', 'Post Office Protocol 3', 'Post Office Preposting', 'Power On Protocol 3', 'Point of Presence 3', '01', 'A'),
('MID EXAM', 'Faculty of Computing', 'IT1150', 30, 10, 'Which layer in the OSI model is responsible for routing packets?', 'Data Link Layer', 'Network Layer', 'Transport Layer', 'Physical Layer', '02', 'B'),
('MID EXAM', 'Faculty of Computing', 'IT1170', 30, 10, 'Which of the following is NOT an OOP concept in Java?', 'Encapsulation', 'Polymorphism', 'Compilation', 'Inheritance', '02', 'C');

-- Initial Marks
INSERT INTO student_results (student_id, subject_code, marks) VALUES 
('Pasindu', 'IT1170', 85),
('Pasindu', 'IT1150', 90),
('chamodith', 'DM1120', 70),
('Kavindu', 'IT1150', 75);

-- Initial Feedback
INSERT INTO feedbacks (name, email, comments, rating) VALUES 
('Pasindu', 'pasindu@example.com', 'Great system! Smooth exam experience.', 'Excellent'),
('Kavindu', 'kavindu@example.com', 'Very user friendly and responsive.', 'Good');
