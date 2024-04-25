# Distributed under the OSI-approved BSD 3-Clause License.
# See accompanying file LICENSE.txt for details.

#[=======================================================================[.rst:
FindDoxygen
-----------

Try to find Doxygen documentation generator's command-line tools.

This is a component-based find module, which makes use of the COMPONENTS and OPTIONAL_COMPONENTS arguments to find_module. The following components are available::

  Build Quickstart Apidoc Autogen 

If no components are specified, this module will act as though all components were passed to ``OPTIONAL_COMPONENTS``.

Imported Targets
^^^^^^^^^^^^^^^^

This module defines the following Imported Targets (only created when CMAKE_ROLE is ``PROJECT``):

``Doxygen::Doxygen``
  The ``doxygen`` executable.

``Doxygen::Dot``
  The ``dot`` executable.

``Doxygen::Mscgen``
  The ``mscgen`` executable.

``Doxygen::Dia``
  The ``dia`` executable.

Result Variables
^^^^^^^^^^^^^^^^

This module will set the following variables in your project:

``Doxygen_FOUND``
  System has the Doxygen. ``TRUE`` if Doxygen has been found.

``Doxygen_EXECUTABLE``
  The full path to the ``doxygen`` executable.

``Doxygen_Dot_FOUND``
  System has the Dot. ``TRUE`` if Dot has been found.

``Doxygen_DOT_EXECUTABLE``
  The full path to the ``dot`` executable.

``Doxygen_Mscgen_FOUND``
  System has the Dot. ``TRUE`` if Mscgen has been found.

``Doxygen_MSCGEN_EXECUTABLE``
  The full path to the ``mscgen`` executable.

``Doxygen_Dia_FOUND``
  System has the Dia. ``TRUE`` if Dia has been found.

``Doxygen_DIA_EXECUTABLE``
  The full path to the ``dia`` executable.

``Doxygen_VERSION``
  The version of Doxygen found (outputs of ``doxygen --version``).

``Doxygen_VERSION_MAJOR``
  The major version of Doxygen found.

``Doxygen_VERSION_MINOR``
  The minor version of Doxygen found.

``Doxygen_VERSION_PATCH``
  The patch version of Doxygen found.

Hints
^^^^^

``Doxygen_ROOT_DIR``, ``ENV{Doxygen_ROOT_DIR}``
  Define the root directory of a Doxygen installation.

``ENV{VIRTUAL_ENV}``

#]=======================================================================]

set(_Doxygen_KNOWN_COMPONENTS
    Mscgen
    Dot
    Dia)

if(NOT Doxygen_FIND_COMPONENTS)
    set(Doxygen_FIND_COMPONENTS)
    foreach(_COMP ${Doxygen_FIND_COMPONENTS})
        set(Doxygen_FIND_REQUIRED_${_COMP} TRUE)
    endforeach()
    unset(_COMP)
endif()

set(_Doxygen_SEARCH_HINTS 
    ${Doxygen_ROOT_DIR} 
    ENV Doxygen_ROOT_DIR)

set(_Doxygen_SEARCH_PATHS)


find_program(Doxygen_EXECUTABLE
    NAMES doxygen
    PATH_SUFFIXES ${_Doxygen_PATH_SUFFIXES}
    HINTS ${_Doxygen_SEARCH_HINTS}
    PATHS ${_Doxygen_SEARCH_PATHS}
    DOC "The full path to the doxygen executable.")


foreach(_COMP ${_Doxygen_KNOWN_COMPONENTS})
    string(TOLOWER ${_COMP} _COMP_LOWER)
    string(TOUPPER ${_COMP} _COMP_UPPER)
    find_program(Doxygen_${_COMP_UPPER}_EXECUTABLE
        NAMES ${_COMP_LOWER}
        NAMES_PER_DIR
        PATH_SUFFIXES ${_Doxygen_PATH_SUFFIXES}
        HINTS ${_Doxygen_SEARCH_HINTS}
        PATHS ${_Doxygen_SEARCH_PATHS}
        DOC "The full path to the ${_COMP_LOWER} executable.")
    if(Doxygen_${_COMP_UPPER}_EXECUTABLE)
        set(Doxygen_${_COMP}_FOUND TRUE)
    endif()
endforeach()
unset(_COMP)

if(Doxygen_EXECUTABLE)
    execute_process(
        COMMAND "${Doxygen_EXECUTABLE}" --version
        OUTPUT_VARIABLE _Doxygen_VERSION_OUTPUT
        OUTPUT_STRIP_TRAILING_WHITESPACE)

    string(REGEX MATCH "([0-9]+\\.[0-9]+\\.[0-9]+)" 
        Doxygen_VERSION ${_Doxygen_VERSION_OUTPUT})

    string(REGEX MATCH "([0-9]+)\\.([0-9]+)\\.([0-9]+)" _ ${Doxygen_VERSION})
    set(Doxygen_VERSION_MAJOR "${CMAKE_MATCH_1}")
    set(Doxygen_VERSION_MINOR "${CMAKE_MATCH_2}")
    set(Doxygen_VERSION_PATCH "${CMAKE_MATCH_3}")
endif()

# Handle REQUIRED and QUIET arguments
# this will also set Doxygen_FOUND to true if Doxygen_EXECUTABLE exists
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Doxygen
    REQUIRED_VARS
        Doxygen_EXECUTABLE
    VERSION_VAR
        Doxygen_VERSION
    FOUND_VAR
        Doxygen_FOUND
    REASON_FAILURE_MESSAGE
        "Failed to locate doxygen executable."
    HANDLE_COMPONENTS)

if(Doxygen_FOUND)
    get_property(_Doxygen_CMAKE_ROLE GLOBAL PROPERTY CMAKE_ROLE)
    if(_Doxygen_CMAKE_ROLE STREQUAL "PROJECT")
        #
        # add_executable is not scriptable
        #
        foreach(_COMP ${Doxygen_FIND_COMPONENTS})
            string(TOUPPER ${_COMP} _COMP_UPPER)
            if (NOT TARGET Doxygen::${_COMP}
                AND Doxygen_${_COMP}_FOUND)
                add_executable(Doxygen::${_COMP} IMPORTED)
                set_target_properties(Doxygen::${_COMP} PROPERTIES
                    IMPORTED_LOCATION 
                        "${Doxygen_${_COMP_UPPER}_EXECUTABLE}")
            endif()
        endforeach()
    endif()
    unset(_Doxygen_CMAKE_ROLE)
endif()

unset(_Doxygen_SEARCH_HINTS)
unset(_Doxygen_SEARCH_PATHS)
