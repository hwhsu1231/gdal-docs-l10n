# Distributed under the OSI-approved BSD 3-Clause License.
# See accompanying file LICENSE.txt for details.

cmake_minimum_required(VERSION 3.23)
project(cmake-docs-l10n NONE)

#[================[
  Cache Variables.
#]================]

set(LANGUAGE "all"
    CACHE STRING "Language Code for the Sphinx documentation system.")
    # Possible values are "all" and languages listed in languages.json.
    # See https://www.sphinx-doc.org/en/master/usage/configuration.html#confval-language for details.

set(VERSION "git-master"
    CACHE STRING "Current version for the CMake documentation.")
    # Possible values are "git-master", "latest", and "v3.x".

set(BUILDER "html"
    CACHE STRING "Builder for the Sphinx documentation system.")

set(AUTO_DEPEND ON
    CACHE BOOL "Enable automatic dependency management for specific build targets.")

set(UPDATE_MODE "NEVER"
    CACHE STRING "Mode of updating .pot/.po files.")
    # Possible values are "NEVER", "COMPARE", and "ALWAYS".
    # 1) NEVER:   Update .pot/.po files only if they are missing entirely.
    # 2) COMPARE: Update .pot/.po files only if the current version is out-of-date.
    # 3) ALWAYS:  Update .pot/.po files even if the current version is up-to-date.

set(INSTALL_MODE "COMPARE"
    CACHE STRING "Mode of installing the requirements.")
    # Possible values are "COMPARE" and "ALWAYS".
    # 1) COMPARE: Install the requirements only if the current version is different than the previous one.
    # 2) ALWAYS:  Install the requirements even if the current version is the same as the previous one.

set(GIT_REMOTE_URL "https://gitlab.kitware.com/cmake/cmake.git"
    CACHE STRING "Remote URL of the upstream Git repository.")

set(BASEURL_HREF "https://hwhsu1231.github.io/cmake-docs-l10n-draft2"
    CACHE STRING "Base URL of the deployed documentation.")

set(GIT_EXACT_VERSION ""
    CACHE STRING "Exact version for calling find_package(Git).")

set(PYTHON_EXACT_VERSION ""
    CACHE STRING "Exact version for calling find_package(Python).")

set(GETTEXT_EXACT_VERSION ""
    CACHE STRING "Exact version for calling find_package(Gettext).")

set(CROWDIN_EXACT_VERSION ""
    CACHE STRING "Exact version for calling find_package(Crowdin).")

set(COMPENDIUM_VERSION "git-master"
    CACHE STRING "Version of compendium that the current version merges translations from.")

set(CONSOLE_LOCALE "en_US.UTF-8"
    CACHE STRING "Locale setting for the console.")

set(GETTEXT_WRAP_WIDTH 79
    CACHE STRING "Gettext wrap width for .pot/.po files.")

set(GETTEXT_ADDITIONAL_TARGETS "index,literal-block"
    CACHE STRING "Gettext additional targets for building the Sphinx documentation system.")

set(GETTEXT_LANGUAGE_TEAM ""
    CACHE STRING "")

#[============================[
  Directory-Related Variables.
#]============================]

