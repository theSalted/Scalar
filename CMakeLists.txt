cmake_minimum_required(VERSION 3.26)
project(Scalar LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_C_STANDARD 17)

# 1) Pull in third-party libs from vcpkg (manifest mode)
find_package(SDL3 CONFIG REQUIRED)                      # SDL3::SDL3
find_package(flecs CONFIG REQUIRED)                     # flecs::flecs or flecs::flecs_static
find_package(gamenetworkingsockets CONFIG REQUIRED)     # GameNetworkingSockets::GameNetworkingSockets
find_package(bgfx CONFIG REQUIRED)                      # bgfx::bgfx
find_package(Bullet CONFIG REQUIRED)                    # Bullet physics engine

# 2) Normalize target names (some ports export different aliases)
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

# 3) Engine library (C++) — linked to all subsystems
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

# 4) Smoke-test C++ app (lets you run a window loop now)
add_executable(GameCpp MACOSX_BUNDLE src/game/main.cpp)
set_target_properties(GameCpp PROPERTIES
  MACOSX_BUNDLE_BUNDLE_NAME "Scalar C++"
  MACOSX_BUNDLE_EXECUTABLE_NAME "GameCpp"
  MACOSX_BUNDLE_IDENTIFIER "com.scalar.gamecpp"
  MACOSX_BUNDLE_SHORT_VERSION_STRING "1.0"
  MACOSX_BUNDLE_BUNDLE_VERSION "1"
)
target_include_directories(GameCpp PRIVATE ${CMAKE_SOURCE_DIR}/include)
target_link_libraries(GameCpp PRIVATE Engine SDL3::SDL3)

# 5) Optional Swift target (only builds if Swift is installed)
enable_language(Swift OPTIONAL)
if(CMAKE_Swift_COMPILER)
  # Use wrapper script to filter out -pthread flag
  set(CMAKE_Swift_COMPILER "${CMAKE_SOURCE_DIR}/swift-wrapper.sh")
  
  add_executable(GameSwift MACOSX_BUNDLE swift/main.swift)
  set_target_properties(GameSwift PROPERTIES
    MACOSX_BUNDLE_BUNDLE_NAME "Scalar Swift"
    MACOSX_BUNDLE_EXECUTABLE_NAME "GameSwift"
    MACOSX_BUNDLE_IDENTIFIER "com.scalar.gameswift"
    MACOSX_BUNDLE_SHORT_VERSION_STRING "1.0"
    MACOSX_BUNDLE_BUNDLE_VERSION "1"
  )
  target_include_directories(GameSwift PRIVATE ${CMAKE_SOURCE_DIR}/include ${CMAKE_SOURCE_DIR}/modules)
  target_link_libraries(GameSwift PRIVATE Engine)
endif()
