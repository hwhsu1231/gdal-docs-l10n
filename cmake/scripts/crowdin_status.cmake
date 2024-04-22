# Distributed under the OSI-approved BSD 3-Clause License.
# See accompanying file LICENSE.txt for details.

get_filename_component(SCRIPT_NAME "${CMAKE_CURRENT_LIST_FILE}" NAME_WE)
set(CMAKE_MESSAGE_INDENT "[${VERSION}][${LANGUAGE}] ")
set(CMAKE_MESSAGE_INDENT_BACKUP "${CMAKE_MESSAGE_INDENT}")
message(STATUS "-------------------- ${SCRIPT_NAME} --------------------")


set(CMAKE_MODULE_PATH 
    "${PROJ_CMAKE_MODULES_DIR}"
    "${PROJ_CMAKE_MODULES_DIR}/common")
find_package(Crowdin MODULE ${FIND_PACKAGE_CROWDIN_ARGS} REQUIRED)
include(LogUtils)


message(STATUS "Running 'crowdin status' command to get translated/proofread progress...")
remove_cmake_message_indent()
message("")
execute_process(
    COMMAND
        ${Crowdin_EXECUTABLE} status
        --branch ${VERSION}
        --config ${CROWDIN_YML_PATH}
        --no-progress
        --verbose
    WORKING_DIRECTORY "${PROJ_L10N_VERSION_DIR}"
    ECHO_OUTPUT_VARIABLE
    RESULT_VARIABLE RES_VAR
    OUTPUT_VARIABLE OUT_VAR
    ERROR_VARIABLE  ERR_VAR
    OUTPUT_STRIP_TRAILING_WHITESPACE
    ERROR_STRIP_TRAILING_WHITESPACE)
if(RES_VAR EQUAL 0)
else()
    message("")
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


message("Writing the translated/proofread progress into 'progress.txt'...")
string(REGEX REPLACE ".*Fetching project info\n" "" PROGRESS_TXT_CNT "${OUT_VAR}")
string(REPLACE "\t" "  " PROGRESS_TXT_CNT "${PROGRESS_TXT_CNT}")
file(WRITE "${PROGRESS_TXT_PATH}" "${PROGRESS_TXT_CNT}")
remove_cmake_message_indent()
message("")
message("${PROGRESS_TXT_PATH}")
message("${PROGRESS_TXT_CNT}")
message("")
restore_cmake_message_indent()
