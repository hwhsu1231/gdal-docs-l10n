# Distributed under the OSI-approved BSD 3-Clause License.
# See accompanying file LICENSE.txt for details.

get_filename_component(SCRIPT_NAME "${CMAKE_CURRENT_LIST_FILE}" NAME_WE)
set(CMAKE_MESSAGE_INDENT "[${VERSION}][${LANGUAGE}] ")
set(CMAKE_MESSAGE_INDENT_BACKUP "${CMAKE_MESSAGE_INDENT}")
message(STATUS "-------------------- ${SCRIPT_NAME} --------------------")


set(CMAKE_MODULE_PATH 
    "${PROJ_CMAKE_MODULES_DIR}"
    "${PROJ_CMAKE_MODULES_DIR}/common")
set(Sphinx_ROOT_DIR "${PROJ_VENV_DIR}")
find_package(Git      MODULE ${FIND_PACKAGE_GIT_ARGS}     REQUIRED)
find_package(Gettext  MODULE ${FIND_PACKAGE_GETTEXT_ARGS} REQUIRED)
find_package(Sphinx   MODULE REQUIRED)
include(GitUtils)
include(JsonUtils)
include(LogUtils)
set(ENV{LANG} "${CONSOLE_LOCALE}")


message(STATUS "Determining whether it is required to update .pot files...")
file(READ "${REFERENCE_JSON_PATH}" REFERENCE_JSON_CNT)
get_json_value_by_dot_notation(
    IN_JSON_OBJECT      "${REFERENCE_JSON_CNT}"
    IN_DOT_NOTATION     ".pot"
    OUT_JSON_VALUE      CURRENT_POT_OBJECT)
if(VERSION_TYPE STREQUAL "branch")
    get_json_value_by_dot_notation(
        IN_JSON_OBJECT      "${CURRENT_POT_OBJECT}"
        IN_DOT_NOTATION     ".commit.hash"
        OUT_JSON_VALUE      CURRENT_POT_COMMIT_HASH)
    get_git_latest_commit_on_branch_name(
        IN_REPO_PATH        "${PROJ_OUT_REPO_DIR}"
        IN_BRANCH_NAME      "${BRANCH_NAME}"
        OUT_DATE            LATEST_POT_COMMIT_DATE
        OUT_HASH            LATEST_POT_COMMIT_HASH
        OUT_TITLE           LATEST_POT_COMMIT_TITLE)
    set_members_of_commit_json_object(
        IN_MEMBER_DATE      "\"${LATEST_POT_COMMIT_DATE}\""
        IN_MEMBER_HASH      "\"${LATEST_POT_COMMIT_HASH}\""
        IN_MEMBER_TITLE     "\"${LATEST_POT_COMMIT_TITLE}\""
        OUT_JSON_OBJECT     COMMIT_CNT)
    set_members_of_language_json_object(
        IN_TYPE             "branch"
        IN_MEMBER_BRANCH    "\"${BRANCH_NAME}\""
        IN_MEMBER_COMMIT    "${COMMIT_CNT}"
        OUT_JSON_OBJECT     LATEST_POT_OBJECT)
    set(CURRENT_POT_REFERENCE   ${CURRENT_POT_COMMIT_HASH})
    set(LATEST_POT_REFERENCE    ${LATEST_POT_COMMIT_HASH})
else()
    get_json_value_by_dot_notation(
        IN_JSON_OBJECT      "${CURRENT_POT_OBJECT}"
        IN_DOT_NOTATION     ".tag"
        OUT_JSON_VALUE      CURRENT_POT_TAG)
    get_git_latest_tag_on_tag_pattern(
        IN_REPO_PATH        "${PROJ_OUT_REPO_DIR}"
        IN_TAG_PATTERN      "${TAG_PATTERN}"
        OUT_TAG             LATEST_POT_TAG)
    set_members_of_language_json_object(
        IN_TYPE             "tag"
        IN_MEMBER_TAG       "\"${LATEST_POT_TAG}\""
        OUT_JSON_OBJECT     LATEST_POT_OBJECT)
    set(CURRENT_POT_REFERENCE   ${CURRENT_POT_TAG})
    set(LATEST_POT_REFERENCE    ${LATEST_POT_TAG})
endif()
if(UPDATE_MODE STREQUAL "COMPARE")
    if(NOT CURRENT_POT_REFERENCE STREQUAL LATEST_POT_REFERENCE)
        set(CHECKOUT_REFERENCE ${LATEST_POT_REFERENCE})
        set(UPDATE_REQUIRED ON)
    else()
        set(CHECKOUT_REFERENCE ${CURRENT_POT_REFERENCE})
        set(UPDATE_REQUIRED OFF)
    endif()
