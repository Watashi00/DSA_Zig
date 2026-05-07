pub fn Node(comptime T: type) type {
    return struct {
        payload: T,
        next: ?*@This(),
        prev: ?*@This(),
    };

}