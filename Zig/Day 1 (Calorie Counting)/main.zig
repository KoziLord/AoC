const std = @import("std");
const Cmn = @import("Common");
const mem = std.mem;
const fs  = std.fs;
const dir = std.fs.Dir;

pub fn main() !void 
{
    const o = std.io.getStdOut().writer();

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);  
    const allocator = arena.allocator();
    
    const lines = try Cmn.openDay(allocator, 1);
    var it = std.mem.split(u8, lines, "\n");
    var dwarves = try std.ArrayList(i32).initCapacity(allocator, 1024);
    dwarves.append(0) catch undefined;
    while (it.next()) |line|
    {  
        if (mem.eql(u8, line, ""))
        {
            dwarves.append(0) catch undefined;
        }
        else
        {
            const num = std.fmt.parseInt(i32, line, 10) catch @panic("Couldn't parse");
            peek(i32, dwarves).* += num;
        }
    }

    {
        var largestIndex : i32 = 0;
        var largestDwarf : i32 = 0;
        var i : i32 = 0;
        for (dwarves.items) |dwarf|
        {
            defer i += 1;
            if (dwarf > largestDwarf)
            {
                largestDwarf = dwarf;
                largestIndex = i;
            }
        }

        o.print("Largest Dwarf {}: {}cal\n", .{largestIndex, largestDwarf}) catch undefined;
    }
}

pub fn peek(comptime T : type, list : std.ArrayList(T)) *T
{
    return &list.items[list.items.len-1];
} 


