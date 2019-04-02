// mandelbrot data types
// let's try out a bunch of different ones

#include <cmath>

// #1 -> array of cmplx structs
// #2 -> two seperate arrays of real and imaginary coords

template <int stride>
auto inline getIndex(int x, int y) -> int {
    return x + stride * y;
}

template <typename Precis>
struct cmplx {
    Precis r;
    Precis z;
};

template <typename Precis>
auto cmplx_mag (const cmplx<Precis>& num) {
    return sqrt (num.r * num.r + num.z * num.z);
}


