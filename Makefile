.PHONY: all build clean cpp swift

BUILD_DIR = build/macos-arm64-debug

all: build

build: cpp swift

cpp:
	@echo "🔧 Building C++ Engine..."
	@mkdir -p $(BUILD_DIR)
	@cd $(BUILD_DIR) && cmake -DCMAKE_BUILD_TYPE=Debug ../.. && cmake --build . --target Engine
	@echo "✅ C++ Engine built"

swift: cpp
	@echo "🔧 Building Swift executable..."
	@swift build
	@echo "✅ Swift build complete"

run: build
	.build/debug/Scalar

clean:
	rm -rf $(BUILD_DIR) .build