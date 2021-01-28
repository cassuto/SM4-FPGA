CXX ?= g++

.PHONY: all

all: SM4

SM4: SM4.o
	$(CXX) $^ -o $@

SM4.o: SM4.cc
	$(CXX) -c $< -o $@
