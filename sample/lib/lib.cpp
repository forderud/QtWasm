#include <cstdio>
#include <thread>
#include "incbin.h" // from https://github.com/graphitemaster/incbin/pull/70 after manually rebasing on top of main as of 2025-10-23

INCBIN(IncbinExample, "lib/incbin_example.txt");


static void ThreadFunction () {
    printf("Lib thread running.\n");
}

void CallLib() {
    printf("INCBIN file content: %.*s\n", gIncbinExampleSize, gIncbinExampleData);

    try {
        std::thread t(&ThreadFunction);
        t.join();
        printf("[thread joined]\n");
    } catch (std::exception & e) {
        printf("ERROR: %s\n", e.what());
    }
}
