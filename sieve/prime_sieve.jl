"""Sieve of Eratosthenes function docstring"""
function es(n::Int) # one integer argument
    isprime = trues(n) # n-elt vector of true
    isprime[1] = false # since 1 is not prime
    for i in 2:isqrt(n) # loop odd ints less or equal to sqrt(n)
        if isprime[i] # conditonal evaluation
            for j in i^2:i:n # sequence with step i
                isprime[j] = false
            end
        end
    end
    return filter(x -> isprime[x], 1:n) # filter using anonymous fn
end

println(es(100)) # print all primes less or equal to 100
@time length(es(10^6)) # check fn execution time and memory usage
