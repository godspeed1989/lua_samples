-- Sudoku solver implementation
-- Uses Backtracking and recursion
-- See : http://en.wikipedia.org/wiki/Sudoku

-- check if num exists on a row
local function rowNotHasNum(sudoku, row, num)
    for column = 1, 9 do
        if sudoku[row][column] == num then
            return false end
    end
    return true
end

-- check if num exist on a column
local function columnNotHasNum(sudoku, column, num)
    for row = 1, 9 do
        if sudoku[row][column] == num then
            return false end
    end
    return true
end

-- Given a location, identifies the corresponding 3x3 box
-- and checks if num exists in this box
local function boxNotHasNum(sudoku, row, column, num)
    row = math.floor((row - 1) / 3) * 3 + 1
    column = math.floor((column - 1) / 3) * 3 + 1
    for r = 0, 2 do
        for c = 0, 2 do
            if sudoku[row + r][column + c] == num then
                return false
            end
        end
    end
    return true
end

-- check if num can be assigned to sudoku[row][column]
local function isLegit(sudoku, row, column, num)
    return rowNotHasNum(sudoku, row, num)
       and columnNotHasNum(sudoku, column, num)
       and boxNotHasNum(sudoku, row, column, num)
end

-- check if the sudoku is solved
-- if not returns false, plus the first unassigned cell
local function isSolved(sudoku)
    for row = 1, 9 do
        for column = 1, 9 do
            if sudoku[row][column] == 0 then
                return false, row, column
            end
        end
    end
    return true
end

local function solve_sudoku(sudoku)
    local solved, row, column = isSolved(sudoku)
    if solved then return true end
    -- try at (row,column)
    for num = 1, 9 do
        if isLegit(sudoku, row, column, num) then
            sudoku[row][column] = num
            if solve_sudoku(sudoku) then
                return true end     -- forward searching
            sudoku[row][column] = 0 -- back tracing
        end
    end
    return false
end

return solve_sudoku
