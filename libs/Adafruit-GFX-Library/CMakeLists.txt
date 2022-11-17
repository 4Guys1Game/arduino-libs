# Just a recent number
cmake_minimum_required(VERSION 3.18)

# Use AVR GCC toolchain definition in your HOME/Arduino directory
if(${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Linux")
    set(ARDUINO_PATH $ENV{HOME}/Arduino)
elseif(${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Windows")
    cmake_path(CONVERT "$ENV{HOMEDRIVE}$ENV{HOMEPATH}/Arduino" TO_CMAKE_PATH_LIST ARDUINO_PATH NORMALIZE)
endif()
set(CMAKE_TOOLCHAIN_FILE ${ARDUINO_PATH}/etc/toolchain-avr.cmake)

# we need the assembler this time
enable_language(ASM)

# Project name
project("GFX")

# Where to install
set(CMAKE_INSTALL_PREFIX ${ARDUINO_PATH})

# defines: use Arduino.h i.s.o. WProgram.h
add_compile_definitions(ARDUINO=101)

# Target: the Arduino core library with all core source files to compile
# To get a list of .c and cpp files in Linux:
#       cd <project directory>
#       find src -name \*.[cSs]\*
add_library(${PROJECT_NAME} STATIC
	Adafruit_GrayOLED.cpp
	Adafruit_SPITFT.cpp
	fontconvert/fontconvert.c
	Adafruit_GFX.cpp
	glcdfont.c
)

# Here the compiler finds include files (-I flags)
target_include_directories(${PROJECT_NAME} PRIVATE
	${CMAKE_CURRENT_SOURCE_DIR}
	${ARDUINO_PATH}/include/arduino
)

# All .h files of Arduino core
# To get a list of .h files (in Linux):
#       cd <project directory>
#       find src -name \*.h
set(INCLUDES
	Adafruit_SPITFT.h
	Adafruit_GrayOLED.h
	gfxfont.h
	Adafruit_GFX.h
	Adafruit_SPITFT_Macros.h
)
set(INCLUDES_FONTS
	Fonts/FreeMono12pt7b.h
	Fonts/FreeSerifBold18pt7b.h
	Fonts/FreeSansBoldOblique12pt7b.h
	Fonts/FreeSerifBoldItalic9pt7b.h
	Fonts/FreeSerifItalic24pt7b.h
	Fonts/FreeMono9pt7b.h
	Fonts/FreeSansBoldOblique18pt7b.h
	Fonts/FreeSansOblique18pt7b.h
	Fonts/FreeSansOblique12pt7b.h
	Fonts/FreeSansBold12pt7b.h
	Fonts/FreeSans9pt7b.h
	Fonts/FreeSerifItalic18pt7b.h
	Fonts/FreeMonoBold9pt7b.h
	Fonts/FreeSerifItalic12pt7b.h
	Fonts/FreeMonoBold18pt7b.h
	Fonts/FreeMonoBoldOblique9pt7b.h
	Fonts/FreeSerif12pt7b.h
	Fonts/FreeMonoBoldOblique18pt7b.h
	Fonts/FreeSerifItalic9pt7b.h
	Fonts/Tiny3x3a2pt7b.h
	Fonts/FreeMonoBold12pt7b.h
	Fonts/FreeSerif24pt7b.h
	Fonts/FreeSansBold9pt7b.h
	Fonts/FreeMonoOblique18pt7b.h
	Fonts/FreeSansBold18pt7b.h
	Fonts/FreeMonoOblique12pt7b.h
	Fonts/FreeSerif18pt7b.h
	Fonts/FreeSans24pt7b.h
	Fonts/FreeMono18pt7b.h
	Fonts/FreeSans12pt7b.h
	Fonts/FreeSerifBoldItalic12pt7b.h
	Fonts/FreeMonoOblique9pt7b.h
	Fonts/FreeMonoBold24pt7b.h
	Fonts/FreeMono24pt7b.h
	Fonts/FreeSansOblique9pt7b.h
	Fonts/FreeSerif9pt7b.h
	Fonts/Org_01.h
	Fonts/FreeSansBoldOblique24pt7b.h
	Fonts/FreeMonoBoldOblique12pt7b.h
	Fonts/FreeSansBold24pt7b.h
	Fonts/FreeMonoOblique24pt7b.h
	Fonts/FreeSerifBold12pt7b.h
	Fonts/FreeSerifBold24pt7b.h
	Fonts/FreeSerifBoldItalic24pt7b.h
	Fonts/FreeMonoBoldOblique24pt7b.h
	Fonts/FreeSans18pt7b.h
	Fonts/FreeSansBoldOblique9pt7b.h
	Fonts/TomThumb.h
	Fonts/Picopixel.h
	Fonts/FreeSerifBold9pt7b.h
	Fonts/FreeSansOblique24pt7b.h
	Fonts/FreeSerifBoldItalic18pt7b.h
)

# Install the library here (INSTALL_PREFIX_PATH is prepended)
install(TARGETS ${PROJECT_NAME} ARCHIVE DESTINATION lib)
install(FILES ${INCLUDES} DESTINATION include/arduino)
install(FILES ${INCLUDES_FONTS} DESTINATION include/arduino/Fonts)
