pub const Node = struct {
    payload: []const u8,
    next:    ?*Node,
    prev:    ?*Node 
};