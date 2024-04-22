# Distributed under the OSI-approved BSD 3-Clause License.
# See accompanying file LICENSE.txt for details.

get_filename_component(SCRIPT_NAME "${CMAKE_CURRENT_LIST_FILE}" NAME_WE)
set(CMAKE_MESSAGE_INDENT "[${VERSION}][${LANGUAGE}] ")
set(CMAKE_MESSAGE_INDENT_BACKUP "${CMAKE_MESSAGE_INDENT}")
message(STATUS "-------------------- ${SCRIPT_NAME} --------------------")


set(CMAKE_MODULE_PATH 
    "${PROJ_CMAKE_MODULES_DIR}"
    "${PROJ_CMAKE_MODULES_DIR}/common")
find_package(Git      MODULE ${FIND_PACKAGE_GIT_ARGS}     REQUIRED)
find_package(Gettext  MODULE ${FIND_PACKAGE_GETTEXT_ARGS} REQUIRED)
include(JsonUtils)
include(LogUtils)


file(READ "${REFERENCE_JSON_PATH}" REFERENCE_JSON_CNT)
if(NOT LANGUAGE STREQUAL "all")
    set(LANGUAGES_LIST "${LANGUAGE}")
endif()
foreach(_LANGUAGE ${LANGUAGES_LIST})
    message(STATUS "Comparing the version of 'pot' and 'po.${_LANGUAGE}' object...")
    get_json_value_by_dot_notation(
        IN_JSON_OBJECT    "${REFERENCE_JSON_CNT}"
        IN_DOT_NOTATION   ".pot"
        OUT_JSON_VALUE    CURRENT_POT_OBJECT)
    get_json_value_by_dot_notation(
        IN_JSON_OBJECT    "${REFERENCE_JSON_CNT}"
        IN_DOT_NOTATION   ".po.${_LANGUAGE}"
        OUT_JSON_VALUE    CURRENT_PO_LOCALE_OBJECT)
    if(VERSION_TYPE STREQUAL "branch")
        set(DOT_NOTATION ".commit.hash")
    else()
        set(DOT_NOTATION ".tag")
    endif()
    get_json_value_by_dot_notation(
        IN_JSON_OBJECT    "${CURRENT_POT_OBJECT}"
        IN_DOT_NOTATION   "${DOT_NOTATION}"
        OUT_JSON_VALUE    CURRENT_POT_REFERENCE)
    get_json_value_by_dot_notation(
        IN_JSON_OBJECT    "${CURRENT_PO_LOCALE_OBJECT}"
        IN_DOT_NOTATION   "${DOT_NOTATION}"
        OUT_JSON_VALUE    CURRENT_PO_REFERENCE)
    if(UPDATE_MODE STREQUAL "COMPARE")
        if(NOT CURRENT_POT_REFERENCE STREQUAL CURRENT_PO_REFERENCE)
            set(UPDATE_REQUIRED ON)
        else()
            set(UPDATE_REQUIRED OFF)
        endif()
    elseif(UPDATE_MODE STREQUAL "ALWAYS")
        set(UPDATE_REQUIRED ON)
    elseif(UPDATE_MODE STREQUAL "NEVER")
        if(NOT CURRENT_PO_REFERENCE)
            set(UPDATE_REQUIRED ON)
        else()
            set(UPDATE_REQUIRED OFF)
        endif()
    else()
        message(FATAL_ERROR "Invalid UPDATE_MODE value. (${UPDATE_MODE})")
    endif()
    remove_cmake_message_indent()
    message("")
    message(".pot = ${CURRENT_POT_OBJECT}")
    message(".po.${_LANGUAGE} = ${CURRENT_PO_LOCALE_OBJECT}")
    message("UPDATE_MODE            = ${UPDATE_MODE}")
    message("CURRENT_POT_REFERENCE  = ${CURRENT_POT_REFERENCE}")
    message("CURRENT_PO_REFERENCE   = ${CURRENT_PO_REFERENCE}")
    message("UPDATE_REQUIRED        = ${UPDATE_REQUIRED}")
    message("")
    restore_cmake_message_indent()
    if(NOT UPDATE_REQUIRED)
        message(STATUS "No need to update .po files for '${_LANGUAGE}' language.")
        continue()
    endif()


    message(STATUS "Running 'msgmerge/msgcat' command to update .po files for '${_LANGUAGE}' language...")
    set(POT_DIR "${PROJ_L10N_VERSION_POT_DIR}")
    set(PO_DIR  "${PROJ_L10N_VERSION_PO_DIR}/${_LANGUAGE}/LC_MESSAGES")
    remove_cmake_message_indent()
    message("")
    message("From: ${POT_DIR}/")
    message("To:   ${PO_DIR}/")
    message("")
    file(GLOB_RECURSE POT_FILES "${POT_DIR}/*.pot")
    foreach(POT_FILE ${POT_FILES})
        string(REPLACE "${POT_DIR}/" "" POT_FILE_RELATIVE "${POT_FILE}")
        string(REGEX REPLACE "\\.pot$" ".po" PO_FILE_RELATIVE "${POT_FILE_RELATIVE}")
        set(PO_FILE "${PO_DIR}/${PO_FILE_RELATIVE}")
        get_filename_component(PO_FILE_DIR "${PO_FILE}" DIRECTORY)
        file(MAKE_DIRECTORY "${PO_FILE_DIR}")
        if(EXISTS "${PO_FILE}")
            # If the ${PO_FILE} exists, then merge it using msgmerge.
            message("msgmerge:")
            message("  --lang       ${_LANGUAGE}")
            message("  --width      ${GETTEXT_WRAP_WIDTH}")
            message("  --backup     off")
            message("  --update")
            message("  --force-po")
            message("  --no-fuzzy-matching")
            message("  [def.po]     ${PO_FILE}")
            message("  [ref.pot]    ${POT_FILE}")
            execute_process(
                COMMAND 
                    ${Gettext_MSGMERGE_EXECUTABLE}
                    --lang ${_LANGUAGE} 
                    --width ${GETTEXT_WRAP_WIDTH} 
                    --backup off 
                    --update 
                    --force-po 
                    --no-fuzzy-matching
                    ${PO_FILE}      # [def.po]
                    ${POT_FILE}     # [ref.pot]
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
            # If the ${PO_FILE} doesn't exist, then create it using msgcat.
            message("msgcat:")
            message("  --lang         ${_LANGUAGE}")
            message("  --width        ${GETTEXT_WRAP_WIDTH}")
            message("  --output-file  ${PO_FILE}")
            message("  [inputfile]    ${POT_FILE}")
            execute_process(
                COMMAND 
                    ${Gettext_MSGCAT_EXECUTABLE}
                    --lang ${_LANGUAGE}
                    --width ${GETTEXT_WRAP_WIDTH}
                    --output-file ${PO_FILE}
                    ${POT_FILE}
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
    unset(POT_FILE)
    message("")
    restore_cmake_message_indent()


    set_json_value_by_dot_notation(
        IN_JSON_OBJECT      "${REFERENCE_JSON_CNT}"
        IN_DOT_NOTATION     ".po.${_LANGUAGE}"
        IN_JSON_VALUE       "${CURRENT_POT_OBJECT}"
        OUT_JSON_OBJECT     REFERENCE_JSON_CNT)
endforeach()
unset(_LANGUAGE)


file(WRITE "${REFERENCE_JSON_PATH}" ${REFERENCE_JSON_CNT})
