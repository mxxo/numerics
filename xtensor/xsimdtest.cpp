#include <cstddef>
#include <vector>
#include "xsimd/xsimd.hpp"
#include "xsimd/stl/algorithms.hpp"

namespace xs = xsimd;
using vector_type = std::vector<double, xsimd::aligned_allocator<double, XSIMD_DEFAULT_ALIGNMENT>>;

void mean(const vector_type& a, const vector_type& b, vector_type& res)
{
        xsimd::transform(a.begin(), a.end(), b.begin(), res.begin(),
                                     [](const auto& x, const auto& y) { (x + y) / 2.; });
}
