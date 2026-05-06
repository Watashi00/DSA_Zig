const std = @import("std");

const Node = @import("../ds/node.zig");

pub const doublyLinkedList = struct {
    head: ?*Node,
    length: usize,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator) doublyLinkedList {
        return doublyLinkedList {
            .head = null,
            .length = 0,
            .allocator = allocator
        };
    }

    pub fn createNode(self: *doublyLinkedList, content: []const u8 ) !void {
        const new_node = try self.allocator.create(Node);
        
        new_node.* = Node{
            .payload = content,
            .next = null,
            .prev = null
        };

        if (self.head == null) {
            self.head = new_node;
            self.resizeLen(1);
            return;
        } 
        if(self.head.?.next == null) {
            self.head.?.next = new_node;
            new_node.prev = self.head;
            self.resizeLen(1);
            return;
        }
        
        var cur = self.head.?.next;
        while(cur.?.next != null) {
            cur = cur.?.next;
        }
        cur.?.next = new_node;
        self.resizeLen(1);
        return;
        
    }

    fn resizeLen(self: *doublyLinkedList, qtd: i32) void {
        self.length += qtd;
    }

};