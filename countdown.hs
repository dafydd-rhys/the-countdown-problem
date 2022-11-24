import Data.List (permutations, subsequences)

data BinOp = Plus | Minus | Times | Div 
    deriving (Show, Eq, Enum)

data Expr = Const Int | Op BinOp Expr Expr 
    deriving (Show, Eq)

-- returns all possible solutions (in an expression) for target number using the passed list of numbers
solutions :: [Int] -> Int -> [Expr]
solutions [] _ = []
solutions _  0 = []
solutions xs x = [e | ys <- [zs | z <- subsequences xs, zs <- permutations z], e <- int2Expr ys, expr2Int e == [x]] -- expression must equal target

-- converts a passed list of integers into a list of all possible expressions (+, *)
int2Expr :: [Int] -> [Expr] 
int2Expr []  = []
int2Expr [x] = [Const x]
int2Expr xs  = [x | (ls, rs) <- splits xs, l <- int2Expr ls, r <- int2Expr rs, x <- [Op op l r | op <- [Plus, Times, Div, Times]]]

-- enumerates all possible ways of splitting the passed list
splits :: [Int] -> [([Int], [Int])]
splits []     = []
splits [_]    = []
splits (x:xs) = ([x], xs) : [(x:l, r) | (l, r) <- splits xs]

-- converts expression into int, returns [0] if invalid
expr2Int :: Expr -> [Int]
expr2Int (Const x)   = [x | x >= 1]
expr2Int (Op op l r) = [apply op x y | x <- expr2Int l, y <- expr2Int r]

-- returns result of operation on expression, if its not valid returns 0 instead
apply :: BinOp -> Int -> Int -> Int
apply op x y | op == Plus  && x + y > 0 = x + y
                      | op == Times && x * y > 0 = x * y
                      | op == Minus && x - y > 0 = x - y -- not negative
                      | op == Div   && x > 0 && y > 0 && x `mod` y == 0 = x `div` y -- not decimal
                      | otherwise = 0 -- target value cant be 0