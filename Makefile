TITLE:=Breakdown
BINDIR:=bin/
OBJDIR:=obj/
DOCDIR:=doc/
DOXYFILE:=Doxyfile
LOG=log

CC:=g++
CXXFLAGS:=-W -Wall -Wextra -std=c++11 -g
LDFLAGS:=-lsfml-window -lsfml-graphics -lsfml-system

SRC:=Bullet.cpp Constant.cpp Heroin.cpp MathVector.cpp Object.cpp SpellCard.cpp FunctionLine.cpp
HDR:=$(SRC:.cpp=.h) Pattern.h  Bezier.tpp ObjectManager.tpp SpellCard.tpp
SRC+=main.cpp

OBJ:=$(addprefix $(OBJDIR),$(SRC:.cpp=.o))
EXEC:=$(addprefix $(BINDIR),$(TITLE))

all: exec doc

exec: $(EXEC)

doc: $(SRC) $(HDR) $(DOXYFILE)
	doxygen $(DOXYFILE)

$(EXEC): $(OBJ) $(HDR)
	$(CC) -o $@ $(OBJ) $(LDFLAGS)

$(addprefix $(OBJDIR),%.o): %.cpp
	$(CC) -o $@ -c $< $(CXXFLAGS)

.PHONY: clean mrproper rebuild

clean:
	rm -rf $(OBJDIR)*
	rm -rf $(DOCDIR)*

mrproper: clean
	rm -rf $(BINDIR)*
	rm -rf .*.sw*

rebuild: clean all
