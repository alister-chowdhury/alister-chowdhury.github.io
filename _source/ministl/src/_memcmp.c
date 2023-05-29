

// Could probably optimize this better
int memcmp(const void* _a, const void* _b , __SIZE_TYPE__ n)
{
    const unsigned char* a = _a;
    const unsigned char* b = _b;
    for(__SIZE_TYPE__ i=0; i<n; ++i)
    {
        if(a[i] == b[i]) { continue; }
        return (a[i] < b[i] ? -1 : 1);
    }
    return 0;
}
