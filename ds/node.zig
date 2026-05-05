pub const node = struct {
    payload: []const u8,
    next:    ?*node,
    prev:    ?*node 
};