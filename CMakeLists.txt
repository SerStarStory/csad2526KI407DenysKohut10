cmake_minimum_required(VERSION 3.14)

project(HelloWorld)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Main executable
add_executable(HelloWorld main.cpp math_operations.cpp)

# Google Test setup
include(FetchContent)
FetchContent_Declare(
        googletest
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG release-1.12.1
)
# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

# Enable testing
enable_testing()

# Test executable
add_executable(RunTests tests/unit_tests.cpp math_operations.cpp)
target_link_libraries(RunTests gtest gtest_main)

# Add test
add_test(NAME UnitTests COMMAND RunTests)