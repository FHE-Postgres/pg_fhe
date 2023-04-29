# Set Extension name
EXTENSION = influx
DATA = influx--0.1.sql
MODULE = influx

# Regression Tests for the extension
REGRESS = parse worker
REGRESS_OPTS += --load-extension=influx

# Boilerplate to add PGXS support
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
