#include "EngineC.h"
#include <SDL3/SDL.h>
#include <cstdio>

int main() {
  std::puts("C++ -> Starting Scalar game...");
  
  if (engine_init() != 0) {
    std::puts("C++ -> Engine initialization failed.");
    std::puts("C++ -> This might be normal if running without GUI access.");
    std::puts("C++ -> App will stay alive for 5 seconds to show this message...");
    SDL_Delay(5000);
    return 1;
  }

  std::puts("C++ -> Engine initialized successfully! Window should be visible.");
  std::puts("C++ -> Close the window to quit.");
  
  bool quit = false;
  while (!quit) {
    SDL_Event e;
    while (SDL_PollEvent(&e)) {
      if (e.type == SDL_EVENT_QUIT) {
        std::puts("C++ -> Quit event received, shutting down...");
        quit = true;
      }
    }
    SDL_Delay(16); // crude ~60fps idle
  }

  engine_shutdown();
  std::puts("C++ -> Shutdown complete.");
  return 0;
}
