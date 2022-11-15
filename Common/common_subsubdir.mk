# Variables for Makefile in a sub-sub-directory
# These directory have the structure like ~topdir/Exercices/99-dirname

topdir_from_two_above = $(shell pwd)/../../
topdir = $(topdir_from_two_above)

# Get the directory number assuming the current directory is of the form "99-dirname"
number=`python -c "import os.path as p; print(p.basename(p.realpath(p.curdir)).split('-')[0])"`

finalname = $(edition)-$(docname)-$(number)

corrigename = $(finalname)-corrige
