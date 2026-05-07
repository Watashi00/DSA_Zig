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

        pub fn append(self: *Self, content: T) !void {
            const new_node = try self.allocator.create(content);
            new_node.* = ListNode {
                .payload = content,
                .next = null,

            };
            if (self.head == null) {
                self.head = new_node;
                //TODO: Create an incLen function and implement here
                return;
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