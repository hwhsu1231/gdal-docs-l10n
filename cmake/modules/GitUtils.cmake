# Distributed under the OSI-approved BSD 3-Clause License.
# See accompanying file LICENSE.txt for details.

#[============================================================[.rst
GitUtilities
------------

.. command:: get_git_latest_commit_on_branch_name

  .. code-block:: cmake

    get_git_latest_commit_on_branch_name(
        IN_REPO_PATH    "${GIT_CLONE_PATH}"
        IN_BRANCH_NAME  "${BRANCH_NAME}"
        OUT_DATE        LATEST_POT_COMMIT_DATE
        OUT_HASH        LATEST_POT_COMMIT_HASH
        OUT_TITLE       LATEST_POT_COMMIT_TITLE)

.. command:: get_git_latest_tag_on_tag_pattern

  .. code-block:: cmake

    get_git_latest_tag_on_tag_pattern(
        IN_REPO_PATH    "${GIT_CLONE_PATH}"
        IN_TAG_PATTERN  "${TAG_PATTERN}"
        OUT_TAG         LATEST_POT_TAG)

#]============================================================]


function(get_git_latest_commit_on_branch_name)
    #
    # Parse arguments.
    #
    set(COMMIT_OPTIONS)
    set(COMMIT_ONE_VALUE_ARGS   IN_REPO_PATH
                                IN_BRANCH_NAME
                                OUT_DATE
                                OUT_HASH
                                OUT_TITLE)
    set(COMMIT_MULTI_VALUE_ARGS)
    cmake_parse_arguments(ARGS 
        "${COMMIT_OPTIONS}"
        "${COMMIT_ONE_VALUE_ARGS}"
        "${COMMIT_MULTI_VALUE_ARGS}"
        ${ARGN})
    #
    # Ensure all required arguments are provided.
    #
    set(REQUIRED_ARGS           IN_REPO_PATH
                                IN_BRANCH_NAME 
                                OUT_DATE 
                                OUT_HASH 
                                OUT_TITLE)
    foreach(ARG ${REQUIRED_ARGS})
        if(NOT DEFINED ARGS_${ARG})
            message(FATAL_ERROR "Missing ARGS_${ARG} argument.")
        endif()
    endforeach()
    unset(ARG)
    #
    # Get the 'hash'  of the latest commit.
    #
    if(NOT EXISTS "${Git_EXECUTABLE}")
        find_package(Git QUIET MODULE REQUIRED)
    endif()
    execute_process(
        COMMAND "${Git_EXECUTABLE}" show -s --format=%H ${ARGS_IN_BRANCH_NAME}
        WORKING_DIRECTORY "${ARGS_IN_REPO_PATH}"
        RESULT_VARIABLE RES_VAR
        OUTPUT_VARIABLE LATEST_COMMIT_HASH
        ERROR_VARIABLE  ERR_VAR
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_STRIP_TRAILING_WHITESPACE)
    if(NOT RES_VAR EQUAL 0)
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
    #
    # Get the 'date'  of the latest commit.
    #
    execute_process(
        COMMAND "${Git_EXECUTABLE}" show -s --format=%ci ${ARGS_IN_BRANCH_NAME}
        WORKING_DIRECTORY "${ARGS_IN_REPO_PATH}"
        RESULT_VARIABLE RES_VAR
        OUTPUT_VARIABLE LATEST_COMMIT_DATE 
        ERROR_VARIABLE  ERR_VAR
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_STRIP_TRAILING_WHITESPACE)
    if(NOT RES_VAR EQUAL 0)
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
    #
    # Get the 'title' of the latest commit.
    #
    execute_process(
        COMMAND "${Git_EXECUTABLE}" show -s --format=%s ${ARGS_IN_BRANCH_NAME}
        WORKING_DIRECTORY "${ARGS_IN_REPO_PATH}"
        RESULT_VARIABLE RES_VAR
        OUTPUT_VARIABLE LATEST_COMMIT_TITLE
        ERROR_VARIABLE  ERR_VAR
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_STRIP_TRAILING_WHITESPACE)
    if(NOT RES_VAR EQUAL 0)
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
    #
    # Return OUT_DATE, OUT_HASH, and OUT_TITLE.
    #
    set(${ARGS_OUT_DATE} ${LATEST_COMMIT_DATE} PARENT_SCOPE)
    set(${ARGS_OUT_HASH} ${LATEST_COMMIT_HASH} PARENT_SCOPE)
    set(${ARGS_OUT_TITLE} ${LATEST_COMMIT_TITLE} PARENT_SCOPE)
