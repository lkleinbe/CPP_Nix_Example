cmake_minimum_required(VERSION 3.28)
project(cpp_nix_flake)

set(CMAKE_CXX_STANDARD 14)

find_package(Boost REQUIRED)
include_directories(${Boost_INCLUDE_DIR})

include_directories(.)

add_subdirectory(src)

option(TESTING "Enable tests." ON)
if (TESTING)
  enable_testing()
  add_subdirectory(test)
endif()

