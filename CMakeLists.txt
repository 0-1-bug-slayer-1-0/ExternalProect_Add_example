cmake_minimum_required(VERSION 3.25)
project(try_external_project)

include(third-party/unity_utest/install_unity.cmake)


add_executable(${PROJECT_NAME} main.cpp)

if (UNITY_UPDATE_REQUIRED)
    add_dependencies(${PROJECT_NAME} UnityTestFramework)
endif ()

target_sources(${PROJECT_NAME} PRIVATE main.cpp ${Unity_SOURCES})
target_include_directories(try_external_project PRIVATE ${Unity_INCLUDE})
target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_17)