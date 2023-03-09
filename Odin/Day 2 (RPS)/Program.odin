package AoC

import "core:os"
import "core:strings"
import "core:fmt"

Shape :: enum
{
    Rock,
    Paper,
    Scissors,
}
main :: proc()
{
    data := unwrap(os.read_entire_file("input.txt"))
    defer delete(data, context.allocator)

    lines := string(data)
    
    score := 0
    for line in strings.split_lines_iterator(&lines)
    {
        opponent := Shape(line[0] - 'A')
        player := Shape(line[2] - 'X')
        
        score += judge(player, opponent)
        score += int(player) + 1
    }

    fmt.println(score)
}


judge :: proc(player, opponent : Shape) -> int
{
    @static ScoreTable := [9]int{
        3, 0, 6,
        6, 3, 0,
        0, 6, 3,
    }
    score := ScoreTable[int(player) * 3 + int(opponent)]
    fmt.printf("P: %s, O: %s, R: %i\n", player, opponent, score)
    return score
}
unwrap :: proc(value : $T, ok : bool, loc := #caller_location) -> T
{
    if !ok do panic("Could not unwrap", loc)
    else do return value
}