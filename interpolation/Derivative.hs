-- quick and dirty derivative for functions of one variable

module Derivative where

-- given a function f of x and a small number h, return an
-- approximation to the first derivative of f at x
--
-- For best results, pass in Scientific number instances
rough_deriv :: (Fractional a) => (a -> a) -> a -> a -> a
rough_deriv f x h = (f (x + h) - f x) / h
