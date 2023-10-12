const std = @import("std");
const componentZig = @import("component.zig");
const Component = componentZig.Component;
const CompoData = componentZig.CompoData;
const Object = @import("main.zig").Object;

pub const MyComponent = struct { // : Component
    pub fn start(self: *MyComponent, data: CompoData) void {
        _ = data;
        _ = self;
        std.log.info("My Thing", .{});
    }
};

pub const Mover = struct { // : Component
    velo: f32 = 0,

    pub fn start(self: *Mover, data: CompoData) void {
        _ = data;
        std.log.info("Mover here! The num is: {}", .{self.velo});
    }

    pub fn update(self: *Mover, data: CompoData) void {
        data.object.a += self.velo;
        std.log.info("Mover here! The num is: {d:.2}", .{data.object.a});
    }
};
