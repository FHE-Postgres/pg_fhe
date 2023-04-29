# Set Extension name
EXTENSION = influx
DATA = influx--0.1.sql
MODULE = influx

# Set Source and Object files
SRCS = influx.c
OBJS = $(SRCS:.c=.o)

# Set shared library name
SHLIB_LINK = -linflux

# Compile the c code
CFLAGS += -I$(shell $(PG_CONFIG) --includedir) -fPIC

# Regression Tests for the extension
REGRESS = parse worker
REGRESS_OPTS += --load-extension=influx

# Boilerplate to add PGXS support
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
