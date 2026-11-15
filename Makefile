CXX ?= g++
MARCH ?= native
OPT ?= -O3

PKG_CONFIG = PKG_CONFIG_PATH=$(CURDIR)/external/install/lib/pkgconfig:$(PKG_CONFIG_PATH) pkg-config

CXXFLAGS = $(OPT) -g -std=gnu++17 -march=$(MARCH) -Iinclude $(shell $(PKG_CONFIG) --cflags givaro)
LDLIBS = $(shell $(PKG_CONFIG) --libs givaro) -Wl,-rpath,$(shell $(PKG_CONFIG) --variable=libdir givaro)
ifeq ($(SIMD),none)
  CXXFLAGS += -DBUTTERFLY_SIMD_NONE
endif

HEADERS = $(wildcard include/butterfly/*.h include/butterfly/simd/*)


BUILD_FLAGS = $(CXX) $(CXXFLAGS)

all: build/check build/bench build/profile

build/flags: FORCE
	@mkdir -p build
	@[ "$$(cat $@ 2>/dev/null)" = '$(BUILD_FLAGS)' ] || printf '%s\n' '$(BUILD_FLAGS)' >$@

build/%: tests/%.cpp $(HEADERS) build/flags
	@mkdir -p build
	$(CXX) $(CXXFLAGS) $< -o $@ $(LDLIBS)

build/%: bench/%.cpp $(HEADERS) build/flags
	@mkdir -p build
	$(CXX) $(CXXFLAGS) $< -o $@ $(LDLIBS)

clean:
	rm -rf build

FORCE:

.PHONY: all clean FORCE