set(PROJ_SOURCE_DIR                 "${PROJECT_SOURCE_DIR}")
set(PROJ_BINARY_DIR                 "${PROJECT_BINARY_DIR}")
set(PROJ_CMAKE_MODULES_DIR          "${PROJ_SOURCE_DIR}/cmake/modules")
set(PROJ_CMAKE_SCRIPTS_DIR          "${PROJ_SOURCE_DIR}/cmake/scripts")
set(PROJ_CMAKE_TEMPLATES_DIR        "${PROJ_SOURCE_DIR}/cmake/templates")
set(PROJ_VENV_DIR                   "${PROJ_SOURCE_DIR}/.venv")
set(PROJ_OUT_DIR                    "${PROJ_SOURCE_DIR}/out")
set(PROJ_OUT_REPO_DIR               "${PROJ_OUT_DIR}/repo")
set(PROJ_OUT_REPO_SPHINX_DIR        "${PROJ_OUT_REPO_DIR}/Utilities/Sphinx")
set(PROJ_OUT_REPO_DOCS_CONFIG_DIR   "${PROJ_OUT_REPO_DIR}/Help")
set(PROJ_OUT_REPO_DOCS_SOURCE_DIR   "${PROJ_OUT_REPO_DIR}/Help")
set(PROJ_OUT_REPO_DOCS_LOCALE_DIR   "${PROJ_OUT_REPO_DIR}/Help/locale")
set(PROJ_OUT_BUILDER_DIR            "${PROJ_OUT_DIR}/${BUILDER}")
set(PROJ_L10N_DIR                   "${PROJ_SOURCE_DIR}/l10n")
set(PROJ_L10N_VERSION_DIR           "${PROJ_L10N_DIR}/${VERSION}")
set(PROJ_L10N_VERSION_POT_DIR       "${PROJ_L10N_VERSION_DIR}/pot")
set(PROJ_L10N_VERSION_PO_DIR        "${PROJ_L10N_VERSION_DIR}/po")
set(PROJ_L10N_VERSION_CROWDIN_DIR   "${PROJ_L10N_VERSION_DIR}/.crowdin")

#[====================[
  Configuration Files.
#]====================]

set(LATEST_TXT_PATH                 "${PROJ_SOURCE_DIR}/latest.txt")
set(LANGUAGES_JSON_PATH             "${PROJ_SOURCE_DIR}/languages.json")
set(REFERENCE_JSON_PATH             "${PROJ_L10N_VERSION_DIR}/reference.json")
set(CROWDIN_YML_PATH                "${PROJ_L10N_VERSION_DIR}/crowdin.yml")
set(PROGRESS_TXT_PATH               "${PROJ_L10N_VERSION_DIR}/progress.txt")
set(STATISTIC_TXT_PATH              "${PROJ_L10N_VERSION_DIR}/statistic.txt")
set(PREVIOUS_FREEZE_TXT_PATH        "${PROJ_OUT_DIR}/prev/freeze.txt")
set(PREVIOUS_VERSION_TXT_PATH       "${PROJ_OUT_DIR}/prev/version.txt")

#[========================================[
  Read LATEST_VERSION from latest.txt.
  Read LANGUAGES_LIST from languages.json.
#]========================================]

set(CMAKE_MODULE_PATH 
    "${PROJ_CMAKE_MODULES_DIR}"
    "${PROJ_CMAKE_MODULES_DIR}/common")
include(JsonUtils)
file(READ "${LATEST_TXT_PATH}"      LATEST_VERSION)
file(READ "${LANGUAGES_JSON_PATH}"  LANGUAGES_JSON_CNT)
get_members_of_json_object(
    IN_JSON_OBJECT      "${LANGUAGES_JSON_CNT}"
    OUT_MEMBER_NAMES    LANGUAGES_LIST)

#[====================================[
  Validate the VERSION cache variable.
  - For "git-master":
    - set VERSION_TYPE to "branch"
    - set BRANCH_NAME 
  - For "latest" and "v3.x":
    - set VERSION_TYPE to "tag"
    - set TAG_PATTERN
#]====================================]

if (VERSION MATCHES     "^git-master$")
    set(VERSION_TYPE    "branch")
    set(BRANCH_NAME     "master")
elseif(VERSION MATCHES  "^latest$")
    set(VERSION_TYPE    "tag")
    set(TAG_PATTERN     "${LATEST_VERSION}.*")
elseif(VERSION MATCHES  "^v([0-9]+)\\.([0-9]+)$")
    set(VERSION_TYPE    "tag")
    set(TAG_PATTERN     "${VERSION}.*")
else()
    message(FATAL_ERROR "Invalid VERSION value. (${VERSION})")
endif()

#[=====================================[
  Validate the LANGUAGE cache variable.
#]=====================================]

