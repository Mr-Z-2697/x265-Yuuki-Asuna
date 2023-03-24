# Version for Yuuki Asuna mod

find_package(Git)

execute_process(COMMAND
    ${GIT_EXECUTABLE} describe --tags HEAD
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        OUTPUT_VARIABLE X265_HEAD_TAG
        ERROR_QUIET OUTPUT_STRIP_TRAILING_WHITESPACE
    )

if(NOT "${MOD_BUILD}" STREQUAL "Asuna")
    set(X265_BASE_BRANCH "stable")
else()
    set(X265_BASE_BRANCH "old-stable")
endif()

execute_process(COMMAND
    ${GIT_EXECUTABLE} describe --tags origin/${X265_BASE_BRANCH}
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        OUTPUT_VARIABLE X265_BASE_TAG
        ERROR_QUIET OUTPUT_STRIP_TRAILING_WHITESPACE
    )

string(REPLACE "-" ";" X265_HEAD_TAG_ARR ${X265_HEAD_TAG})
string(REPLACE "-" ";" X265_BASE_TAG_ARR ${X265_BASE_TAG})
list(GET X265_HEAD_TAG_ARR 0 X265_ORIG_TAG)
list(GET X265_HEAD_TAG_ARR 1 X265_HEAD_DISTANCE)
list(GET X265_HEAD_TAG_ARR 2 X265_HEAD_COMMIT)
list(GET X265_BASE_TAG_ARR 1 X265_BASE_DISTANCE)
list(GET X265_BASE_TAG_ARR 2 X265_BASE_COMMIT)

string(REPLACE "M" "" X265_LATEST_TAG ${X265_ORIG_TAG})

if("${X265_HEAD_COMMIT}" STREQUAL "${X265_BASE_COMMIT}")
    set(X265_VERSION "${X265_LATEST_TAG}+${X265_BASE_DISTANCE}-${X265_BASE_COMMIT}")
else()
    math(EXPR X265_VERSION_DIFF "${X265_HEAD_DISTANCE} - ${X265_BASE_DISTANCE}")
    set(X265_VERSION "${X265_LATEST_TAG}+${X265_BASE_DISTANCE}-${X265_BASE_COMMIT}+${X265_VERSION_DIFF}")
endif()

set(X265_TAG_DISTANCE ${X265_BASE_DISTANCE})
message(STATUS "x265 Mod: ${MOD_BUILD}")
message(STATUS "x265 Release Version: ${X265_VERSION}")
