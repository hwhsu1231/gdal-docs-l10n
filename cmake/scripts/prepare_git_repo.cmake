# Distributed under the OSI-approved BSD 3-Clause License.
# See accompanying file LICENSE.txt for details.

get_filename_component(SCRIPT_NAME "${CMAKE_CURRENT_LIST_FILE}" NAME_WE)
set(CMAKE_MESSAGE_INDENT "[${VERSION}][${LANGUAGE}] ")
set(CMAKE_MESSAGE_INDENT_BACKUP "${CMAKE_MESSAGE_INDENT}")
message(STATUS "-------------------- ${SCRIPT_NAME} --------------------")


set(CMAKE_MODULE_PATH 
    "${PROJ_CMAKE_MODULES_DIR}"
    "${PROJ_CMAKE_MODULES_DIR}/common")
find_package(Git MODULE ${FIND_PACKAGE_GIT_ARGS} REQUIRED)
include(GitUtils)
include(JsonUtils)
include(LogUtils)


message(STATUS "Running 'git clone' command to clone the upstream repository...")
if(NOT EXISTS "${PROJ_OUT_REPO_DIR}/.git")
    file(MAKE_DIRECTORY "${PROJ_OUT_REPO_DIR}")
    remove_cmake_message_indent()
    message("")
    execute_process(
        COMMAND 
            ${Git_EXECUTABLE} clone
            --depth=1
            --single-branch
            ${GIT_REMOTE_URL}
            ${PROJ_OUT_REPO_DIR}
        WORKING_DIRECTORY "${PROJ_OUT_REPO_DIR}"
        ECHO_OUTPUT_VARIABLE
        ECHO_ERROR_VARIABLE
        COMMAND_ERROR_IS_FATAL ANY)
    message("")
    restore_cmake_message_indent()
else()
    remove_cmake_message_indent()
    message("")
    message("The repository is already cloned to ${PROJ_OUT_REPO_DIR}")
    message("")
    restore_cmake_message_indent()
endif()


message(STATUS "Running 'git clean -xfdf' command to remove untracked files/directories...")
execute_process(
    COMMAND 
        ${Git_EXECUTABLE} clean -xfdf
    WORKING_DIRECTORY "${PROJ_OUT_REPO_DIR}"
    RESULT_VARIABLE RES_VAR
    OUTPUT_VARIABLE OUT_VAR
    ERROR_VARIABLE  ERR_VAR
    OUTPUT_STRIP_TRAILING_WHITESPACE
    ERROR_STRIP_TRAILING_WHITESPACE)
remove_cmake_message_indent()
message("")
if(RES_VAR EQUAL 0)
    if(OUT_VAR)
        message("${OUT_VAR}")
    else()
        message("No need to clean file/directories.")
    endif()
else()
    message("---------- RES ----------")
    message("")
    message("${RES_VAR}")
    message("")
    message("---------- OUT ----------")
    message("")
    message("${OUT_VAR}")
    message("")
    message("---------- ERR ----------")
    message("")
    message("${ERR_VAR}")
    message("")
    message("-------------------------")
    message("")
    message(FATAL_ERROR "Fatal error occurred.")
endif()
message("")
restore_cmake_message_indent()


if(VERSION_TYPE STREQUAL "branch")
    message(STATUS "Running 'git checkout -B' command to switch to the '${BRANCH_NAME}' branch...")
    remove_cmake_message_indent()
    message("")
    execute_process(
        COMMAND
            ${Git_EXECUTABLE} checkout -B ${BRANCH_NAME}
        WORKING_DIRECTORY "${PROJ_OUT_REPO_DIR}"
        ECHO_OUTPUT_VARIABLE
        ECHO_ERROR_VARIABLE
        COMMAND_ERROR_IS_FATAL ANY)
    message("")
    restore_cmake_message_indent()
    message(STATUS "Running 'git fetch' command to fetch the '${BRANCH_NAME}' branch to FETCH_HEAD...")
    remove_cmake_message_indent()
    message("")
    execute_process(
        COMMAND
            ${Git_EXECUTABLE} fetch origin
            ${BRANCH_NAME}
            --depth=1
            --verbose
        WORKING_DIRECTORY "${PROJ_OUT_REPO_DIR}"
        ECHO_OUTPUT_VARIABLE
        ECHO_ERROR_VARIABLE
        COMMAND_ERROR_IS_FATAL ANY)
    message("")
    restore_cmake_message_indent()
    message(STATUS "Running 'git reset --hard' command to reset the '${BRANCH_NAME}' branch from FETCH_HEAD...")
    remove_cmake_message_indent()
    message("")
    execute_process(
        COMMAND
            ${Git_EXECUTABLE} reset --hard
            FETCH_HEAD
        WORKING_DIRECTORY "${PROJ_OUT_REPO_DIR}"
        ECHO_OUTPUT_VARIABLE
        ECHO_ERROR_VARIABLE
        COMMAND_ERROR_IS_FATAL ANY)
    message("")
    restore_cmake_message_indent()
elseif(VERSION_TYPE STREQUAL "tag")
    message(STATUS "Running 'git fetch' command to fetch '${TAG_PATTERN}' tags from the 'origin' remote...")
    remove_cmake_message_indent()
    message("")
    execute_process(
        COMMAND
            ${Git_EXECUTABLE} fetch origin
            refs/tags/${TAG_PATTERN}:refs/tags/${TAG_PATTERN}
            --depth=1
            --verbose
        WORKING_DIRECTORY "${PROJ_OUT_REPO_DIR}"
        ECHO_OUTPUT_VARIABLE
        ECHO_ERROR_VARIABLE
        COMMAND_ERROR_IS_FATAL ANY)
    message("")
    restore_cmake_message_indent()
else()
    message(FATAL_ERROR "Invalid VERSION_TYPE value. (${VERSION_TYPE})")
endif()
