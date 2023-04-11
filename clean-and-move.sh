#/bin/sh

make clean
make all
mv -f docs/* ../../<% LC_DIST %>-<% LC_MANUAL %>/
