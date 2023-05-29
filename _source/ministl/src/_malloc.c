
#define FORCEINLINE __attribute__((always_inline)) inline static
typedef __UINT8_TYPE__ u8;
typedef __SIZE_TYPE__ sz;
typedef __UINTPTR_TYPE__ uintptr;


#define IF_LIKELY(expr) if (__builtin_expect(!!(expr), 1))
#define IF_UNLIKELY(expr) if (__builtin_expect(!!(expr), 0))

#ifndef MALLOC_DEBUG
#define MALLOC_DEBUG 0
#endif // MALLOC_DEBUG


// Simplified malloc just uses a single unsorted bin, rather
// having specific bins for different sizes.
//
// This still needs implementing
#ifndef MALLOC_SIMPLE
#define MALLOC_SIMPLE 1
#endif // MALLOC_SIMPLE


#if !MALLOC_SIMPLE
#warning "Only simple malloc has been implemented at this time!"
#endif // !MALLOC_SIMPLE


#define WASM_EXPORT __attribute__((visibility("default")))

#if MALLOC_DEBUG
#define WASM_EXPORT_IF_DEBUG WASM_EXPORT
#else
#define WASM_EXPORT_IF_DEBUG
#endif // MALLOC_DEBUG


#ifndef USE_DYNAMIC_MEMORY
#if defined(__has_builtin) && __has_builtin(__builtin_wasm_memory_grow) && __has_builtin(__builtin_wasm_memory_size)
#define USE_DYNAMIC_MEMORY 1
#else
#define USE_DYNAMIC_MEMORY 0
#endif
#endif


#if MALLOC_DEBUG

#define MALLOC_ERROR_OK 0
#define MALLOC_ERROR_MISSED_ALLOCATION 1
#define MALLOC_ERROR_DOUBLE_ALLOCATION 2
#define MALLOC_ERROR_DOUBLE_FREE 3
#define MALLOC_ERROR_BAD_PAGE_ALLOC 4

static int last_error = MALLOC_ERROR_OK;

WASM_EXPORT int malloc_take_last_error()
{
    int err = last_error;
    last_error = MALLOC_ERROR_OK;
    return err;
}

#endif // MALLOC_DEBUG


#define _GRAINSIZE __BIGGEST_ALIGNMENT__
#define _PAGESIZE 65536
#define _TOMBSTONE __SIZE_MAX__
#define _ADDBYTES(addr, size) ((void*)((uintptr)addr + size))
#define _SUBBYTES(addr, size) ((void*)((uintptr)addr - size))
#define _MAXALLOC ((_TOMBSTONE - (_TOMBSTONE & (_GRAINSIZE - 1))) - sizeof(memblk))
#define _MINALLOC (sizeof(memblk))

#define _BIN_ALLOCATED 0
#define _BIN_UNSORTED 1
#define _BIN_SPECIFIC 2

#define _POP_MEMBLK_LINKS(blk)                                                                                         \
    {                                                                                                                  \
        blk->prev->next = blk->next;                                                                                   \
        blk->next->prev = blk->prev;                                                                                   \
    }

#define _PUSH_MEMBLK_LINKS(root, blk)                                                                                  \
    {                                                                                                                  \
        blk->prev = (root);                                                                                            \
        blk->next = (root)->next;                                                                                      \
        blk->next->prev = blk;                                                                                         \
        (root)->next = blk;                                                                                            \
    }


#if USE_DYNAMIC_MEMORY

FORCEINLINE int alloc_pages(sz n)
{
    return __builtin_wasm_memory_grow(0, n) != -1;
}


FORCEINLINE void* start_of_next_alloc()
{
    return (void*)(__builtin_wasm_memory_size(0) * _PAGESIZE);
}


#else // USE_DYNAMIC_MEMORY

// Default to 8MB of static memory
#ifndef STATIC_MEMORY_PAGES
#define STATIC_MEMORY_PAGES 128
#endif // STATIC_MEMORY_PAGES


static _Alignas(_PAGESIZE) u8 static_heap[STATIC_MEMORY_PAGES * _PAGESIZE];
static sz static_page = 0;

