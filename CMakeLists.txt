cmake_minimum_required(VERSION 3.26)
project(ScalarEngine LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_C_STANDARD 17)

# Pull in third-party libs from vcpkg (manifest mode)
find_package(SDL3 CONFIG REQUIRED)                      # SDL3::SDL3
find_package(flecs CONFIG REQUIRED)                     # flecs::flecs or flecs::flecs_static
find_package(gamenetworkingsockets CONFIG REQUIRED)     # GameNetworkingSockets::GameNetworkingSockets
find_package(bgfx CONFIG REQUIRED)                      # bgfx::bgfx
find_package(Bullet CONFIG REQUIRED)                    # Bullet physics engine

# Normalize target names (some ports export different aliases)
if(TARGET flecs::flecs)
  set(FLECS_TARGET flecs::flecs)
else()
  set(FLECS_TARGET flecs::flecs_static)
endif()

set(GNS_TARGET "")
if(TARGET GameNetworkingSockets::GameNetworkingSockets)
  set(GNS_TARGET GameNetworkingSockets::GameNetworkingSockets)
elseif(TARGET gamenetworkingsockets)
  set(GNS_TARGET gamenetworkingsockets)
endif()

set(BULLET_TARGET "")
if(BULLET_LIBRARIES)
  set(BULLET_TARGET ${BULLET_LIBRARIES})
elseif(TARGET Bullet3Dynamics)
  set(BULLET_TARGET Bullet3Dynamics Bullet3Collision Bullet3Common LinearMath)
endif()

# Engine library (C++) — core engine functionality
add_library(Engine STATIC
  src/engine/Engine.cpp
)
target_include_directories(Engine PUBLIC ${CMAKE_SOURCE_DIR}/include)
target_link_libraries(Engine
  PRIVATE
    SDL3::SDL3
    ${FLECS_TARGET}
    ${GNS_TARGET}
    bgfx::bgfx
    ${BULLET_TARGET}
)

# Optional: C++ test executable for engine development
add_executable(EngineTest src/game/main.cpp)
target_include_directories(EngineTest PRIVATE ${CMAKE_SOURCE_DIR}/include)
target_link_libraries(EngineTest PRIVATE Engine SDL3::SDL3)