#pragma once
#ifdef __cplusplus
extern "C" {
#endif

// Initialize/shutdown the engine.
// Returns 0 on success; non-zero on failure.
int engine_init();
void engine_shutdown();

#ifdef __cplusplus
} // extern "C"
#endif
