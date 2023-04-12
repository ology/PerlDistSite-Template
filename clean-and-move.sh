#/bin/sh

# here we assume that the distribution is ../ (the parent directory)
# and the manual site is ../../ (two directories up)

rm -rf ../../<% LC_DIST %>-<% LC_MANUAL %>/assets/
rm -rf ../../<% LC_DIST %>-<% LC_MANUAL %>/<% LC_MANUAL %>/

make clean
make all
mv -f docs/* ../../<% LC_DIST %>-<% LC_MANUAL %>/
