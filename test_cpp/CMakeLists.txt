find_package(Catch2 3 REQUIRED)

add_executable(run_tests test.cpp)
target_link_libraries(run_tests PRIVATE add_demo_lib Catch2::Catch2WithMain)

include(Catch)
catch_discover_tests(run_tests)