elseif(UPDATE_MODE STREQUAL "ALWAYS")
    set(CHECKOUT_REFERENCE ${LATEST_POT_REFERENCE})
    set(UPDATE_REQUIRED ON)
elseif(UPDATE_MODE STREQUAL "NEVER")
    if(NOT CURRENT_POT_REFERENCE)
        set(CHECKOUT_REFERENCE ${LATEST_POT_REFERENCE})
        set(UPDATE_REQUIRED ON)
    else()
        set(CHECKOUT_REFERENCE ${CURRENT_POT_REFERENCE})
        set(UPDATE_REQUIRED OFF)
    endif()
else()
    message(FATAL_ERROR "Invalid UNPDATE_MODE value. (${UPDATE_MODE})")
endif()
remove_cmake_message_indent()
message("")
message("latest = ${LATEST_POT_OBJECT}")
message(".pot = ${CURRENT_POT_OBJECT}")
message("UPDATE_MODE            = ${UPDATE_MODE}")
message("LATEST_POT_REFERENCE   = ${LATEST_POT_REFERENCE}")
message("CURRENT_POT_REFERENCE  = ${CURRENT_POT_REFERENCE}")
message("UPDATE_REQUIRED        = ${UPDATE_REQUIRED}")
message("CHECKOUT_REFERENCE     = ${CHECKOUT_REFERENCE}")
message("")
restore_cmake_message_indent()


message(STATUS "Running 'git checkout -B' command to switch to the 'current' branch...")
remove_cmake_message_indent()
message("")
execute_process(
    COMMAND 
        ${Git_EXECUTABLE} checkout -B current
    WORKING_DIRECTORY "${PROJ_OUT_REPO_DIR}"
    ECHO_OUTPUT_VARIABLE
    ECHO_ERROR_VARIABLE
    COMMAND_ERROR_IS_FATAL ANY)
message("")
restore_cmake_message_indent()
message(STATUS "Running 'git fetch' command to fetch the '${CHECKOUT_REFERENCE}' commit to FETCH_HEAD...")
remove_cmake_message_indent()
message("")
execute_process(
    COMMAND
        ${Git_EXECUTABLE} fetch origin
        ${CHECKOUT_REFERENCE}
        --depth=1
        --verbose
    WORKING_DIRECTORY "${PROJ_OUT_REPO_DIR}"
    ECHO_OUTPUT_VARIABLE
    ECHO_ERROR_VARIABLE
    COMMAND_ERROR_IS_FATAL ANY)
message("")
restore_cmake_message_indent()
message(STATUS "Running 'git reset --hard' command to reset the 'current' branch from FETCH_HEAD...")
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


message(STATUS "Generating 'conf.py' file by configuring project(CMakeHelp)...")
remove_cmake_message_indent()
message("")
execute_process(
    COMMAND 
        ${CMAKE_COMMAND} 
        -S ${PROJ_OUT_REPO_SPHINX_DIR}
        -B ${PROJ_OUT_REPO_SPHINX_DIR}/build
        -D SPHINX_HTML=ON
        # Since find_program(SPHINX_EXECUTABLE) of CMake repo doesn't support to 
        # find sphinx-build inside the virtual environment currently, I have to 
        # specify it in advanced.
        -D SPHINX_EXECUTABLE=${Sphinx_BUILD_EXECUTABLE}
    ECHO_OUTPUT_VARIABLE
    ECHO_ERROR_VARIABLE
    COMMAND_ERROR_IS_FATAL ANY)
message("")
restore_cmake_message_indent()
message(STATUS "Copying the 'conf.py' file to '${PROJ_OUT_REPO_DOCS_SOURCE_DIR}/'...")
file(COPY_FILE 
    "${PROJ_OUT_REPO_SPHINX_DIR}/build/conf.py"
    "${PROJ_OUT_REPO_DOCS_SOURCE_DIR}/conf.py")
remove_cmake_message_indent()
message("")
message("The 'conf.py' file is copied.")
message("")
restore_cmake_message_indent()


if(NOT UPDATE_REQUIRED)
    message(STATUS "No need to update .pot files.")
    return()
endif()