FORCEINLINE int alloc_pages(sz n)
{

    if ((static_page + n) > STATIC_MEMORY_PAGES)
    {
        return 0;
    }

    static_page += n;
    return 1;
}

FORCEINLINE void* start_of_next_alloc()
{
    return (void*)(&static_heap[static_page * _PAGESIZE]);
}

#endif // USE_DYNAMIC_MEMORY


typedef struct
{
    _Alignas(_GRAINSIZE) sz size; // Size in bytes of this allocation (including the header).
    sz prevsize;                  // This is set to zero, unless the previous block
                                  // has marked itself as free / available to coaelsce.
    sz bin;                       // Bin this currently in.
} memblk_header;


typedef struct memblk
{
    memblk_header header;
    struct memblk* prev; // double linked list to the previous free block.
    struct memblk* next; // double linked list to the next free block.
} memblk;


#define _GLOBAL_MEMPOOL(__globalvarname)                                                                               \
    {                                                                                                                  \
        {.size = _TOMBSTONE, .prevsize = 0, .bin = _BIN_ALLOCATED}, .prev = &__globalvarname, .next = &__globalvarname \
    }


static memblk unsorted_bin = _GLOBAL_MEMPOOL(unsorted_bin);
static memblk* top = 0;


FORCEINLINE memblk* allocate_new_memblk(sz bytes)
{
    // Extra bytes needed to fufil top
    sz alloc_bytes = bytes + sizeof(memblk);
    sz existing_bytes = 0;

    void* mem = start_of_next_alloc();
    int pop_existing_links = 0;

    // Merge with top, we may be able to allocate less
    // than the full range if we know we're just going
    // to merge with another allocation.
    //
    // This assumes that we've already searched for an
    // allocation and did not find one, otherwise the
    // number of bytes we allocate could underflow.

#if USE_DYNAMIC_MEMORY
    if (top && (_ADDBYTES(top, sizeof(memblk)) == mem))
#else  // USE_DYNAMIC_MEMORY
    if (top)
#endif // USE_DYNAMIC_MEMORY
    {
        mem = (void*)top;
        existing_bytes += sizeof(memblk);
        alloc_bytes -= sizeof(memblk);

        // Merge left of top
        if (top->header.prevsize)
        {

#if MALLOC_DEBUG
            // We were able to merge with another entry which
            // should have been used for allocation
            IF_UNLIKELY(top->header.prevsize >= bytes)
            {
                last_error = MALLOC_ERROR_MISSED_ALLOCATION;
                return 0;
            }

            IF_UNLIKELY(((memblk*)_SUBBYTES(top, top->header.prevsize))->header.bin == _BIN_ALLOCATED)
            {
                last_error = MALLOC_ERROR_DOUBLE_ALLOCATION;
                return 0;
            }

#endif // MALLOC_DEBUG

            mem = _SUBBYTES(top, top->header.prevsize);
            existing_bytes += top->header.prevsize;
            alloc_bytes -= top->header.prevsize;
            pop_existing_links = 1;
        }
    }

    sz num_pages = (alloc_bytes + _PAGESIZE - 1) / _PAGESIZE;

    IF_UNLIKELY(!alloc_pages(num_pages))
    {
        return 0;
    }

    if (pop_existing_links)
    {
        _POP_MEMBLK_LINKS(((memblk*)mem))
    }

    sz available_bytes = num_pages * _PAGESIZE + existing_bytes;
    sz main_blk_size = available_bytes - sizeof(memblk);

    memblk* blk = (memblk*)mem;
    blk->header.size = main_blk_size;
    blk->header.prevsize = 0;
    blk->header.bin = 0xffff;
    blk->prev = blk;
    blk->next = blk;

    memblk* newtop = (memblk*)_ADDBYTES(mem, main_blk_size);
    newtop->header.size = _TOMBSTONE;
    newtop->header.prevsize = main_blk_size;
    newtop->header.bin = _BIN_ALLOCATED;
    top = newtop;

    return blk;
}


