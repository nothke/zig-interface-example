const std = @import("std");
const interface = @import("interface.zig");
const Interface = interface.Interface;
const SelfType = interface.SelfType;
const Component = @import("component.zig").Component;
const CompoData = @import("component.zig").CompoData;
const MyComponent = @import("my_component.zig").MyComponent;
const Mover = @import("my_component.zig").Mover;

pub const Object = struct {
    a: f32 = 0,
    component: ?Component = null,

    fn addComponent(self: *Object, compo: anytype) !void {
        self.component = try Component.init(compo);
    }
};

pub fn main() !void {
    var objects = std.BoundedArray(Object, 256){};
    var obj = objects.addOneAssumeCapacity();
    var obj2 = objects.addOneAssumeCapacity();
    _ = obj2;
    var obj3 = objects.addOneAssumeCapacity();

    var compo = MyComponent{};
    try obj.addComponent(&compo);

    var mover = Mover{ .velo = 2 };
    try obj3.addComponent(&mover);

    for (objects.slice()) |*o| {
        if (o.component) |component| {
            component.call("start", .{CompoData{ .dt = 1, .object = o }});
        }
    }

    // update
    for (0..10) |_| {
        for (objects.slice()) |*o| {
            if (o.component) |component| {
                _ = component.call("update", .{CompoData{ .dt = 1, .object = o }});
            }
        }
    }
}
