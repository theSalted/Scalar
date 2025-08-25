#!/bin/bash
# Wrapper script to filter out incompatible flags for Swift compilation

# Filter out incompatible flags and convert linker flags
args=()
for arg in "$@"; do
    if [[ "$arg" == "-pthread" ]]; then
        # Skip pthread flag
        continue
    elif [[ "$arg" == "-Wl,-framework,CoreFoundation" ]]; then
        # Convert to Swift-compatible framework flag
        args+=("-Xlinker" "-framework" "-Xlinker" "CoreFoundation")
    else
        args+=("$arg")
    fi
done

# Call the real Swift compiler
exec /usr/bin/swiftc "${args[@]}"