#include "r128/r128.h"


struct R128_3
{
    R128 x{};
    R128 y{};
    R128 z{};

    R128_3() = default;
    R128_3(const R128_3&) = default;
    R128_3(const R128& x_, const R128& y_, const R128& z_) : x(x_), y(y_), z(z_) {};
    R128_3(double x_, double y_, double z_) : x(x_), y(y_), z(z_) {};
};


struct R128_3x3
{
    R128 M[3][3] {};

    R128_3x3 operator*(const R128_3x3& B) const
    {
        R128_3x3 result {};
        for(int i=0; i<3; ++i)
        for(int j=0; j<3; ++j)
        for(int k=0; k<3; ++k)
        {
            result.M[i][j] +=  M[i][k] *  B.M[k][j];
        }
        return result;
    }

    R128_3 operator*(const R128_3& P) const
    {
        R128_3 result
        {
            M[0][0]*P.x + M[0][1]*P.y + M[0][2]*P.z,
            M[1][0]*P.x + M[1][1]*P.y + M[1][2]*P.z,
            M[2][0]*P.x + M[2][1]*P.y + M[2][2]*P.z
        };
        return result;
    }
};

