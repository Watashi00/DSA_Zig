const std = @import("std");

const nodeModule = @import("../ds/node.zig");
const Node = nodeModule.Node;

pub const doublyLinkedList = struct {
    head: ?*Node,
    tail: ?*Node,
    length: usize,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator) doublyLinkedList {
        return doublyLinkedList{ .head = null, .tail = null, .length = 0, .allocator = allocator };
    }

    pub fn append(self: *doublyLinkedList, content: []const u8) !void {
        const new_node = try self.allocator.create(Node);

        new_node.* = Node{
            .payload = content,
            .next = null,
            .prev = null,
        };

        if (self.head == null) {
            self.head = new_node;
            self.tail = new_node;
            self.incLen();
            return;
        }

        new_node.prev = self.tail;
        self.tail.?.next = new_node;
        self.tail = new_node;

        self.incLen();
    }

    pub fn pop(self: *doublyLinkedList) ?*Node {
        if (self.tail == null) return null;
        const retNode = self.tail.?;
        self._remove(retNode);
        return retNode;
    }

    pub fn getByIndex(self: *doublyLinkedList, index: usize) ?*Node {
        if (self.head == null or index >= self.length) return null;
        if (index < self.length / 2) {
            var cur = self.head;
            var i: usize = 0;
            while (cur) |node| {
                if (i == index) return node;
                cur = node.next;
                i += 1;
            }
        } else {
            var cur = self.tail;
            var i: usize = self.length - 1;
            while (cur) |node| {
                if (i == index) return node;
                cur = node.prev;
                
                if (i == 0) break;
                i -= 1;
            }
        }
        return null;
    }

    pub fn popByIndex(self: *doublyLinkedList, index: usize) ?*Node {
        if (self.head == null) return null;
        const retNode = self.getByIndex(index);
        if (retNode) |node| {
            self._remove(node);
        }
        return retNode;
    }

    pub fn printList(self: *doublyLinkedList) !void {
        if (self.head == null) return;

        var cur = self.head;

        while (cur) |node| {
            std.debug.print("{s}", .{node.payload});
            if (node.next != null) std.debug.print(" <-> ", .{});
            cur = node.next;
        }
    }

    pub fn remove(self: *doublyLinkedList) void {
        if (self.tail) |tailNode| {
            self._remove(tailNode);
            self.allocator.destroy(tailNode);
        }
    }

    fn _remove(self: *doublyLinkedList, node: *Node) void {
        if (node.prev) |prev| {
            prev.next = node.next;
        } else {
            self.head = node.next;
        }

        if (node.next) |next| {
            next.prev = node.prev;
        } else {
            self.tail = node.prev;
        }
        self.decLen();
    }

    pub fn getHead(self: *doublyLinkedList) ?*Node {
        return self.head;
    }

    pub fn getTail(self: *doublyLinkedList) ?*Node {
        return self.tail;
    }

    fn incLen(self: *doublyLinkedList) void {
        self.length += 1;
    }

    fn decLen(self: *doublyLinkedList) void {
        if (self.length == 0) {
            @panic("length underflow");
        }
        self.length -= 1;
    }

    pub fn deinit(self: *doublyLinkedList) void {
        var cur = self.head;
        while (cur) |node| {
            const next = node.next;
            self.allocator.destroy(node);
            cur = next;
        }
    }
};