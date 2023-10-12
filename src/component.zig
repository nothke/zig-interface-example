const std = @import("std");
const interface = @import("interface.zig");
const Interface = interface.Interface;
const SelfType = interface.SelfType;
const Object = @import("main.zig").Object;

pub const CompoData = struct {
    object: *Object,
    dt: f32,
};

pub const Component = Interface(struct {
    start: *const fn (*SelfType, CompoData) void,
    update: ?*const fn (*SelfType, CompoData) void,
}, interface.Storage.NonOwning);
