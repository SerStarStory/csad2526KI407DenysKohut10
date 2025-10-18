#!/bin/bash

set -e  # Exit on error

echo "Starting CI Build Process..."
echo ""

# Step 1: Remove old build folder if it exists and create a new one
echo "[Step 1/4] Creating build folder..."
if [ -d "build" ]; then
    rm -rf build
fi
mkdir build
echo "Build folder created successfully."
echo ""

# Step 2: Configure project with CMake
echo "[Step 2/4] Configuring project with CMake..."
cd build
cmake ..
echo "CMake configuration completed successfully."
echo ""

# Step 3: Build project
echo "[Step 3/4] Building project..."
cmake --build . --config Release
echo "Build completed successfully."
echo ""

# Step 4: Run tests with CTest
echo "[Step 4/4] Running tests with CTest..."
ctest -C Release --output-on-failure
echo ""
echo "Tests completed successfully."
echo ""

cd ..
echo "========================================"
echo "CI Build Process Completed Successfully!"
echo "========================================"
exit 0