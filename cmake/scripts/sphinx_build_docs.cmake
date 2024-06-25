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
set(Python_ROOT_DIR "${PROJ_VENV_DIR}")
find_package(Git      MODULE ${FIND_PACKAGE_GIT_ARGS}     REQUIRED)
find_package(Python   MODULE ${FIND_PACKAGE_PYTHON_ARGS}  REQUIRED)
find_package(Gettext  MODULE ${FIND_PACKAGE_GETTEXT_ARGS} REQUIRED)
find_package(Sphinx   MODULE REQUIRED)
include(JsonUtils)
include(LogUtils)
set(ENV{LANG} "${CONSOLE_LOCALE}")
if (CMAKE_HOST_WIN32)
    set(ENV{PATH} "${PROJ_VENV_DIR}/lib")
else()
    set(ENV{LD_LIBRARY_PATH} "${PROJ_VENV_DIR}/lib")
endif()


if(NOT LANGUAGE STREQUAL "all")
    set(PO_SRC_DIR "${PROJ_L10N_VERSION_PO_DIR}/${LANGUAGE}/LC_MESSAGES")
    set(PO_DST_DIR "${PROJ_OUT_REPO_DOCS_LOCALE_DIR}/${LANGUAGE}/LC_MESSAGES")
else()
    set(PO_SRC_DIR "${PROJ_L10N_VERSION_PO_DIR}")
    set(PO_DST_DIR "${PROJ_OUT_REPO_DOCS_LOCALE_DIR}")
endif()
message(STATUS "Copying .po files to the cloned repository...")
remove_cmake_message_indent()
message("")
message("From: ${PO_SRC_DIR}/")
message("To:   ${PO_DST_DIR}/")
message("")
file(GLOB_RECURSE PO_SRC_FILES "${PO_SRC_DIR}/*")
foreach(PO_SRC_FILE ${PO_SRC_FILES})
    string(REPLACE "${PO_SRC_DIR}/" "" PO_SRC_FILE_RELATIVE "${PO_SRC_FILE}")
    set(PO_DST_FILE "${PO_DST_DIR}/${PO_SRC_FILE_RELATIVE}")
    get_filename_component(PO_DST_FILE_DIR "${PO_DST_FILE}" DIRECTORY)
    file(MAKE_DIRECTORY "${PO_DST_FILE_DIR}")
    file(COPY_FILE "${PO_SRC_FILE}" "${PO_DST_FILE}")
    message("Copied: ${PO_DST_FILE}")
endforeach()
unset(PO_SRC_FILE)
message("")
restore_cmake_message_indent()


file(RELATIVE_PATH LOCALE_TO_SOURCE_DIR
    "${PROJ_OUT_REPO_DOCS_SOURCE_DIR}"
    "${PROJ_OUT_REPO_DOCS_LOCALE_DIR}")
if(NOT LANGUAGE STREQUAL "all")
    set(LANGUAGES_LIST "${LANGUAGE}")
