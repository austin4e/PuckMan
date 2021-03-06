#
# Makefile
#

INC = -Iinclude

# See if ncurses.h is in an "ncurses" subdirectory
NCURSES_DIR := $(shell if [ -r /usr/include/ncurses/ncurses.h ]; then echo "yes"; fi)
ifeq ($(NCURSES_DIR),yes)
CXXFLAGS_EXTRA := -DCONS_NCURSES_IS_IN_NCURSES_INCLUDE_DIR
endif

CXXFLAGS = -g -Wall $(CXXFLAGS_EXTRA) $(INC)

# If compiling on cygwin, need extra linker flag
UNAME := $(shell uname)
ifeq ($(UNAME),Cygwin)
LDFLAGS_EXTRA = -Wl,--enable-auto-import
endif

LDFLAGS = $(LDFLAGS_EXTRA) -lncurses

SRC = Chomp.cpp Player.cpp Scene.cpp
OBJ = $(SRC:.cpp=.o)
EXE = $(SRC:.cpp=.exe)

LIBOBJ = lib/Console.o

$(EXE) : clean $(OBJ) $(LIBOBJ)
	$(CXX) -o $@ $(OBJ) $(LIBOBJ) $(LDFLAGS)

# Remove generated files.
clean : 
	rm -f *.o lib/*.o Chomp.exe collected-files.txt submit.properties solution.zip
