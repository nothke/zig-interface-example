const std = @import("std");
const interface = @import("interface.zig");
const Interface = interface.Interface;
const SelfType = interface.SelfType;

const Shape = Interface(struct {
    area: *const fn (*SelfType) f32, // even if it's immutable it needs to be a pointer
    circumference: *const fn (*SelfType) f32,
    shapeName: *const fn () []const u8,
}, interface.Storage.NonOwning);

const Rectangle = struct { // : Shape
    length: f32,
    width: f32,

    const Self = @This();

    pub fn area(self: Self) f32 {
        return self.length * self.width;
    }

    pub fn circumference(self: Self) f32 {
        return self.length * 2 + self.width * 2;
    }

    pub fn shapeName() []const u8 {
        return "rectangle";
    }
};

const Circle = struct { // : Shape
    radius: f32,

    const Self = @This();
    const pi = 3.14;

    pub fn area(self: Self) f32 {
        return 2 * self.radius * pi * pi;
    }

    pub fn circumference(self: Self) f32 {
        return pi * self.radius * self.radius;
    }

    pub fn shapeName() []const u8 {
        return "circle";
    }
};

pub fn main() !void {

    // Create shapes:
    var rect = Rectangle{ .length = 2, .width = 3 };
    var circ = Circle{ .radius = 2 };

    // Grab "base" shapes
    var rectShape = try Shape.init(&rect);
    rectShape.deinit();
    var circShape = try Shape.init(&circ);
    circShape.deinit();

    // Add them into an array and output
    var arrOfShapes = [2]Shape{ rectShape, circShape };

    rect.length = 10;

    for (arrOfShapes) |shape| {
        std.log.info("area of {s} is: {}", .{ shape.call("shapeName", .{}), shape.call("area", .{}) });
    }
}
