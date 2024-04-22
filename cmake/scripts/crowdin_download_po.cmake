# Distributed under the OSI-approved BSD 3-Clause License.
# See accompanying file LICENSE.txt for details.

get_filename_component(SCRIPT_NAME "${CMAKE_CURRENT_LIST_FILE}" NAME_WE)
set(CMAKE_MESSAGE_INDENT "[${VERSION}][${LANGUAGE}] ")
set(CMAKE_MESSAGE_INDENT_BACKUP "${CMAKE_MESSAGE_INDENT}")
message(STATUS "-------------------- ${SCRIPT_NAME} --------------------")


set(CMAKE_MODULE_PATH 
    "${PROJ_CMAKE_MODULES_DIR}"
    "${PROJ_CMAKE_MODULES_DIR}/common")
find_package(Gettext MODULE ${FIND_PACKAGE_GETTEXT_ARGS} REQUIRED)
find_package(Crowdin MODULE ${FIND_PACKAGE_CROWDIN_ARGS} REQUIRED)
include(JsonUtils)
include(LogUtils)


file(READ "${LANGUAGES_JSON_PATH}" LANGUAGES_JSON_CNT)
if(NOT LANGUAGE STREQUAL "all")
    set(LANGUAGES_LIST "${LANGUAGE}")
endif()
foreach(_LANGUAGE ${LANGUAGES_LIST})
    get_json_value_by_dot_notation(
        IN_JSON_OBJECT    "${LANGUAGES_JSON_CNT}"
        IN_DOT_NOTATION   ".${_LANGUAGE}"
        OUT_JSON_VALUE    _LANGUAGE_CROWDIN)


    message(STATUS "Running 'crowdin download' command to download .po files for '${_LANGUAGE_CROWDIN}' language...")
    remove_cmake_message_indent()
    message("")
    execute_process(
        COMMAND 
            ${Crowdin_EXECUTABLE} download 
            --language ${_LANGUAGE_CROWDIN}
            --branch ${VERSION}
            --config ${CROWDIN_YML_PATH}
            --export-only-approved
            --no-progress
            --verbose
        WORKING_DIRECTORY "${PROJ_L10N_VERSION_DIR}"
        ECHO_OUTPUT_VARIABLE
        ECHO_ERROR_VARIABLE
        COMMAND_ERROR_IS_FATAL ANY)
    message("")
    restore_cmake_message_indent()


    message(STATUS "Running 'msgmerge' command to sync translations from crowdin to local...")
    set(PO_CROWDIN_DIR  "${PROJ_L10N_VERSION_CROWDIN_DIR}/${_LANGUAGE}/LC_MESSAGES")
    set(PO_LOCAL_DIR    "${PROJ_L10N_VERSION_PO_DIR}/${_LANGUAGE}/LC_MESSAGES")
    set(POT_LOCAL_DIR   "${PROJ_L10N_VERSION_POT_DIR}")
    remove_cmake_message_indent()
    message("")
    message("PO_CROWDIN_DIR = ${PO_CROWDIN_DIR}")
    message("PO_LOCAL_DIR   = ${PO_LOCAL_DIR}")
    message("POT_LOCAL_DIR  = ${POT_LOCAL_DIR}")
    message("")
    file(GLOB_RECURSE PO_CROWDIN_FILES "${PO_CROWDIN_DIR}/*.po")
    foreach(PO_CROWDIN_FILE ${PO_CROWDIN_FILES})
        string(REPLACE "${PO_CROWDIN_DIR}/" "" PO_CROWDIN_FILE_RELATIVE "${PO_CROWDIN_FILE}")
        set(PO_LOCAL_FILE "${PO_LOCAL_DIR}/${PO_CROWDIN_FILE_RELATIVE}")
        string(REGEX REPLACE "\\.po$" ".pot" POT_LOCAL_FILE_RELATIVE "${PO_CROWDIN_FILE_RELATIVE}")
        set(POT_LOCAL_FILE "${POT_LOCAL_DIR}/${POT_LOCAL_FILE_RELATIVE}")
        message("msgmerge:")
        message("  --lang         ${_LANGUAGE}")
        message("  --width        ${GETTEXT_WRAP_WIDTH}")
        message("  --compendium   ${PO_CROWDIN_FILE}")
        message("  --output-file  ${PO_LOCAL_FILE}")
        message("  [def.po]       ${POT_LOCAL_FILE}")
        message("  [ref.pot]      ${POT_LOCAL_FILE}")
        execute_process(
            COMMAND 
                ${Gettext_MSGMERGE_EXECUTABLE}
                --lang ${_LANGUAGE} 
                --width ${GETTEXT_WRAP_WIDTH} 
                --compendium ${PO_CROWDIN_FILE}
                --output-file ${PO_LOCAL_FILE}
                ${POT_LOCAL_FILE}   # [def.po]
                ${POT_LOCAL_FILE}   # [ref.pot]
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
    endforeach()
    message("")
    restore_cmake_message_indent()
endforeach()
