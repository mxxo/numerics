# example using julia 1.0.3
# -- run using julia fit.jl or include("fit.jl") in repl
#
# like rust, functions in julia can either use an explicit return statement or
# in the absence of one, will evaluate to the last expression in the function

# include if plotting
# using Gadfly

# -- functions
"""find_coeffs: given arrays x, y of length n for a 2D function y = f(x),
                return coefficients for a fitted polynomial of order n"""
function find_coeffs(x::AbstractArray, y::AbstractArray)
    # first thought to use @assert,
    # but after reading https://github.com/JuliaLang/julia/issues/30610
    # found that check() || error(...) preferred over @assert exceptions
    length(x) == length(y) || error("Uneven arrays in find_coeffs")

    # we isolate for the coefficient vector a = [a0, a1, a2, ...] in the
    # expression y = B a .
    # The n by n matrix B has rows of [x0 ^ 0, x0 ^ 1, x0 ^ 2, ...]

    # populate a matrix of these rows using matrix comprehension
    B = [x_i ^ n for x_i in x, n in 0:length(x) - 1]

    # find the coeffecient vector and return it
    inv(B) * y
end

# type constraint here is used to only allow vectors passed in
# -- where T allows T to range over all concrete types
"""Interpolate using the polynomial coefficient values 'coeffs' and the given
argument 'arg'"""
function coeff_interpolate(coeffs::AbstractArray{T,1}, arg) where T
    sum([coeffs[i] * arg ^ (i-1) for i in eachindex(coeffs)])
end

# -- examples --

# ex 1 -> pass in three x and three y values for a parabolic fit
parabola_coeffs = find_coeffs([1,2,3], [1,4,9])
println("The coefficients for points along x^2 are:")
println(parabola_coeffs)
println()

# ex 2 -> pass uneven arrays for length check
# bad_coeffs = find_coeffs([1], [])

# ex 3 -> check the default scalar type in the array
println("Default vector type:")
println(typeof(find_coeffs([1], [1])));
println()

# ex 4 -> force the return vector to be of Float16's
f16_coeffs = find_coeffs(Vector{Float16}([1, 3, 5]), [2, 3, 9])
println("Array type coerced to:")
println(typeof(f16_coeffs), "\n")

# ex 5 -> interpolation
println("The interpolated value at x = 4 for a model of the unit parabola:")
println(coeff_interpolate(parabola_coeffs, 4), "\n")

# # ex 6 -> plotting
# println("Plotting the quadratic fit from zero to ten as output.svg")
# x = 1:10
# y = [coeff_interpolate(parabola_coeffs, xi) for xi in x]
#
# # write output file
# # -- took ~4GiB memory and roughly 30 seconds to plot (output was only 9.6 kB)
#
# # @time draw(SVG("output.svg", 6inch, 3inch), plot(x=x, y=y, Geom.point, Geom.line))

