package Java.lists;

import Java.nodes.SNode;

public class LinkedList<T> {
    private SNode<T> head;
    private SNode<T> tail;
    private int size;
    
    public LinkedList() {
        head = null;
        tail = null;
        size = 0;
    }
    // O(1)
    public void addFirst(T data) {
        SNode<T> newNode = new SNode<>();
        newNode.setData(data);
        if(head == null) {
            head = newNode;
            tail = newNode;
        } else {
            newNode.setNext(head);
            head = newNode;
        }
        size++;
    }
    // O(1)
    public void addLast(T data) {
        SNode<T> newNode = new SNode<>();
        newNode.setData(data);
        if(head == null) {
            head = newNode;
            tail = newNode;
        } else {
            tail.setNext(newNode);
            tail = newNode;
        }
        size++;
    }
    // O(1)
    public void removeFirst() {
        if(head == null) {
            return;
        } else if(head == tail) {
            head = null;
            tail = null;
        } else {
            head = head.getNext().orElse(null);
        }
        size--;
    }
    // como SNode não possuo "prev" apenas "next" precisamos percorrer toda a lista. O(n)
    public void removeLast() {
        if(head == null) {
            return;
        } else if(head == tail) {
            head = null;
            tail = null;
        } else {
            SNode<T> current = head;
            while(current.getNext().orElse(null) != tail) {
                current = current.getNext().orElse(null);
            }
            tail = current;
            tail.setNext(null);
        }
        size--;
    }

    public void printList() {
        if(head == null) {
            return;
        }
        SNode<T> current = head;
        while(current != null) {
            System.out.printf("[%s] -> ",current.getData());
            current = current.getNext().orElse(null);
        }
        System.out.println("null");
    }

    public int getSize() {
        return size;
    }

    public SNode<T> getHead() {
        return head;
    }

    public SNode<T> getTail() {
        return tail;
    }
}
