#include <cstdio>
#include "incbin.h" // from https://github.com/graphitemaster/incbin/pull/70 after manually rebasing on top of main as of 2025-10-23

INCBIN(IncbinExample, "lib/incbin_example.txt");


void CallLib() {
    printf("INCBIN file content: %.*s\n", gIncbinExampleSize, gIncbinExampleData);
}
