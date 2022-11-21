# Variables for Makefile in a sub-directory, e.g.
# ~topdir/Plan-de-Cours

topdir_from_above = $(shell pwd)/../
topdir = $(topdir_from_above)

finalname = $(edition)-$(doclabel)
