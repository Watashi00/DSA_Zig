const std = @import("std");

const nodeModule = @import("./../ds/node.zig");
const Node = nodeModule.sNode;

pub fn linkedList(comptime T: type) type {
    return struct {
        const Self = @This();
        const ListNode = Node(T);

        head: ?*ListNode,
        length: usize,
        allocator: std.mem.Allocator,

        pub fn init(allocator: std.mem.Allocator) Self {
            return Self{ .head = null, .length = 0, .allocator = allocator };
        }
        /// O(n) append
        pub fn append(self: *Self, content: T) !void {
            const new_node = try self.allocator.create(content);
            new_node.* = ListNode {
                .payload = content,
                .next = null,

            };
            if (self.head == null) {
                self.head = new_node;
                self.incLen();
                return;
            }
            var cur = self.head;
            while (cur.?.next) |node|{
                cur = node.next;
            }

            cur.?.next = new_node;
            self.incLen();
        }

        pub fn remove(self: *Self) void {
            if(self.head == null) return;
            self.head = self.head.?.next;
            self.decLen();
        }

        pub fn pop(self: *Self) ?*ListNode {
            if (self.head == null) return null;
            const retNode = self.head.?;
            self.remove();
            return retNode;
        } 

        fn decLen(self: *Self) void {
            if (self.length == 0) {
                @panic("length underflow");
            }
            self.length -= 1;
        }

        fn incLen(self: *Self) void {
            self.length += 1;
        }

        pub fn get(self: *Self) ?*ListNode {
            return self.head;
        }

        pub fn getByIndex(self: *Self, index: usize) ?*ListNode {
            if (self.head == null or index >= self.length) return null;
            var cur = self.head;
            var i: usize = 0;
            while (cur) |node| {
                if (i == index) return node;
                cur = node.next;
                i += 1;
            }
            return null;
        }

        pub fn printList(self: *Self) !void { 
            if(self.head == null) return;
            var cur = self.head;
            while(cur) |node| {
                std.debug.print("{any}", .{node.payload});
                if (node.next != null) std.debug.print(" -> ", .{});
                cur = node.next;
            }
        }

        pub fn deinit(self: *Self) void {
            var cur = self.head;
            while (cur) |node| {
                const next = node.next;
                self.allocator.destroy(node);
                cur = next;
            }
        }

    };
}