set(LANGUAGE_IS_VALID FALSE)
if(LANGUAGE STREQUAL "all")
    set(LANGUAGE_IS_VALID TRUE)
else()
    foreach(_LANGUAGE ${LANGUAGES_LIST})
        if(LANGUAGE STREQUAL _LANGUAGE)
            set(LANGUAGE_IS_VALID TRUE)
        endif()
    endforeach()
    unset(_LANGUAGE)
endif()
if(NOT LANGUAGE_IS_VALID)
    message(FATAL_ERROR "Invalid LANGUAGE value. (${LANGUAGE})")
endif()

#[========================================[
  Validate the UPDATE_MODE cache variable.
#]========================================]

if (NOT UPDATE_MODE STREQUAL "COMPARE" AND 
    NOT UPDATE_MODE STREQUAL "ALWAYS" AND 
    NOT UPDATE_MODE STREQUAL "NEVER")
    message(FATAL_ERROR "Invalid UPDATE_MODE value. (${UPDATE_MODE})")
endif()

#[=========================================[
  Validate the INSTALL_MODE cache variable.
#]=========================================]

if (NOT INSTALL_MODE STREQUAL "COMPARE" AND 
    NOT INSTALL_MODE STREQUAL "ALWAYS")
    message(FATAL_ERROR "Invalid INSTALL_MODE value. (${INSTALL_MODE})")
endif()

#[=============================================================[
  Initialize a reference.json file in ${PROJ_L10N_VERSION_DIR}.
#]=============================================================]

init_reference_json_file(
    IN_FILEPATH     "${REFERENCE_JSON_PATH}"
    IN_LANGUAGES    "${LANGUAGES_LIST}"
    IN_TYPE         "${VERSION_TYPE}"
    IN_VERSION      "${VERSION}")

#[=========================================================[
  Configure a crowdin.yml file in ${PROJ_L10N_VERSION_DIR}.
#]=========================================================]

configure_file(
    "${PROJ_CMAKE_TEMPLATES_DIR}/crowdin.yml.in"
    "${CROWDIN_YML_PATH}"
    COPYONLY)

#[====================[
  Check prerequisites.
#]====================]

set(FIND_PACKAGE_GIT_ARGS)
if(GIT_EXACT_VERSION)
    set(GIT_EXACT_VERSION_ARGS ${GIT_EXACT_VERSION} EXACT)
else()
    set(GIT_EXACT_VERSION_ARGS)
endif()
set(FIND_PACKAGE_GIT_ARGS
    ${GIT_EXACT_VERSION_ARGS})

set(FIND_PACKAGE_PYTHON_ARGS)
if(PYTHON_EXACT_VERSION)
    set(PYTHON_EXACT_VERSION_ARGS ${PYTHON_EXACT_VERSION} EXACT)
else()
    set(PYTHON_EXACT_VERSION_ARGS)
endif()
set(FIND_PACKAGE_PYTHON_ARGS
    ${PYTHON_EXACT_VERSION_ARGS})

set(FIND_PACKAGE_GETTEXT_ARGS)

set(FIND_PACKAGE_CROWDIN_ARGS)

find_package(Git      MODULE QUIET ${FIND_PACKAGE_GIT_ARGS})
find_package(Python   MODULE QUIET ${FIND_PACKAGE_PYTHON_ARGS})
find_package(Gettext  MODULE QUIET ${FIND_PACKAGE_GETTEXT_ARGS})
find_package(Crowdin  MODULE QUIET ${FIND_PACKAGE_CROWDIN_ARGS})

#[==================[
  Print Information.
#]==================]

