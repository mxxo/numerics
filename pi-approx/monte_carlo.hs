-- Calculating pi using a Monte Carlo approximation
-- Not too bad once you remember how the nice way in C++ is
-- with a static object etc etc

import System.Random

-- Unit circle has radius 1 -> if sqrt (x ^ 2 + y ^ 2) > 1.0 not inside circle
-- only works on Doubles, would be nicer to have typeclass constraints here
insideUnitCircle :: (Double, Double) -> Bool
insideUnitCircle (x, y) = sqrt((abs x) ** 2 + (abs y) ** 2) <= 1.0

-- get a list of random numbers between -1 and 1 (represents numbers with the square of
-- side lengths 2 centered at the origin
-- important! given the same seed, the same sequence will always be generated
-- to avoid this, we can feed in a random number as the seed
getUnitRandoms :: (Random a, Fractional a) => Int -> Int -> [a]
getUnitRandoms n seed = take n (randomRs (-1.0, 1.0) (mkStdGen seed))

-- finally, this is the function that estimates pi -> takes about 30 seconds to
-- get at 4 correct digits on my machine
-- had to ask ghci the type for this one
estimatePi :: Fractional a => [(Double, Double)] -> a
estimatePi coords = 4.0 * num_inside / num_total where
            num_total = fromIntegral $ length coords
            num_inside = (fromIntegral $ length $ filter insideUnitCircle coords)

-- monte carlo demo
main :: IO ()
main = do
    putStrLn "Monte carlo pi calculation demo"
    putStrLn "Please enter the number of iterations to approximate pi with: "
    iter_input <- getLine
    let iters = (read iter_input :: Int)
    putStrLn ("Calculating pi for " ++ show iters ++ " iterations")

    -- rando calrissians
    gen <- getStdGen
    -- get x seed and state for y random num
    let (x_seed, new_gen_state) = next gen
    let (y_seed, _) = next new_gen_state
    putStrLn ("The random seeds for x and y are " ++ show x_seed ++ " and "
                                                  ++ show y_seed)
    -- make list of tuples and estimate pi
    let coords = zip (getUnitRandoms iters x_seed) (getUnitRandoms iters y_seed)
    let pi_approx = estimatePi coords
    putStrLn("pi is estimated as " ++ show pi_approx)
