find_package(Boost REQUIRED COMPONENTS unit_test_framework)

add_executable(run_tests test.cpp)
target_link_libraries(run_tests add_demo_lib Boost::unit_test_framework)
add_test(NAME test_demo COMMAND run_tests)
