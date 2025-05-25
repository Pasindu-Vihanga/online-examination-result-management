package com.jsp.exam.dsa;

import com.jsp.exam.model.StudentResult;

public class ResultLinkedList {
    private Node head;

    public void add(StudentResult result) {
        Node newNode = new Node(result);
        if (head == null) {
            head = newNode;
        } else {
            Node current = head;
            while (current.next != null)
                current = current.next;
            current.next = newNode;
        }
    }

    public boolean update(String studentId, String examCode, int newScore) {
        Node current = head;
        while (current != null) {
            if (current.data.getStudentId().equals(studentId) && current.data.getExamCode().equals(examCode)) {
                current.data.setMarks(newScore);
                return true;
            }
            current = current.next;
        }
        return false;
    }

    public boolean delete(String studentId, String examCode) {
        Node current = head, prev = null;
        while (current != null) {
            if (current.data.getStudentId().equals(studentId) && current.data.getExamCode().equals(examCode)) {
                if (prev == null) head = current.next;
                else prev.next = current.next;
                return true;
            }
            prev = current;
            current = current.next;
        }
        return false;
    }

    public StudentResult[] toArray() {
        int size = size();
        StudentResult[] arr = new StudentResult[size];
        Node current = head;
        int i = 0;
        while (current != null) {
            arr[i++] = current.data;
            current = current.next;
        }
        return arr;
    }

    public int size() {
        int count = 0;
        Node current = head;
        while (current != null) {
            count++;
            current = current.next;
        }
        return count;
    }

    public Node getHead() {
        return head;
    }
}

