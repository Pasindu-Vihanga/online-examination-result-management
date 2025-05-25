package com.jsp.exam.dsa;

import com.jsp.exam.model.StudentResult;
import java.util.ArrayList;
import java.util.List;

public class ResultLinkedList {
    // Inner Node class
    public static class Node {
        public StudentResult data;
        public Node next;

        public Node(String studentId, String examCode, int marks) {
            this.data = new StudentResult(studentId, examCode, marks);
            this.next = null;
        }
    }

    private Node head;

    // Add new StudentResult node at end
    public void add(String studentId, String examCode, int score) {
        Node newNode = new Node(studentId, examCode, score);
        if (head == null) {
            head = newNode;
        } else {
            Node curr = head;
            while (curr.next != null) {
                curr = curr.next;
            }
            curr.next = newNode;
        }
    }

    // Update score by studentId and examCode
    public boolean update(String studentId, String examCode, int newScore) {
        Node current = head;
        while (current != null) {
            if (current.data.getStudentId().equals(studentId) &&
                    current.data.getExamCode().equals(examCode)) {
                current.data.setMarks(newScore);
                return true;
            }
            current = current.next;
        }
        return false;
    }

    // Delete node by studentId and examCode
    public boolean delete(String studentId, String examCode) {
        Node current = head, prev = null;
        while (current != null) {
            if (current.data.getStudentId().equals(studentId) &&
                    current.data.getExamCode().equals(examCode)) {
                if (prev == null) {
                    head = current.next;
                } else {
                    prev.next = current.next;
                }
                return true;
            }
            prev = current;
            current = current.next;
        }
        return false;
    }

    // Get all results as an array of StudentResult
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

    // Alternatively, get all results as List<String[]>
    public List<String[]> toListOfStringArrays() {
        List<String[]> list = new ArrayList<>();
        Node current = head;
        while (current != null) {
            String[] entry = new String[] {
                    current.data.getStudentId(),
                    current.data.getExamCode(),
                    String.valueOf(current.data.getMarks())
            };
            list.add(entry);
            current = current.next;
        }
        return list;
    }

    // Count nodes in the linked list
    public int size() {
        int count = 0;
        Node current = head;
        while (current != null) {
            count++;
            current = current.next;
        }
        return count;
    }

    // Getter for head (optional)
    public Node getHead() {
        return head;
    }
}
