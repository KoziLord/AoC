package AoC

import "core:os"
import "core:fmt"
import "core:strings"
import "core:strconv"
import "../Common"

main :: proc()
{
    
    lines := Cmn.load_day(3)

    buf := [128]byte{}
    
    readBytes, _ := os.read(os.stdin, buf[:])

    switch unwrap(strconv.parse_int(string(buf[:readBytes - 2])))
    {
        case 1: part_one(&lines)
        case 2: part_two(&lines)
        case: panic("Invalid part")
    }
}
part_one :: proc(lines : ^string)
{
    sum := 0
    for line in strings.split_lines_iterator(lines)
    {
        line := transmute([]byte)line
        l := len(line)/2
        comp := [2][]byte {
            line[:l],
            line[l:],
        }

        set := [64]byte{}
        
        for v in comp[0] do set[to_index(v)] |= 1
        for v in comp[1] do set[to_index(v)] |= 2

        for v, i in set
        {
            if v == 3
            {
                sum += i + 1
                break
            }
        }
        
    }

    fmt.println(sum) 
}

part_two :: proc(lines : ^string)
{
    sum := 0
    set := [64]byte{}
    i : uint = 0

    for line in strings.split_lines_iterator(lines)
    {
        line := transmute([]byte)line        
        
        for v in line do set[to_index(v)] |= 1 << i
    
        if i == 2
        {
            for v, j in set
            {
                if v == 1 + 2 + 4
                {
                    sum += j + 1
                    break
                }
            }

            set = {}
            i = 0
        }
        else do i += 1
    }

    fmt.println(sum) 
}

to_index :: proc(ascii : byte) -> int
{
    return int(ascii - 'a' if ascii >= 'a' else ascii - 'A' + 26)
}
unwrap :: proc(value : $T, ok : bool, loc := #caller_location) -> T
{
    if !ok do panic("Could not unwrap", loc)
    else do return value
}