package Java.nodes;

import java.util.Optional;

public class SNode <T> {
    private SNode<T> next;
    private T data;

    public SNode() {
        next = null;
        data = null;
    }

    public SNode(T data) {
        this.data = data;
        next = null;
    }


    // getters and setters
    public void setNext(SNode<T> next) {
        this.next = next;
    }

    public Optional<SNode<T>> getNext() {
        return Optional.ofNullable(next);
    }

    public void setData(T data) {
        this.data = data;
    }

    public T getData() {
        return data;
    }

    @Override
    public String toString() {
        return "SNode [next=" + next + ", data=" + data + "]";
    };


}
