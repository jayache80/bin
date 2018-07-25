#!/usr/bin/env bash

# Pass in the root directory for this script to crawl, as well as the symbol to
# grep for. It will grep library files with .a and .so extensions in the
# passed-in directory for the passed-in symbol.

# $1 (the first argument) is the directory containing libs to be crawled
# $2 (the second argument) is the symbol to grep for

find $1 \( -name "*.a" -or -name "*.a.*" -or -name "*.so" -or -name "*.so.*" \) -exec sh -c "echo In {}:; nm -gC {} | grep $2" \;
