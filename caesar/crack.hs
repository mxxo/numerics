-- Naive caesar cipher cracker
-- Taken from Graham Hutton's Programming in Haskell, Chapter 5

import Data.Char

-- lowercase letters to their Int equivalents offset from 'a' (97)
letter2Int :: Char -> Int
letter2Int l = fromEnum l - fromEnum 'a'

-- take an Int and encode it as a lowercase Char (starting at 0 -> 'a')
-- inverse operation of letter2Int
int2Letter :: Int -> Char
int2Letter i = toEnum (i + fromEnum 'a')

-- shift a given lowercase letter along the alphabet
-- acts as identity function for non-lowercase letters
shift :: Int -> Char -> Char
shift n c | isLower c = int2Letter $ (letter2Int c + n) `mod` 26
          | otherwise = c

-- encode a String using a shift
-- can decode using a negative shift value
encode :: Int -> String -> String
encode n xs = [shift n x | x <- xs]

decode n xs = encode (-n) xs

-- given frequency table for english letters
freq_table :: [Float]
freq_table = [8.2, 1.5, 2.8, 4.3, 12.7, 2.2, 2.0, 6.1, 7.0, 0.2, 0.8, 4.0, 2.4,
              6.7, 7.5, 1.9, 0.1, 6.0, 6.0, 9.1, 2.8, 1.0, 2.4, 0.2, 2.0, 0.1]

-- percent function for Int values
percentInt :: Int -> Int -> Float
percentInt n m = (fromIntegral n / fromIntegral m) * 100

-- count how many occurences of this letter there are
count :: Char -> String -> Int
-- nice unorthodox use of the sum function here paired with list comprehension
count x xs = sum [1 | c <- xs, c == x]

-- get the positions of an Eq instance in a list
positions :: Eq a => a -> [a] -> [Int]
positions x xs = [i | (x', i) <- zip xs [0..n], x == x']
                    where n = length xs - 1

-- get the number of lowercase letters in the string
lowers :: String -> Int
lowers xs = sum [1 | x <- xs, x >= 'a', x <= 'z']

-- frequency analysis of a String's lowercase letters for any string
frequency_analysis :: String -> [Float]
frequency_analysis xs = [percentInt (count x xs) n | x <- ['a'..'z']]
                            where n = lowers xs

-- chi-square test for string differences
-- observed frequencies -> os
-- expected frequencies -> es
-- smaller is better
chi_square :: [Float] -> [Float] -> Float
chi_square os es = sum [(o - e) ** 2 / e | (o, e) <- zip os es]

-- rotate left function for arrays
rotate :: Int -> [a] -> [a]
rotate n xs = drop n xs ++ take n xs

-- finally, the crack function pieces together the earlier functions to find
-- the minimun chi-square value and propose it as the solution
crack :: String -> String
crack xs = decode factor xs
    where
        factor = head $ positions (minimum chi_table) chi_table
        chi_table = [chi_square (rotate n table) freq_table | n <- [0..25]]
        table = frequency_analysis xs

