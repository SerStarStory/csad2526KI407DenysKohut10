#include <gtest/gtest.h>
#include "../math_operations.h"

TEST(MathOperationsTest, AddPositiveNumbers) {
    EXPECT_EQ(add(2, 3), 5);
    EXPECT_EQ(add(10, 20), 30);
}

TEST(MathOperationsTest, AddNegativeNumbers) {
    EXPECT_EQ(add(-5, -3), -8);
    EXPECT_EQ(add(-10, -20), -30);
}

TEST(MathOperationsTest, AddMixedNumbers) {
    EXPECT_EQ(add(-1, 1), 0);
    EXPECT_EQ(add(5, -3), 2);
    EXPECT_EQ(add(-5, 3), -2);
}

TEST(MathOperationsTest, AddZero) {
    EXPECT_EQ(add(0, 0), 0);
    EXPECT_EQ(add(5, 0), 5);
    EXPECT_EQ(add(0, -5), -5);
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}