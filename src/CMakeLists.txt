add_library(add_demo_lib addition.cpp)
target_include_directories(add_demo_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

add_executable(hello_world main.cpp)
target_include_directories(hello_world PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

#the executable with the same name as the nix package will be executed when using nix run
add_executable(package-name main.cpp)
target_include_directories(package-name PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
install (TARGETS package-name DESTINATION bin)
