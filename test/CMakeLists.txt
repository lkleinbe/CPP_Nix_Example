find_package(Boost REQUIRED)

add_executable(run_tests test.cpp)
target_link_libraries(run_tests add_demo_lib)
add_test(NAME test_demo COMMAND run_tests)
