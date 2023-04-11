#/bin/sh

rm -rf ../../<% LC_DIST %>-<% LC_MANUAL %>/assets/
rm -rf ../../<% LC_DIST %>-<% LC_MANUAL %>/<% LC_MANUAL %>/

make clean
make all
mv -f docs/* ../../<% LC_DIST %>-<% LC_MANUAL %>/
