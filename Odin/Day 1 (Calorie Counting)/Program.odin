package AoC

import "core:os"
import "core:strings"
import "core:strconv"
import "core:fmt"


main :: proc()
{
    data := unwrap(os.read_entire_file("input.txt"))

    defer delete(data, context.allocator)

    lines := string(data)
    dwarves := make_dynamic_array_len_cap([dynamic]u32, 1, 16)

    for line in strings.split_lines_iterator(&lines)
    {
        if line == "" do append(&dwarves, 0)
        else
        {
            value := unwrap(strconv.parse_uint(line))
            peek(dwarves)^ += u32(value)
            
        }
    }

    {
        largestIndex := -1
        largestDwarf := -1
        for dwarf, i in dwarves
        {
            dwarf : int = int(dwarf)
            if dwarf > largestDwarf
            {
                largestDwarf, largestIndex = dwarf, i          
            }
        }
        fmt.printf("Largest Dwarf %i: %ical\n", largestIndex, largestDwarf)
    }
    
}

unwrap :: proc(value : $T, ok : bool, loc := #caller_location) -> T
{
    if !ok do panic("Could not unwrap", loc)
    else do return value
}
peek :: proc(arr : [dynamic]$T) -> ^T
{
    return &arr[len(arr)-1]
}