message(STATUS "---------- Cache Variables ----------")
message(STATUS "VERSION                       = ${VERSION}")
message(STATUS "LANGUAGE                      = ${LANGUAGE}")
message(STATUS "BUILDER                       = ${BUILDER}")
message(STATUS "AUTO_DEPEND                   = ${AUTO_DEPEND}")
message(STATUS "UPDATE_MODE                   = ${UPDATE_MODE}")
message(STATUS "INSTALL_MODE                  = ${INSTALL_MODE}")
message(STATUS "GIT_REMOTE_URL                = ${GIT_REMOTE_URL}")
message(STATUS "BASEURL_HREF                  = ${BASEURL_HREF}")
message(STATUS "GIT_EXACT_VERSION             = ${GIT_EXACT_VERSION}")
message(STATUS "PYTHON_EXACT_VERSION          = ${PYTHON_EXACT_VERSION}")
message(STATUS "GETTEXT_EXACT_VERSION         = ${GETTEXT_EXACT_VERSION}")
message(STATUS "CROWDIN_EXACT_VERSION         = ${CROWDIN_EXACT_VERSION}")
message(STATUS "COMPENDIUM_VERSION            = ${COMPENDIUM_VERSION}")
message(STATUS "CONSOLE_LOCALE                = ${CONSOLE_LOCALE}")
message(STATUS "GETTEXT_WRAP_WIDTH            = ${GETTEXT_WRAP_WIDTH}")
message(STATUS "GETTEXT_ADDITIONAL_TARGETS    = ${GETTEXT_ADDITIONAL_TARGETS}")
message(STATUS "GETTEXT_LANGUAGE_TEAM         = ${GETTEXT_LANGUAGE_TEAM}")
message(STATUS "---------- Directory-Related Variables ----------")
message(STATUS "PROJ_SOURCE_DIR               = ${PROJ_SOURCE_DIR}")
message(STATUS "PROJ_BINARY_DIR               = ${PROJ_BINARY_DIR}")
message(STATUS "PROJ_CMAKE_MODULES_DIR        = ${PROJ_CMAKE_MODULES_DIR}")
message(STATUS "PROJ_CMAKE_SCRIPTS_DIR        = ${PROJ_CMAKE_SCRIPTS_DIR}")
message(STATUS "PROJ_CMAKE_TEMPLATES_DIR      = ${PROJ_CMAKE_TEMPLATES_DIR}")
message(STATUS "PROJ_VENV_DIR                 = ${PROJ_VENV_DIR}")
message(STATUS "PROJ_OUT_DIR                  = ${PROJ_OUT_DIR}")
message(STATUS "PROJ_OUT_REPO_DIR             = ${PROJ_OUT_REPO_DIR}")
message(STATUS "PROJ_OUT_REPO_SPHINX_DIR      = ${PROJ_OUT_REPO_SPHINX_DIR}")
message(STATUS "PROJ_OUT_REPO_DOCS_CONFIG_DIR = ${PROJ_OUT_REPO_DOCS_CONFIG_DIR}")
message(STATUS "PROJ_OUT_REPO_DOCS_SOURCE_DIR = ${PROJ_OUT_REPO_DOCS_SOURCE_DIR}")
message(STATUS "PROJ_OUT_REPO_DOCS_LOCALE_DIR = ${PROJ_OUT_REPO_DOCS_LOCALE_DIR}")
message(STATUS "PROJ_OUT_BUILDER_DIR          = ${PROJ_OUT_BUILDER_DIR}")
message(STATUS "PROJ_L10N_DIR                 = ${PROJ_L10N_DIR}")
message(STATUS "PROJ_L10N_VERSION_DIR         = ${PROJ_L10N_VERSION_DIR}")
message(STATUS "PROJ_L10N_VERSION_POT_DIR     = ${PROJ_L10N_VERSION_POT_DIR}")
message(STATUS "PROJ_L10N_VERSION_PO_DIR      = ${PROJ_L10N_VERSION_PO_DIR}")
message(STATUS "PROJ_L10N_VERSION_CROWDIN_DIR = ${PROJ_L10N_VERSION_CROWDIN_DIR}")
message(STATUS "---------- Configuration Files ----------")
message(STATUS "LANGUAGES_JSON_PATH           = ${LANGUAGES_JSON_PATH}")
message(STATUS "REFERENCE_JSON_PATH           = ${REFERENCE_JSON_PATH}")
message(STATUS "CROWDIN_YML_PATH              = ${CROWDIN_YML_PATH}")
message(STATUS "PROGRESS_TXT_PATH             = ${PROGRESS_TXT_PATH}")
message(STATUS "STATISTIC_TXT_PATH            = ${STATISTIC_TXT_PATH}")
message(STATUS "PREVIOUS_FREEZE_TXT_PATH      = ${PREVIOUS_FREEZE_TXT_PATH}")
message(STATUS "PREVIOUS_VERSION_TXT_PATH     = ${PREVIOUS_VERSION_TXT_PATH}")
message(STATUS "---------- Other Variables ----------")
message(STATUS "LANGUAGES_LIST                = ${LANGUAGES_LIST}")
message(STATUS "LATEST_VERSION                = ${LATEST_VERSION}")
message(STATUS "VERSION_TYPE                  = ${VERSION_TYPE}")
message(STATUS "BRANCH_NAME                   = ${BRANCH_NAME}")
message(STATUS "TAG_PATTERN                   = ${TAG_PATTERN}")
message(STATUS "FIND_PACKAGE_GIT_ARGS         = ${FIND_PACKAGE_GIT_ARGS}")
message(STATUS "FIND_PACKAGE_PYTHON_ARGS      = ${FIND_PACKAGE_PYTHON_ARGS}")
message(STATUS "FIND_PACKAGE_GETTEXT_ARGS     = ${FIND_PACKAGE_GETTEXT_ARGS}")
message(STATUS "FIND_PACKAGE_CROWDIN_ARGS     = ${FIND_PACKAGE_CROWDIN_ARGS}")
message(STATUS "---------- Prerequisites ----------")
message(STATUS "CMAKE_VERSION                 = ${CMAKE_VERSION}")
message(STATUS "CMAKE_COMMAND                 = ${CMAKE_COMMAND}")
message(STATUS "CMAKE_GENERATOR               = ${CMAKE_GENERATOR}")
message(STATUS "Git_FOUND                     = ${Git_FOUND}")
message(STATUS "Git_VERSION                   = ${Git_VERSION}")
message(STATUS "Git_EXECUTABLE                = ${Git_EXECUTABLE}")
message(STATUS "Python_FOUND                  = ${Python_FOUND}")
message(STATUS "Python_VERSION                = ${Python_VERSION}")
message(STATUS "Python_EXECUTABLE             = ${Python_EXECUTABLE}")
message(STATUS "Gettext_FOUND                 = ${Gettext_FOUND}")
message(STATUS "Gettext_VERSION               = ${Gettext_VERSION}")
message(STATUS "Gettext_XGETTEXT_EXECUTABLE   = ${Gettext_XGETTEXT_EXECUTABLE}")
message(STATUS "Crowdin_FOUND                 = ${Crowdin_FOUND}")
message(STATUS "Crowdin_VERSION               = ${Crowdin_VERSION}")
message(STATUS "Crowdin_EXECUTABLE            = ${Crowdin_EXECUTABLE}")
message(STATUS "----------------------------------------")

