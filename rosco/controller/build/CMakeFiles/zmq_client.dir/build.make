# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/hpsauce/ROSCO/rosco/controller

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/hpsauce/ROSCO/rosco/controller/build

# Include any dependencies generated for this target.
include CMakeFiles/zmq_client.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/zmq_client.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/zmq_client.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/zmq_client.dir/flags.make

CMakeFiles/zmq_client.dir/src/zmq_client.c.o: CMakeFiles/zmq_client.dir/flags.make
CMakeFiles/zmq_client.dir/src/zmq_client.c.o: ../src/zmq_client.c
CMakeFiles/zmq_client.dir/src/zmq_client.c.o: CMakeFiles/zmq_client.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/hpsauce/ROSCO/rosco/controller/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/zmq_client.dir/src/zmq_client.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/zmq_client.dir/src/zmq_client.c.o -MF CMakeFiles/zmq_client.dir/src/zmq_client.c.o.d -o CMakeFiles/zmq_client.dir/src/zmq_client.c.o -c /home/hpsauce/ROSCO/rosco/controller/src/zmq_client.c

CMakeFiles/zmq_client.dir/src/zmq_client.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/zmq_client.dir/src/zmq_client.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/hpsauce/ROSCO/rosco/controller/src/zmq_client.c > CMakeFiles/zmq_client.dir/src/zmq_client.c.i

CMakeFiles/zmq_client.dir/src/zmq_client.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/zmq_client.dir/src/zmq_client.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/hpsauce/ROSCO/rosco/controller/src/zmq_client.c -o CMakeFiles/zmq_client.dir/src/zmq_client.c.s

zmq_client: CMakeFiles/zmq_client.dir/src/zmq_client.c.o
zmq_client: CMakeFiles/zmq_client.dir/build.make
.PHONY : zmq_client

# Rule to build all files generated by this target.
CMakeFiles/zmq_client.dir/build: zmq_client
.PHONY : CMakeFiles/zmq_client.dir/build

CMakeFiles/zmq_client.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/zmq_client.dir/cmake_clean.cmake
.PHONY : CMakeFiles/zmq_client.dir/clean

CMakeFiles/zmq_client.dir/depend:
	cd /home/hpsauce/ROSCO/rosco/controller/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/hpsauce/ROSCO/rosco/controller /home/hpsauce/ROSCO/rosco/controller /home/hpsauce/ROSCO/rosco/controller/build /home/hpsauce/ROSCO/rosco/controller/build /home/hpsauce/ROSCO/rosco/controller/build/CMakeFiles/zmq_client.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/zmq_client.dir/depend

