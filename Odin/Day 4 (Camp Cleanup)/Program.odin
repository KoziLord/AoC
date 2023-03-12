package AoC

import "core:os"
import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:encoding/json"
import Cmn "../Common"

main :: proc()
{
    solution :: part2

    lines := Cmn.load_day(4)
    count := 0
    for line in strings.split_lines_iterator(&lines)
    {
        line := line
        i := 0

        ranges := [2][2]int{}

        //Parse
        for val in strings.split_iterator(&line, ",")
        {
            val := val
            defer i += 1

            j := 0
            for v in strings.split_iterator(&val, "-")        
            {
                defer j += 1

                ranges[i][j] = unwrap(strconv.parse_int(v))
            }
        }

        //Reorder ranges
        a, b : [2]int
        if ranges[0][0] < ranges[1][0]
        {
            a = ranges[0]
            b = ranges[1]
        }
        else if ranges[0][0] == ranges[1][0]
        {
            if ranges[0][1] > ranges[1][1]
            {
                a = ranges[0]
                b = ranges[1]
            }
            else
            {
                a = ranges[1]
                b = ranges[0]
            }
        }
        else
        {
            a = ranges[1]
            b = ranges[0]
        }

        count += int(solution(a, b))
    }

    fmt.println(count)
}

part1 :: proc(a, b : [2]int) -> bool
{ 
    return a[1] >= b[1]  
}

part2 :: proc(a, b : [2]int) -> bool
{ 
   return b[0] <= a[1]
}
/*

x12345678x
xx234567xx
=>
1-8
2-7
=>
0-7
1-6

xxx3456xxx
xx2345678x
=>
3-6
2-8
=>
0 -3
-1-5
//least offset range instead
=>
1-4
0-6
=> //reorder
0-6
1-4

*/

unwrap :: proc(value : $T, ok : bool, loc := #caller_location) -> T
{
    if !ok do panic("Could not unwrap", loc)
    else do return value
}