endfunction()


function(get_git_latest_tag_on_tag_pattern)
    #
    # Parse arguments.
    #
    set(TAG_OPTIONS)
    set(TAG_ONE_VALUE_ARGS      IN_REPO_PATH 
                                IN_TAG_PATTERN 
                                OUT_TAG)
    set(TAG_MULTI_VALUE_ARGS)
    cmake_parse_arguments(ARGS 
        "${TAG_OPTIONS}"
        "${TAG_ONE_VALUE_ARGS}"
        "${TAG_MULTI_VALUE_ARGS}"
        ${ARGN})
    #
    # Ensure all required arguments are provided.
    #
    set(REQUIRED_ARGS           IN_REPO_PATH 
                                IN_TAG_PATTERN 
                                OUT_TAG)
    foreach(ARG ${REQUIRED_ARGS})
        if(NOT DEFINED ARGS_${ARG})
            message(FATAL_ERROR "Missing ARGS_${ARG} argument.")
        endif()
    endforeach()
    if(NOT EXISTS "${Git_EXECUTABLE}")
        find_package(Git QUIET MODULE REQUIRED)
    endif()
    #
    # Get a list of tags matching the tag pattern.
    #
    execute_process(
        COMMAND "${Git_EXECUTABLE}" tag --list
            --sort=-v:refname
            "${ARGS_IN_TAG_PATTERN}"
        WORKING_DIRECTORY "${PROJ_OUT_REPO_DIR}"
        RESULT_VARIABLE RES_VAR
        OUTPUT_VARIABLE OUT_VAR
        ERROR_VARIABLE  ERR_VAR
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_STRIP_TRAILING_WHITESPACE)
    string(REPLACE "\n" ";" TAG_LIST "${OUT_VAR}")
    #
    # Get a list of release candidate tags matching the tag pattern.
    #
    execute_process(
        COMMAND "${Git_EXECUTABLE}" tag --list
            --sort=-v:refname
            "${ARGS_IN_TAG_PATTERN}-rc*"
        WORKING_DIRECTORY "${PROJ_OUT_REPO_DIR}"
        RESULT_VARIABLE RES_VAR
        OUTPUT_VARIABLE OUT_VAR
        ERROR_VARIABLE  ERR_VAR
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_STRIP_TRAILING_WHITESPACE)
    string(REPLACE "\n" ";" TAG_RC_LIST "${OUT_VAR}")
    #
    # Get a list of release tags matching the tag pattern.
    #
    set(TAG_REL_LIST "${TAG_LIST}")
    list(REMOVE_ITEM TAG_REL_LIST ${TAG_RC_LIST})
    #
    # Get the max release candidate tag.
    #
    if(TAG_RC_LIST)
        list(GET TAG_RC_LIST 0 TAG_RC_MAX)
    else()
        set(TAG_RC_MAX)
    endif()
    #
    # Get the max release tag.
    #
    if(TAG_REL_LIST)
        list(GET TAG_REL_LIST 0 TAG_REL_MAX)
    else()
        set(TAG_REL_MAX)
    endif()
    #
    # If there exists ${TAG_REL_MAX}, consider release version.
    # Otherwise, consider release candidate version.
    #
    if(NOT TAG_REL_MAX STREQUAL "")
        set(LATEST_TAG ${TAG_REL_MAX})
    else()
        if(NOT TAG_RC_MAX STREQUAL "")
            set(LATEST_TAG ${TAG_RC_MAX})
        else()
            message(FATAL_ERROR "There is no available tag on ${ARGS_IN_TAG_PATTERN}")
        endif()
    endif()
    #
    # Return the latest tag on ${ARGS_IN_TAG_PATTERN}.
    #
    set(${ARGS_OUT_TAG} "${LATEST_TAG}" PARENT_SCOPE)
endfunction()
