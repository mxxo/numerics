#include <array>
#include <iostream>

#include "mandy.hpp"

int main() {

    // pixel count for mandelbrot sim
    constexpr auto x_count = 1920;
    constexpr auto y_count = 1080;
    constexpr auto total_pixels = x_count * y_count;

    std::array<cmplx<long double>, total_pixels> pxs;

    std::cout << "index of elt 0, 1 is " << getIndex<x_count> (0, 1) << std::endl;
    cmplx <long double> c {1.0, 1.0};

    return 0;
}
