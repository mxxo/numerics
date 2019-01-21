-- implementations of two common interpolation methods
--
-- -> the most important thing for an accurate approximation is the
--    choice of data points. This will depend on the function but a random
--    selection is probably an OK start
-- NOT super performant -> uses Haskell's linked list instead of Array

module Interpolation where

-- lagrange interpolation: use points to approximate in-between points
-- the approximation improves as the number of points increases
-- -> can think of this method as a summation of lines at the point of interest
--
-- Given a list of abscissas xs and list of ordinates ys of equal lengths and
-- a point of interest xi, approximate the "y" value at that point
--
-- (thought about using FixedList to ensure the lists have the same length but
-- went with the Maybe monad instead)
lagrange :: (Fractional a) => [a] -> [a] -> a -> Maybe a
lagrange [] _ _   = Nothing -- handle empty lists
lagrange xs ys xi = if length xs /= length ys then Nothing -- handle uneven lists
                    else Just yi where -- interpolate that bad boy
                            -- ixs = [0..length xs - 1]
                            xs_ix = zip xs [0..] -- makes a list of indexed tuples
                            yi = 12


-- taylor interpolation: use derivatives at a point to approximate nearby points
-- the approximation improves as the number of derivatives increases
-- -> looks at how the function is changing to make approximations
taylor x = x

-- factorial function for taylor interpolation impl
factorial n = product [1..n]

-- elt deletion helper function for lagrange impl
-- (from https://wiki.haskell.org/How_to_work_on_lists)
removeAt :: Int -> [a] -> [a]
removeAt i xs = ys ++ tail zs where
                 (ys, zs) = splitAt i xs
