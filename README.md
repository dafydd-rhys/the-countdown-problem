# the-countdown-problem
A simple and effective solution to "The Countdown Problem" completed in Haskell.

## Overview
The essence of the problem is as follows: given a sequence of source numbers and a single target number, attempt to construct an arithmetic expression using each of the source numbers at most once, and such that the result of evaluating the expression is the target number.

## How it works
Given a list of numbers ([Int]) and target number (Int) it will find all possible solutions using all operators (+, ×, ÷, -).

### Example: 
If your numbers were 44, 53, 23, 63 and the target was 3379068

solutions [44, 53, 23, 63] 3379068 = Op Times (Op Times (Op Times (Const 23) (Const 44)) (Const 63)) (Const 53)

it will return this expression in all possible combinations as these are also solutions
