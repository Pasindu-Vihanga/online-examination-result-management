package com.jsp.exam.dsa;

import com.jsp.exam.model.StudentResult;

public class Node {
    public StudentResult data;
    public Node next;

    public Node(StudentResult data) {
        this.data = data;
        this.next = null;
    }
}

