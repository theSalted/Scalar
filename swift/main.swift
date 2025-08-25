import EngineC
import Foundation
import AppKit

print("Swift -> Starting Scalar game...")

let result = engine_init()
if result == 0 {
    print("Swift -> Engine initialized successfully! Window should be visible.")
    print("Swift -> App will run until window is closed or 60 seconds pass.")
    
    // Keep the app alive - this creates a proper event loop
    let app = NSApplication.shared
    app.setActivationPolicy(.regular)
    
    // Run until quit or timeout
    DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
        print("Swift -> Timeout reached, shutting down...")
        engine_shutdown()
        NSApplication.shared.terminate(nil)
    }
    
    app.run()
    
} else {
    print("Swift -> Engine initialization failed with code: \(result)")
    print("Swift -> This might be normal if running without GUI access.")
    print("Swift -> App will stay alive for 5 seconds to show this message...")
    
    // Stay alive briefly to show the error message
    sleep(5)
    exit(1)
}
