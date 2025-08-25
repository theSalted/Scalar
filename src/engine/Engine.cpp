#include "Engine.hpp"
#include <cstdio>

static EngineState g_state{};
EngineState& engine_state() { return g_state; }

extern "C" int engine_init() {
  std::fprintf(stderr, "Engine: Initializing...\n");
  
  // Skip SDL for now and just return success to test app launch
  // std::fprintf(stderr, "Engine: Initialization complete (SDL skipped for testing)\n");
  return 0;
  
  // TODO: Re-enable SDL once we resolve initialization issues
  
  if (SDL_Init(SDL_INIT_VIDEO) != 0) {
    std::fprintf(stderr, "SDL_Init failed: %s\n", SDL_GetError());
    return -1;
  }

  g_state.window = SDL_CreateWindow("Scalar", 1280, 720, SDL_WINDOW_RESIZABLE);
  if (!g_state.window) {
    std::fprintf(stderr, "SDL_CreateWindow failed: %s\n", SDL_GetError());
    SDL_Quit();
    return -1;
  }
  

  // --- TODO(bgfx): next step ---
  // Fetch native window handle from SDL and pass it into bgfx::PlatformData,
  // then call bgfx::init(...) and bgfx::reset(...) for the backbuffer.
  // Also hook SDL resize events to bgfx::reset.

  // --- TODO(Bullet): next step ---
  // Create a Bullet Physics dynamics world, collision configuration, etc.

  // --- TODO(GNS): next step ---
  // Initialize SteamDatagram/ISteamNetworkingSockets for listen/connect flows.

  return 0;
}

extern "C" void engine_shutdown() {
  std::fprintf(stderr, "Engine: Shutting down...\n");
  // TODO: Re-enable SDL cleanup once we resolve initialization issues
  
  if (g_state.window) {
    SDL_DestroyWindow(g_state.window);
    g_state.window = nullptr;
  }
  SDL_Quit();
  
}
