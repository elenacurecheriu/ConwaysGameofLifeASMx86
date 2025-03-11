# Conway's Game of Life in Assembly x86 - AT&T syntax

Project written for the Computing Systems Architecture course (2023 - 2024).

## General theme and rules
The purpose of this zero-player game is to observe the evolution of a system of cells, starting from an initial configuration, by introducing rules regarding the death and creation of new cells in the system. This evolving system is Turing-complete.

The state of a system is described by the cumulative state of its component cells, and for these, we have the following rules:  

1. **Underpopulation.** Any cell (that is alive in the current generation) with fewer than two live neighbors dies in the next generation.  
2. **Survival of live cells.** Any cell (that is alive in the current generation) with two or three live neighbors will continue to exist in the next generation.  
3. **Overpopulation.** Any cell (that is alive in the current generation) with more than three live neighbors dies in the next generation.  
4. **Reproduction.** A dead cell that has exactly three live neighbors will become alive in the next generation.  
5. **Persistence of dead cells.** Any other dead cell that does not meet the reproduction rule remains dead.

The cells are represented in a bidimensional array, which can take the values 0 or 1, i.e. dead or alive.

## Key features

- Written in Assembly x86
- Optimized matrix traversal using registers and pointer arithmetic for minimal computation overhead.
- Implements neighbor counting with direct memory access to speed up cell state calculations.
- Direct manipulation of registers (%eax, %ebx, %ecx, etc.) for low-level control and performance tuning.
- Efficient looping constructs that minimize CPU cycles and branch mispredictions.
- Manages memory for two matrices (one for the grid and another for neighbor counts) with efficient space allocation, ensuring smooth transitions between iterations by updating only necessary grid cells
- Uses system calls and standard I/O functions to maintain compatibility across Unix-like systems
- Specific for task 0x02: I/O operations are file-based, not console-based; uses C standard library functions (fopen, fscanf, fprintf, fclose) to handle file operations efficiently

## Input format:

```
m     # number of rows
n     # number of columns
p     # number of live cells
x1
y1    # (x1, y1) - coordinates of first live cell
x2
y2    # (x2, y2) - coordinates of first live cell
...   # continue reading the remaining coordinates
k     # number of generations
```

Depending on the task (0x00 or 0x02), the input is either console or file-based. In case of file-based input, the input file is called `in.txt`.

### Example:
```
3                                    # 3 rows, 4 columns, 5 live cells with the following coordinates:
4                                    # (0, 1); (0, 2); (1, 0); (2, 2); (2, 3)
5                                    # the algorithm passes through k = 5 generations
0
1 
0
2 
1
0 
2
2
2
3 
5 
```
## Output:

The output contains the final iteration of the game, after following the rules mentioned above. In case of file-based output, the result is stored in `out.txt`.

### Example:

After entering the above input:

```
0 0 0 0
0 0 0 0
0 0 0 0
```
