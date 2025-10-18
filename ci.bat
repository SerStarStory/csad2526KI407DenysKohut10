@echo off
echo Starting CI Build Process...
echo.

REM Step 1: Remove old build folder if it exists and create a new one
echo [Step 1/4] Creating build folder...
if exist build rmdir /s /q build
mkdir build
if %errorlevel% neq 0 (
    echo ERROR: Failed to create build folder
    exit /b %errorlevel%
)
echo Build folder created successfully.
echo.

REM Step 2: Configure project with CMake
echo [Step 2/4] Configuring project with CMake...
cd build
cmake ..
if %errorlevel% neq 0 (
    echo ERROR: CMake configuration failed
    cd ..
    exit /b %errorlevel%
)
echo CMake configuration completed successfully.
echo.

REM Step 3: Build project
echo [Step 3/4] Building project...
cmake --build . --config Release
if %errorlevel% neq 0 (
    echo ERROR: Build failed
    cd ..
    exit /b %errorlevel%
)
echo Build completed successfully.
echo.

REM Step 4: Run tests with CTest
echo [Step 4/4] Running tests with CTest...
ctest -C Release --output-on-failure
if %errorlevel% neq 0 (
    echo ERROR: Tests failed
    cd ..
    exit /b %errorlevel%
)
echo.
echo Tests completed successfully.
echo.

cd ..
echo ========================================
echo CI Build Process Completed Successfully!
echo ========================================
exit /b 0