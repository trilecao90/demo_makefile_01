CC := g++
CCFLAGS :=

SUBDIRS_LEVEL_1 := $(wildcard */)
SUBDIRS_LEVEL_2_HEADERS := $(foreach dir, $(SUBDIRS_LEVEL_1), $(wildcard $(dir)*inc/))

CCFLAGS += $(addprefix -I , $(SUBDIRS_LEVEL_2_HEADERS))

OBJECTS_DYNAMIC := ./LibDynamic/src/LibDynamic_01.o ./LibDynamic/src/LibDynamic_02.o ./LibDynamic/src/example.o
LIBRARY_DYNAMIC := ./LibDynamic/src/LibDynamic.so

OBJECTS_STATIC := ./LibStatic/src/LibStatic_01.o ./LibStatic/src/LibStatic_02.o
LIBRARY_STATIC := ./LibStatic/src/LibStatic.a

OBJECTS_MAIN := ./Main/src/test.o ./Main/src/Main.o 

OUTPUT_FINAL := ./final.out

.PHONY : all clean distclean

all : $(OUTPUT_FINAL)

$(OUTPUT_FINAL) : $(OBJECTS_MAIN) $(LIBRARY_DYNAMIC) $(LIBRARY_STATIC)
	$(CC) $(CCFLAGS) $^ -o $@

$(LIBRARY_DYNAMIC) : $(OBJECTS_DYNAMIC)
	$(CC) $(CCFLAGS) -fPIC $^ -shared -o $@

$(LIBRARY_STATIC) : $(OBJECTS_STATIC)
	ar rcs $@ $^

%.o : %.cpp
	$(CC) $(CCFLAGS) -c $< -o $@

clean distclean :
	rm -rf $(OBJECTS_MAIN)
	rm -rf $(OBJECTS_DYNAMIC)
	rm -rf $(OBJECTS_STATIC)
	rm -rf $(LIBRARY_DYNAMIC)
	rm -rf $(LIBRARY_STATIC)
	rm -rf $(OUTPUT_FINAL)
