# Scalar

A Swift game engine with high-performance C++ core libraries.

## Overview

Scalar is a modern game engine built primarily in Swift, leveraging powerful C++ libraries for performance-critical systems like physics, networking, and rendering.

## Setup

### Prerequisites
- macOS 13+
- Swift 5.9+
- CMake (for building C++ engine core)

### Building the C++ Engine Core

```bash
# First time setup - build the C++ engine library
cmake --preset macos-arm64-debug
cmake --build build/macos-arm64-debug
```

### Building the Swift Application

```bash
# Build the Swift executable
xcrun swift build

# Run the application
xcrun swift run Scalar
```

## Development

```bash
# Run in debug mode
./.build/debug/Scalar

# Clean build (order matters - C++ core must be built first)
xcrun swift package clean
rm -rf build/
cmake --preset macos-arm64-debug
cmake --build build/macos-arm64-debug
xcrun swift build
```

## Dependencies

- SDL3
- bgfx 
- flecs
- Bullet Physics
- GameNetworkingSockets

All handled by vcpkg (automatic).