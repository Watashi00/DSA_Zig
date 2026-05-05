const std = @import("std");

const node = @import("ds/node.zig");

pub const doublyLinkedList = struct {
    head: ?*node,
    length: usize,
    allocator: std.mem.Allocator,

    fn createNode(self: *doublyLinkedList, content: []const u8 ) !void {
        const new_node = try self.allocator.create(node);
        
        new_node.* = node{
            .payload = content,
            .next = null,
            .prev = null
        };

        if (self.head == null) {
            self.head = new_node;
            return;
        }

    }

};