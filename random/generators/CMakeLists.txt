cmake_minimum_required(VERSION 3.10)

project(Tutorial VERSION 1.0)


set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

option(USE_MYMATH "Use tutorial provided math implementation" ON)
configure_file(TutorialConfig.h.in TutorialConfig.h)


if(USE_MYMATH)
    add_subdirectory(MathFunctions)
    list(APPEND EXTA_LIBS MathFunctions)
    list(APPEND EXTRA_INCLUDES "${PROJECT_SOURCE_DIR}/MathFUnctions")
endif()

add_executable(Tutorial tutorial.cxx)

target_link_libraries(Tutorial PUBLIC ${EXTRA_LIBS})

target_include_directories(Tutorial PUBLIC
    "${PROJECT_BINARY_DIR}"
    ${EXTRA_INCLUDES}
    )



