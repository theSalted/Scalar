#pragma once
#include <SDL3/SDL.h>
#include <flecs.h>

struct EngineState {
  SDL_Window* window = nullptr;
  flecs::world ecs;
  
  EngineState() : window(nullptr), ecs() {}
};

EngineState& engine_state();
