package Java.nodes;

public class DNode<T> {
    DNode<T> next;
    DNode<T> prev;
    T data;

    public DNode() {
        next = null;
        prev = null;
        data = null;
    }

    public DNode(T data) {
        this.data = data;
        this.next = null;
        this.prev = null;
    }

    public DNode<T> getNext() {
        return next;
    }

    public void setNext(DNode<T> next) {
        this.next = next;
    }

    public DNode<T> getPrev() {
        return prev;
    }

    public void setPrev(DNode<T> prev) {
        this.prev = prev;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "DNode [data=" + data + "]";
    }

}