#[=========================================[
  Escape ';' characters for list variables.
#]=========================================]

string(REPLACE ";" "\\\\;" LANGUAGES_LIST "${LANGUAGES_LIST}")
string(REPLACE ";" "\\\\;" FIND_PACKAGE_GIT_ARGS "${FIND_PACKAGE_GIT_ARGS}")
string(REPLACE ";" "\\\\;" FIND_PACKAGE_PYTHON_ARGS "${FIND_PACKAGE_PYTHON_ARGS}")
string(REPLACE ";" "\\\\;" FIND_PACKAGE_GETTEXT_ARGS "${FIND_PACKAGE_GETTEXT_ARGS}")
string(REPLACE ";" "\\\\;" FIND_PACKAGE_CROWDIN_ARGS "${FIND_PACKAGE_CROWDIN_ARGS}")

#[===========================================[
  Cache variables passed to script mode '-E'.
#]===========================================]

set(SCRIPT_MODE_CACHE
    # [Cache Variables]
    -D LANGUAGE=${LANGUAGE}
    -D VERSION=${VERSION}
    -D BUILDER=${BUILDER}
    -D AUTO_DEPEND=${AUTO_DEPEND}
    -D UPDATE_MODE=${UPDATE_MODE}
    -D INSTALL_MODE=${INSTALL_MODE}
    -D GIT_REMOTE_URL=${GIT_REMOTE_URL}
    -D BASEURL_HREF=${BASEURL_HREF}
    -D COMPENDIUM_VERSION=${COMPENDIUM_VERSION}
    -D CONSOLE_LOCALE=${CONSOLE_LOCALE}
    -D GETTEXT_WRAP_WIDTH=${GETTEXT_WRAP_WIDTH}
    -D GETTEXT_ADDITIONAL_TARGETS=${GETTEXT_ADDITIONAL_TARGETS}
    -D GETTEXT_LANGUAGE_TEAM=${GETTEXT_LANGUAGE_TEAM}
    # [Directory-Related Variables]
    -D PROJ_SOURCE_DIR=${PROJ_SOURCE_DIR}
    -D PROJ_BINARY_DIR=${PROJ_BINARY_DIR}
    -D PROJ_CMAKE_MODULES_DIR=${PROJ_CMAKE_MODULES_DIR}
    -D PROJ_CMAKE_SCRIPTS_DIR=${PROJ_CMAKE_SCRIPTS_DIR}
    -D PROJ_CMAKE_TEMPLATES_DIR=${PROJ_CMAKE_TEMPLATES_DIR}
    -D PROJ_VENV_DIR=${PROJ_VENV_DIR}
    -D PROJ_OUT_DIR=${PROJ_OUT_DIR}
    -D PROJ_OUT_REPO_DIR=${PROJ_OUT_REPO_DIR}
    -D PROJ_OUT_REPO_SPHINX_DIR=${PROJ_OUT_REPO_SPHINX_DIR}
    -D PROJ_OUT_REPO_DOCS_CONFIG_DIR=${PROJ_OUT_REPO_DOCS_CONFIG_DIR}
    -D PROJ_OUT_REPO_DOCS_SOURCE_DIR=${PROJ_OUT_REPO_DOCS_SOURCE_DIR}
    -D PROJ_OUT_REPO_DOCS_LOCALE_DIR=${PROJ_OUT_REPO_DOCS_LOCALE_DIR}
    -D PROJ_OUT_BUILDER_DIR=${PROJ_OUT_BUILDER_DIR}
    -D PROJ_L10N_DIR=${PROJ_L10N_DIR}
    -D PROJ_L10N_VERSION_DIR=${PROJ_L10N_VERSION_DIR}
    -D PROJ_L10N_VERSION_POT_DIR=${PROJ_L10N_VERSION_POT_DIR}
    -D PROJ_L10N_VERSION_PO_DIR=${PROJ_L10N_VERSION_PO_DIR}
    -D PROJ_L10N_VERSION_CROWDIN_DIR=${PROJ_L10N_VERSION_CROWDIN_DIR}
    # [Configuration Files]
    -D LATEST_TXT_PATH=${LATEST_TXT_PATH}
    -D LANGUAGES_JSON_PATH=${LANGUAGES_JSON_PATH}
    -D REFERENCE_JSON_PATH=${REFERENCE_JSON_PATH}
    -D CROWDIN_YML_PATH=${CROWDIN_YML_PATH}
    -D PROGRESS_TXT_PATH=${PROGRESS_TXT_PATH}
    -D STATISTIC_TXT_PATH=${STATISTIC_TXT_PATH}
    -D PREVIOUS_FREEZE_TXT_PATH=${PREVIOUS_FREEZE_TXT_PATH}
    -D PREVIOUS_VERSION_TXT_PATH=${PREVIOUS_VERSION_TXT_PATH}
    # [Other Variables]
    -D LANGUAGES_LIST=${LANGUAGES_LIST}
    -D LATEST_VERSION=${LATEST_VERSION}
    -D VERSION_TYPE=${VERSION_TYPE}
    -D BRANCH_NAME=${BRANCH_NAME}
    -D TAG_PATTERN=${TAG_PATTERN}
    -D FIND_PACKAGE_GIT_ARGS=${FIND_PACKAGE_GIT_ARGS}
    -D FIND_PACKAGE_PYTHON_ARGS=${FIND_PACKAGE_PYTHON_ARGS}
    -D FIND_PACKAGE_GETTEXT_ARGS=${FIND_PACKAGE_GETTEXT_ARGS}
    -D FIND_PACKAGE_CROWDIN_ARGS=${FIND_PACKAGE_CROWDIN_ARGS})

