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
            while (curr.next != null) {   // Traverse to last node
                curr = curr.next;
            }
            curr.next = newNode;    // Link the new node
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

    /* *** FOR DELETE ***
    🔹 The method traverses the linked list one node at a time.
    🔹 If the matching node is found, it is removed by reassigning links.
    🔹 If the node is at the beginning, the head moves forward.
    🔹 If the node is in the middle or end, the previous node skips over it.
    */

    // Delete node by studentId and examCode
    public boolean delete(String studentId, String examCode) {
        Node current = head, prev = null;
        while (current != null) {  // Loops until the end of the list
            if (current.data.getStudentId().equals(studentId) &&
                    current.data.getExamCode().equals(examCode)) { //Compares the node's studentId and examCode with the given values.
                if (prev == null) {
                    head = current.next;  //head is forward to another link
                } else {
                    prev.next = current.next;  //if it's head is here,then link is connect to one another link
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

  /*  *** CONVERT LinkedList into Array ***

  🔹 Converts the dynamic linked list into a fixed array for easier access.
  🔹 Allows direct indexing (arr[i]) instead of traversal (while-loop).
  🔹 Useful for operations like sorting, searching, or exporting results.

  */

    // Alternatively, get all results as List<String[]>
    public List<String[]> toListOfStringArrays() {
        //Convert LinkedList into List for easier to handy bunch of data
        List<String[]> list = new ArrayList<>();
        Node current = head;        //current starts at head, meaning traversal starts from the first node.
        while (current != null) {

           /* Loop through the linked list until current == null.
              Each StudentResult is stored in the arr array.
              Moves current to the next node, ensuring all elements are copied.
           */

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
