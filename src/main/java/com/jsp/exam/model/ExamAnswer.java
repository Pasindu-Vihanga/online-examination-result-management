package com.jsp.exam.model;

public class ExamAnswer {
        private String studentId;
        private String examCode;
        private String questionNumber;
        private String selectedAnswer;

        public ExamAnswer(String studentId, String examCode, String questionNumber, String selectedAnswer) {
            this.studentId = studentId;
            this.examCode = examCode;
            this.questionNumber = questionNumber;
            this.selectedAnswer = selectedAnswer;
        }

        public String getStudentId() {
            return studentId;
        }

        public String getExamCode() {
            return examCode;
        }

        public String getQuestionNumber() {
            return questionNumber;
        }

        public String getSelectedAnswer() {
            return selectedAnswer;
        }

        @Override
        public String toString() {
            return studentId + "|" + examCode + "|" + questionNumber + "|" + selectedAnswer;
        }
    }