#[====================[
  Fundamental targets.
#]====================]

add_custom_target(prepare_git_repo
    COMMAND 
        ${CMAKE_COMMAND}
        ${SCRIPT_MODE_CACHE} 
        -P ${PROJ_CMAKE_SCRIPTS_DIR}/prepare_git_repo.cmake
    VERBATIM)

add_custom_target(venv_pip_install
    COMMAND 
        ${CMAKE_COMMAND}
        ${SCRIPT_MODE_CACHE} 
        -P ${PROJ_CMAKE_SCRIPTS_DIR}/venv_pip_install.cmake
    VERBATIM)

add_custom_target(sphinx_update_pot
    COMMAND 
        ${CMAKE_COMMAND}
        ${SCRIPT_MODE_CACHE} 
        -P ${PROJ_CMAKE_SCRIPTS_DIR}/sphinx_update_pot.cmake
    VERBATIM)

add_custom_target(gettext_update_po
    COMMAND 
        ${CMAKE_COMMAND}
        ${SCRIPT_MODE_CACHE} 
        -P ${PROJ_CMAKE_SCRIPTS_DIR}/gettext_update_po.cmake
    VERBATIM)

add_custom_target(sphinx_build_docs
    COMMAND
        ${CMAKE_COMMAND}
        ${SCRIPT_MODE_CACHE} 
        -P ${PROJ_CMAKE_SCRIPTS_DIR}/sphinx_build_docs.cmake
    VERBATIM)

