module Interpolation where

-- lagrange interpolation: use points to approximate in-between points
-- the approximation improves as the number of points increases
lagrange x = x

-- taylor interpolation: use derivatives at a point to approximate nearby points
-- the approximation improves as the number of derivatives increases
taylor x = x

-- factorial function for taylor interpolation impl
factorial n = product [1..n]
