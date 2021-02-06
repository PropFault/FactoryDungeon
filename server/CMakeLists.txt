cmake_minimum_required(VERSION 3.0.0)
project(server VERSION 0.1.0)

include(CTest)
enable_testing()
# Download automatically, you can also just copy the conan.cmake file
if(NOT EXISTS "${CMAKE_BINARY_DIR}/conan.cmake")
   message(STATUS "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
   file(DOWNLOAD "https://github.com/conan-io/cmake-conan/raw/v0.15/conan.cmake"
                 "${CMAKE_BINARY_DIR}/conan.cmake" 
                 TLS_VERIFY ON)
endif()

include(${CMAKE_BINARY_DIR}/conan.cmake)
conan_add_remote(NAME bincrafters 
                 INDEX 1
                 URL https://api.bintray.com/conan/bincrafters/public-conan
                 VERIFY_SSL True)  
conan_cmake_run(REQUIRES nlohmann_json/3.9.1 boost_asio/1.69.0@bincrafters/stable 
                BASIC_SETUP 
                BUILD missing)

add_executable(server main.cpp)

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)