#[=================[
  Optional targets.
#]=================]

add_custom_target(statistic_po
    COMMAND
        ${CMAKE_COMMAND}
        ${SCRIPT_MODE_CACHE}
        -P ${PROJ_CMAKE_SCRIPTS_DIR}/statistic_po.cmake
    VERBATIM)

add_custom_target(crowdin_upload_pot
    COMMAND 
        ${CMAKE_COMMAND}
        ${SCRIPT_MODE_CACHE} 
        -P ${PROJ_CMAKE_SCRIPTS_DIR}/crowdin_upload_pot.cmake
    VERBATIM)

add_custom_target(crowdin_download_po
    COMMAND 
        ${CMAKE_COMMAND}
        ${SCRIPT_MODE_CACHE} 
        -P ${PROJ_CMAKE_SCRIPTS_DIR}/crowdin_download_po.cmake
    VERBATIM)

add_custom_target(crowdin_status
    COMMAND 
        ${CMAKE_COMMAND}
        ${SCRIPT_MODE_CACHE} 
        -P ${PROJ_CMAKE_SCRIPTS_DIR}/crowdin_status.cmake
    VERBATIM)

add_custom_target(merge_compendium
    COMMAND 
        ${CMAKE_COMMAND}
        ${SCRIPT_MODE_CACHE} 
        -P ${PROJ_CMAKE_SCRIPTS_DIR}/merge_compendium.cmake
    VERBATIM)

if(AUTO_DEPEND)
    add_dependencies(venv_pip_install   prepare_git_repo)
    add_dependencies(sphinx_update_pot  venv_pip_install)
    add_dependencies(gettext_update_po  sphinx_update_pot)
    add_dependencies(sphinx_build_docs  gettext_update_po)
endif()
