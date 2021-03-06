# ogr_fdw/Makefile

MODULE_big = ogr_fdw
OBJS = ogr_fdw.o
EXTENSION = ogr_fdw
DATA = ogr_fdw--1.0.sql

REGRESS = ogr_fdw

EXTRA_CLEAN = sql/ogr_fdw.sql expected/ogr_fdw.out

GDAL_CONFIG = gdal-config
GDAL_CFLAGS = $(shell $(GDAL_CONFIG) --cflags)
GDAL_LIBS = $(shell $(GDAL_CONFIG) --libs)

PG_CONFIG = pg_config

CFLAGS += $(GDAL_CFLAGS)
LIBS += $(GDAL_LIBS)
SHLIB_LINK := $(LIBS)

PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)


###############################################################
# Build the utility program after PGXS to override the
# PGXS environment

CFLAGS = $(GDAL_CFLAGS)
LIBS = $(GDAL_LIBS)

ogr_fdw_info: ogr_fdw_info.o
	$(CC) $(CFLAGS) -o $@ $? $(LIBS)

clean:
	rm -f *.o ogr_fdw_info *.so

all: ogr_fdw_info

