if(LIBWEBRTC_COMMAND_INCLUDED)
  return()
endif(LIBWEBRTC_COMMAND_INCLUDED)
set(LIBWEBRTC_COMMAND_INCLUDED true)

include(CMakeParseArguments)
include(Environment)

function(libwebrtc_command)
  set(ONE_VALUE_ARGS NAME COMMENT WORKING_DIRECTORY)
  set(MULTI_VALUE_ARGS COMMAND DEPENDS)
  cmake_parse_arguments(COMMAND "" "${ONE_VALUE_ARGS}" "${MULTI_VALUE_ARGS}" ${ARGN} )

  set(CMF_DIR ${CMAKE_BINARY_DIR}/CMakeFiles)
  set(STAMP_FILE "${CMF_DIR}/${COMMAND_NAME}-complete")

  add_custom_command(
      OUTPUT ${STAMP_FILE}
      COMMENT ${COMMAND_COMMENT}
      COMMAND ${PREFIX_EXECUTE} ${COMMAND_COMMAND}
      COMMAND ${CMAKE_COMMAND} -E touch ${STAMP_FILE}
      WORKING_DIRECTORY ${COMMAND_WORKING_DIRECTORY}
  )

  add_custom_target(${COMMAND_NAME} ALL DEPENDS ${STAMP_FILE})

  if (COMMAND_DEPENDS)
    add_dependencies(${COMMAND_NAME} ${COMMAND_DEPENDS})
  endif (COMMAND_DEPENDS)
endfunction()
