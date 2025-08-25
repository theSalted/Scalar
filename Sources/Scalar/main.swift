import Foundation
import ScalarEngine

print("Scalar Game Engine - Swift Edition")

// Initialize the C++ engine
let initResult = engine_init()
if initResult == 0 {
    print("Engine initialized successfully!")
} else {
    print("Engine initialization failed with code: \(initResult)")
    exit(1)
}

// Shutdown the C++ engine
engine_shutdown()
print("Engine shutdown complete.")