message(STATUS "Running 'sphinx-build' command with 'gettext' builder to generate .pot files...")
remove_cmake_message_indent()
message("")
execute_process(
    COMMAND
        ${Sphinx_BUILD_EXECUTABLE}
        -b gettext
        -D version=${VERSION}                               # Specify 'Project-Id-Version' in .pot files
        -D gettext_compact=0
        -D gettext_additional_targets=${GETTEXT_ADDITIONAL_TARGETS}
        -c ${PROJ_OUT_REPO_DOCS_CONFIG_DIR}                 # <configdir>, where conf.py locates
        ${PROJ_OUT_REPO_DOCS_SOURCE_DIR}                    # <sourcedir>, where index.rst locates
        ${PROJ_OUT_REPO_DOCS_LOCALE_DIR}/pot/LC_MESSAGES    # <outputdir>, where .pot generates
    ECHO_OUTPUT_VARIABLE
    RESULT_VARIABLE RES_VAR
    ERROR_VARIABLE  ERR_VAR
    OUTPUT_STRIP_TRAILING_WHITESPACE
    ERROR_STRIP_TRAILING_WHITESPACE)
if(RES_VAR EQUAL 0)
    if(ERR_VAR)
        # Success, but there may be some warnings.
        message("")
        message("---------- RES ----------")
        message("")
        message("${RES_VAR}")
        message("")
        message("---------- ERR ----------")
        message("")
        message("${ERR_VAR}")
        message("")
        message("-------------------------")
    endif()
else()
    message("")
    message("---------- RES ----------")
    message("")
    message("${RES_VAR}")
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


message(STATUS "Running 'msgmerge/msgcat' command to update .pot files...")
set(POT_SRC_DIR "${PROJ_OUT_REPO_DOCS_LOCALE_DIR}/pot/LC_MESSAGES")
set(POT_DST_DIR "${PROJ_L10N_VERSION_POT_DIR}")
file(GLOB_RECURSE POT_SRC_FILES "${POT_SRC_DIR}/*.pot")
remove_cmake_message_indent()
message("")
message("From: ${POT_SRC_DIR}/")
message("To:   ${POT_DST_DIR}/")
message("")
foreach(POT_SRC_FILE ${POT_SRC_FILES})
    string(REPLACE "${POT_SRC_DIR}/" "" POT_SRC_FILE_RELATIVE "${POT_SRC_FILE}")
    set(POT_DST_FILE "${POT_DST_DIR}/${POT_SRC_FILE_RELATIVE}")
    get_filename_component(POT_DST_FILE_DIR "${POT_DST_FILE}" DIRECTORY)
    file(MAKE_DIRECTORY "${POT_DST_FILE_DIR}")
    if(EXISTS "${POT_DST_FILE}")
        # If the ${POT_DST_FILE} exists, then merge it using msgmerge.
        message("msgmerge:")
        message("  --width      ${GETTEXT_WRAP_WIDTH}")
        message("  --backup     off")
        message("  --update")
        message("  --force-po")
        message("  --no-fuzzy-matching")
        message("  [def.po]     ${POT_DST_FILE}")
        message("  [ref.pot]    ${POT_SRC_FILE}")
        execute_process(
            COMMAND
                ${Gettext_MSGMERGE_EXECUTABLE}
                --width ${GETTEXT_WRAP_WIDTH} 
                --backup off
                --update
                --force-po
                --no-fuzzy-matching
                ${POT_DST_FILE}   # [def.po]
                ${POT_SRC_FILE}   # [ref.pot]
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
    else()
        # If the ${POT_DST_FILE} doesn't exist, then create it using msgcat.
        message("msgcat:")
        message("  --width        ${GETTEXT_WRAP_WIDTH}")
        message("  --output-file  ${POT_DST_FILE}")
        message("  [inputfile]    ${POT_SRC_FILE}")
        execute_process(
            COMMAND
                ${Gettext_MSGCAT_EXECUTABLE}
                --width ${GETTEXT_WRAP_WIDTH} 
                --output-file ${POT_DST_FILE}
                ${POT_SRC_FILE}   # [inputfile]
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
    endif()
endforeach()
unset(POT_SRC_FILE)
message("")
restore_cmake_message_indent()


set_json_value_by_dot_notation(
    IN_JSON_OBJECT      "${REFERENCE_JSON_CNT}"
    IN_DOT_NOTATION     ".pot"
    IN_JSON_VALUE       "${LATEST_POT_OBJECT}"
    OUT_JSON_OBJECT     REFERENCE_JSON_CNT)


file(WRITE "${REFERENCE_JSON_PATH}" ${REFERENCE_JSON_CNT})
