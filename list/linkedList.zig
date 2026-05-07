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

    };
}