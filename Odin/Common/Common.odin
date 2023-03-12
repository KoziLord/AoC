package Common

import path "core:path/filepath"
import "core:fmt"
import "core:os"

load_day :: proc(day : int) -> string
{
    p, _ := path.abs("./../../INPUTS/Day%i%s", context.temp_allocator)
    
    str := fmt.tprintf(p, day, ".txt")
    if file, ok := os.read_entire_file(str); ok
    {
        return string(file)
    }
    else
    {
        panic(fmt.tprintf("Couldn't open file:\n%s", str))
    }
}