endif()
foreach(_LANGUAGE ${LANGUAGES_LIST})
    message(STATUS "Running 'sphinx-build' command with '${BUILDER}' builder to build documentation for '${_LANGUAGE}' language...")
    remove_cmake_message_indent()
    message("")
    if(CMAKE_HOST_UNIX)
        set(ENV{PATH}             "${PROJ_SOURCE_DIR}/.conda/bin:$ENV{PATH}")
        set(ENV{LD_LIBRARY_PATH}  "${PROJ_SOURCE_DIR}/.conda/lib:$ENV{LD_LIBRARY_PATH}")
        set(ENV{PYTHONPATH}       "${PROJ_SOURCE_DIR}/.conda/lib:$ENV{PYTHONPATH}")
    endif()
    execute_process(
        COMMAND
            conda run --prefix ${PROJ_SOURCE_DIR}/.conda --verbose --no-capture-output
            ${Sphinx_BUILD_EXECUTABLE}
            -b ${BUILDER}
            -D locale_dirs=${LOCALE_TO_SOURCE_DIR}            # Relative to <sourcedir>
            -D language=${_LANGUAGE}
            -D gettext_compact=0
            -D gettext_additional_targets=${GETTEXT_ADDITIONAL_TARGETS}
            -c ${PROJ_OUT_REPO_DOCS_CONFIG_DIR}               # <configdir>, where conf.py locates.
            ${PROJ_OUT_REPO_DOCS_SOURCE_DIR}                  # <sourcedir>, where index.rst locates.
            ${PROJ_OUT_BUILDER_DIR}/${_LANGUAGE}/${VERSION}   # <outputdir>, where .html generates.
        ECHO_OUTPUT_VARIABLE
        ECHO_ERROR_VARIABLE
        RESULT_VARIABLE RES_VAR
        OUTPUT_VARIABLE OUT_VAR OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_VARIABLE  ERR_VAR ERROR_STRIP_TRAILING_WHITESPACE)
    if(RES_VAR EQUAL 0)
        if(ERR_VAR)
            # Success, but there might be some warnings.
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


    message(STATUS "Removing redundant files/directories...")
    file(REMOVE_RECURSE "${PROJ_OUT_BUILDER_DIR}/${_LANGUAGE}/${VERSION}/.doctrees/")
    file(REMOVE         "${PROJ_OUT_BUILDER_DIR}/${_LANGUAGE}/${VERSION}/.buildinfo")
    file(REMOVE         "${PROJ_OUT_BUILDER_DIR}/${_LANGUAGE}/${VERSION}/objects.inv")
    remove_cmake_message_indent()
    message("")
    message("Removing ${PROJ_OUT_BUILDER_DIR}/${_LANGUAGE}/${VERSION}/.doctrees/...")
    message("Removing ${PROJ_OUT_BUILDER_DIR}/${_LANGUAGE}/${VERSION}/.buildinfo...")
    message("Removing ${PROJ_OUT_BUILDER_DIR}/${_LANGUAGE}/${VERSION}/objects.inv...")
    message("")
    restore_cmake_message_indent()


    file(READ "${PROJ_OUT_BUILDER_DIR}/${LANGUAGE}/${VERSION}/drivers/raster/index.html" ORIGINAL_CONTENT)
    # 使用 string(REPLACE ...) 替换特定字符串
    string(REPLACE "<div class=\"toctree-wrapper compound\">" 
                  "<div class=\"toctree-wrapper compound\" style=\"display: none;\">" 
                  MODIFIED_CONTENT "${ORIGINAL_CONTENT}")
    # 将修改后的内容写入新文件
    file(WRITE "${PROJ_OUT_BUILDER_DIR}/${LANGUAGE}/${VERSION}/drivers/raster/index.html.mod" "${MODIFIED_CONTENT}")
endforeach()
unset(_LANGUAGE)


# # 重命名新文件，替换原始文件
# file(RENAME "${BUILDDIR}/html/drivers/raster/index.html.mod" "${BUILDDIR}/html/drivers/raster/index.html")


#[[
sed 's/<div class="toctree-wrapper compound">/<div class="toctree-wrapper compound" style="display: none;">/' < "$(BUILDDIR)/html/drivers/raster/index.html" > "$(BUILDDIR)/html/drivers/raster/index.html.mod"
mv "$(BUILDDIR)/html/drivers/raster/index.html.mod" "$(BUILDDIR)/html/drivers/raster/index.html"
sed 's/<div class="toctree-wrapper compound">/<div class="toctree-wrapper compound" style="display: none;">/' < "$(BUILDDIR)/html/drivers/vector/index.html" > "$(BUILDDIR)/html/drivers/vector/index.html.mod"
mv "$(BUILDDIR)/html/drivers/vector/index.html.mod" "$(BUILDDIR)/html/drivers/vector/index.html"
sed "s/python_api_ref\.html/\.\.\/python\/index\.html/" < "$(BUILDDIR)/html/api/index.html" > "$(BUILDDIR)/html/api/index.html.mod"
mv "$(BUILDDIR)/html/api/index.html.mod" "$(BUILDDIR)/html/api/index.html"
sed 's/<div class="toctree-wrapper compound">/<div class="toctree-wrapper compound" style="display: none;">/' < "$(BUILDDIR)/html/sponsors/index.html" > "$(BUILDDIR)/html/sponsors/index.html.mod"
mv "$(BUILDDIR)/html/sponsors/index.html.mod" "$(BUILDDIR)/html/sponsors/index.html"
rm -rf build/html/doxygen
cp -r build/doxygen_html build/html/doxygen
ln -sf ../latex/gdal.pdf build/html
cp -f "source/sponsors/Sustainable GDAL Sponsorship Prospectus.pdf" build/html/sponsors
#]]


message(STATUS "The HTML documentation is built succesfully!")
