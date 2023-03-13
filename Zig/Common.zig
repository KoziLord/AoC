const std = @import("std");
pub fn openDay(allocator : std.mem.Allocator, day : i32) ![]const u8
{
    const relPath = try std.fmt.allocPrint(allocator, "../../INPUTS/Day{}.txt", .{day});
    defer allocator.destroy(relPath);
    const path = try std.fs.Dir.realpathAlloc(undefined, allocator, relPath);
    defer allocator.destroy(path);
    
    const file = try std.fs.openFileAbsolute(path, std.fs.File.OpenFlags{});
    return try std.fs.File.readToEndAlloc(file, allocator, std.math.maxInt(usize));
}