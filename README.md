# Scalar

Game engine with C++ core and Swift frontend.

## Setup

```bash
# First time setup
cmake --preset macos-arm64-debug

# Build
cmake --build build/macos-arm64-debug

# Code sign (required on macOS)
codesign --force --deep --sign - build/macos-arm64-debug/GameCpp.app
```

## Run

```bash
# Run with debug output (recommended for development)
build/macos-arm64-debug/GameCpp.app/Contents/MacOS/GameCpp

# Or Swift version
build/macos-arm64-debug/GameSwift.app/Contents/MacOS/GameSwift

# Launch as macOS app (no console output)
open build/macos-arm64-debug/GameCpp.app
```

## Clean Build

```bash
rm -rf build/macos-arm64-debug
cmake --preset macos-arm64-debug
cmake --build build/macos-arm64-debug
```

## Dependencies

- SDL3
- bgfx 
- flecs
- Bullet Physics
- GameNetworkingSockets

All handled by vcpkg (automatic).