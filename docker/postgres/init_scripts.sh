#!/bin/sh

# You could probably do this fancier and have an array of extensions
# to create, but this is mostly an illustration of what can be done

createdb -U admin djangoprod
psql -U admin -d template1 -c 'create extension hstore;'
