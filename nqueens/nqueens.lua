-- N_Queens problem solving algorithm implementation
-- Uses Backtracking and recursion
-- See: http://en.wikipedia.org/wiki/Eight_queens_puzzle

-- Create a NxN matrix
local function makeBoard(size)
    local board = {}
    for i = 0, size do
        board[i] = {}
        for j = 1, size do
            board[i][j] = 0
        end
    end
    return board
end

-- check if a queen can be assigned to board[x][y]
local function isLegit(board, x, y, N)
    for i = 1, x - 1 do
        local notAllowed = board[i][y] == 1 or
              ( i <= y and board[x - i][y - i] == 1 ) or
              ( i + y <= N and board[x - i][y + i] == 1)
        if notAllowed then return false end
    end
    return true
end

-- Solves recursively the N_Queens puzzle
local function solve(board, x, N)
    for y = 1, N do
        if isLegit(board, x, y, N) then
            -- try at board[x][y]
            board[x][y] = 1
            if x == N or solve(board, x + 1, N) then
                return true end    -- forward searching
            board[x][y] = 0        -- back tracing
        end
    end
    return false
end

local function queens(N)
    board = makeBoard(N)
    local solved = solve(board, 1, N)
    assert(solved, 'Solution not found')
    return board
end

return queens
