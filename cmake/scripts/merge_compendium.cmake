# Distributed under the OSI-approved BSD 3-Clause License.
# See accompanying file LICENSE.txt for details.

get_filename_component(SCRIPT_NAME "${CMAKE_CURRENT_LIST_FILE}" NAME_WE)
set(CMAKE_MESSAGE_INDENT "[${VERSION}][${LANGUAGE}] ")
set(CMAKE_MESSAGE_INDENT_BACKUP "${CMAKE_MESSAGE_INDENT}")
message(STATUS "-------------------- ${SCRIPT_NAME} --------------------")


set(CMAKE_MODULE_PATH 
    "${PROJ_CMAKE_MODULES_DIR}"
    "${PROJ_CMAKE_MODULES_DIR}/common")
find_package(Gettext  MODULE ${FIND_PACKAGE_GETTEXT_ARGS} REQUIRED)
include(LogUtils)


if (COMPENDIUM_VERSION STREQUAL VERSION OR
    COMPENDIUM_VERSION STREQUAL "")
    message(STATUS "No need to merge translations from compendium.")
    return()
endif()


foreach(_LANGUAGE ${LANGUAGES_LIST})
    set(SRC_VERSION       "${COMPENDIUM_VERSION}")
    set(SRC_PO_DIR        "${PROJ_L10N_DIR}/${SRC_VERSION}/po/${_LANGUAGE}/LC_MESSAGES")
    set(SRC_PO_COMPENDIUM "${PROJ_L10N_DIR}/${SRC_VERSION}/.compendium/${_LANGUAGE}.po")
    set(DST_VERSION       "${VERSION}")
    set(DST_PO_DIR        "${PROJ_L10N_DIR}/${DST_VERSION}/po/${_LANGUAGE}/LC_MESSAGES")
    set(DST_POT_DIR       "${PROJ_L10N_DIR}/${DST_VERSION}/pot")
    remove_cmake_message_indent()
    message("")
    message("SRC_VERSION        = ${SRC_VERSION}")
    message("SRC_PO_DIR         = ${SRC_PO_DIR}")
    message("SRC_PO_COMPENDIUM  = ${SRC_PO_COMPENDIUM}")
    message("DST_VERSION        = ${DST_VERSION}")
    message("DST_PO_DIR         = ${DST_PO_DIR}")
    message("DST_POT_DIR        = ${DST_POT_DIR}")
    message("")
    restore_cmake_message_indent()


    message(STATUS "Running 'msgcat' command to concatenate translations of '${COMPENDIUM_VERSION}' version for '${_LANGUAGE}' language...")
    get_filename_component(SRC_PO_COMPENDIUM_DIR "${SRC_PO_COMPENDIUM}" DIRECTORY)
    file(MAKE_DIRECTORY "${SRC_PO_COMPENDIUM_DIR}")
    file(GLOB_RECURSE SRC_PO_FILES "${SRC_PO_DIR}/*.po")
    remove_cmake_message_indent()
    message("")
    message("msgcat:")
    message("  --output-file ${SRC_PO_COMPENDIUM}")
    message("  --use-first")
    foreach(SRC_PO_FILE ${SRC_PO_FILES})
    message("  ${SRC_PO_FILE}")
    endforeach()
    execute_process(
        COMMAND 
            ${Gettext_MSGCAT_EXECUTABLE}
            --output-file ${SRC_PO_COMPENDIUM}
            --use-first
            ${SRC_PO_FILES}
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


    message(STATUS "Running 'msgmerge' command to merge translations from '${COMPENDIUM_VERSION}' version...")
    file(GLOB_RECURSE DST_PO_FILES "${DST_PO_DIR}/*.po")
    remove_cmake_message_indent()
    message("")
    foreach(DST_PO_FILE ${DST_PO_FILES})
        string(REPLACE "${DST_PO_DIR}/" "" DST_PO_FILE_RELATIVE "${DST_PO_FILE}")
        set(DST_PO_FILE "${DST_PO_DIR}/${DST_PO_FILE_RELATIVE}")
        string(REGEX REPLACE "\\.po$" ".pot" DST_POT_FILE_RELATIVE "${DST_PO_FILE_RELATIVE}")
        set(DST_POT_FILE "${DST_POT_DIR}/${DST_POT_FILE_RELATIVE}")
        message("msgmerge:")
        message("  --lang         ${_LANGUAGE}")
        message("  --width        ${GETTEXT_WRAP_WIDTH}")
        message("  --compendium   ${SRC_PO_COMPENDIUM}")
        message("  --output-file  ${DST_PO_FILE}")
        message("  [def.po]       ${DST_POT_FILE}")
        message("  [ref.pot]      ${DST_POT_FILE}")
        execute_process(
            COMMAND 
                ${Gettext_MSGMERGE_EXECUTABLE}
                --lang ${_LANGUAGE}
                --width ${GETTEXT_WRAP_WIDTH}
                --compendium ${SRC_PO_COMPENDIUM}
                --output-file ${DST_PO_FILE}
                ${DST_POT_FILE}   # [def.po]
                ${DST_POT_FILE}   # [ref.pot]
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
    unset(DST_PO_FILE)
    message("")
    restore_cmake_message_indent()
endforeach()
unset(_LANGUAGE)
