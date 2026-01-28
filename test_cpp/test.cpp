#include "addition.hpp"
#include <catch2/catch_test_macros.hpp>

TEST_CASE("test_demo0", "[demo]") { REQUIRE(1 == 1); }

TEST_CASE("test_demo1", "[demo]") { REQUIRE(add(1, 1) == 2); }
