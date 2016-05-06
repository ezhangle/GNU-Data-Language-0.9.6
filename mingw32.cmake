# https://github.com/LuaDist/Repository/issues/77
set(_toolchain i586-mingw32msvc)  # or amd64-mingw32msvc
set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_C_COMPILER ${_toolchain}-cc)
set(CMAKE_CXX_COMPILER ${_toolchain}-g++)
set(CMAKE_RC_COMPILER ${_toolchain}-windres )
set(CMAKE_RC_OUTPUT_EXTENSION .obj)
# from Windows-windres.cmake & CYGWIN-windres.cmake
set(CMAKE_RC_COMPILE_OBJECT
  "<CMAKE_RC_COMPILER> -O coff <FLAGS> <DEFINES> <SOURCE> <OBJECT>")
set(CMAKE_FIND_ROOT_PATH /usr/${_toolchain}/ ${CMAKE_INSTALL_PREFIX})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