WASM_EXPORT_IF_DEBUG void free(void* mem)
{
    if (!mem)
    {
        return;
    }

    memblk* blk = (memblk*)_SUBBYTES(mem, sizeof(memblk_header));

#if MALLOC_DEBUG
    IF_UNLIKELY(blk->header.bin != _BIN_ALLOCATED)
    {
        last_error = MALLOC_ERROR_DOUBLE_FREE;
        return;
    }
#endif // MALLOC_DEBUG


    if (blk->header.prevsize)
    {
        memblk* prev = ((memblk*)_SUBBYTES(blk, blk->header.prevsize));

#if MALLOC_DEBUG
        IF_UNLIKELY(prev->header.bin == _BIN_ALLOCATED)
        {
            last_error = MALLOC_ERROR_DOUBLE_ALLOCATION;
            return;
        }
#endif // MALLOC_DEBUG

        prev->header.size += blk->header.size;

#if !MALLOC_SIMPLE
        if (prev->header.bin != _BIN_UNSORTED)
        {
            _POP_MEMBLK_LINKS(prev);
        }
#endif // !MALLOC_SIMPLE

        blk = prev;
    }

    // If we merged with prev, might already be in the unsorted bin
    if (blk->header.bin != _BIN_UNSORTED)
    {
        blk->header.bin = _BIN_UNSORTED;
        _PUSH_MEMBLK_LINKS((&unsorted_bin), blk);
    }

    memblk* next = ((memblk*)_ADDBYTES(blk, blk->header.size));
    if (next->header.bin != _BIN_ALLOCATED)
    {
        _POP_MEMBLK_LINKS(next);
        blk->header.size += next->header.size;
        next = ((memblk*)_ADDBYTES(blk, blk->header.size));
    }

    next->header.prevsize = blk->header.size;
}


WASM_EXPORT_IF_DEBUG void* malloc(sz bytes)
{
    if (bytes == 0 || bytes > _MAXALLOC)
    {
        return 0;
    }

    // Align to grainsize
    bytes = ((bytes - 1) | (_GRAINSIZE - 1)) + 1;

    bytes += sizeof(memblk_header);
    if (bytes < _MINALLOC)
    {
        bytes = _MINALLOC;
    }

    memblk* found;

    do
    {
        // Search unsorted bin
        found = unsorted_bin.next;
        for (found = unsorted_bin.next; found->header.size < bytes; found = found->next)
        {
            // todo: correctly bin things if we're not doing simple logic
        }

        if (found->header.size != _TOMBSTONE)
        {
            break;
        }

        // todo: less simple logic bin test should go here

        found = allocate_new_memblk(bytes);

    } while (0);

    IF_LIKELY(found)
    {

#if MALLOC_DEBUG
        IF_UNLIKELY(found->header.bin == _BIN_ALLOCATED)
        {
            last_error = MALLOC_ERROR_DOUBLE_ALLOCATION;
            return 0;
        }

        IF_UNLIKELY(found->header.size == _TOMBSTONE)
        {
            last_error = MALLOC_ERROR_BAD_PAGE_ALLOC;
            return 0;
        }
#endif // MALLOC_DEBUG

        _POP_MEMBLK_LINKS(found);

        found->header.bin = _BIN_ALLOCATED;

        void* mem = _ADDBYTES(found, sizeof(memblk_header));

        // Split the found entry and repool back into unsorted
        if ((found->header.size - bytes) > sizeof(memblk))
        {
            sz split_size = found->header.size - bytes;
            memblk* split = (memblk*)_ADDBYTES(found, bytes);
            split->header.size = split_size;
            split->header.prevsize = 0;
            split->header.bin = _BIN_UNSORTED;
            ((memblk*)_ADDBYTES(found, found->header.size))->header.prevsize = split_size;
            _PUSH_MEMBLK_LINKS(&unsorted_bin, split)

            found->header.size = bytes;
        }
        else
        {
            ((memblk*)_ADDBYTES(found, found->header.size))->header.prevsize = 0;
        }

        return mem;
    }

    // Failed allocation
    return 0;
}
