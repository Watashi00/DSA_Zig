const std = @import("std");

const nodeModule = @import("../ds/node.zig");
const Node = nodeModule.Node;

pub const doublyLinkedList = struct {
    head: ?*Node,
    tail: ?*Node,
    length: usize,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator) doublyLinkedList {
        return doublyLinkedList {
            .head = null,
            .length = 0,
            .allocator = allocator
        };
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
            self.resizeLen(1);
            return;
        }

        new_node.prev = self.tail;
        self.tail.?.next = new_node;
        self.tail = new_node;

        self.resizeLen(1);
    }

    pub fn pop(self: *doublyLinkedList) ?*Node {
        if(self.tail == null) return;
        const retNode = self.tail;

        if(retNode.?.prev) |prev| {
            prev.next = null;
            self.tail = prev;
        } else {
            self.head = null;
            self.tail = null;
        }
        self.decLen();
        return retNode;
    }

    pub fn remove(self: *doublyLinkedList) !void  {
        self.pop();
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
        while(cur) |node| {
            const next = node.next;
            self.allocator.destroy(node);
            cur = next;
        }
    }
};