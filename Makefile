# =========================================================================== #
#
# UQTR Class Template  ---  version 2022-11-15
# 
# =========================================================================== #
# 
# 
# make              Collect all the pdf and organized them into
#                   the output directory.
# 
# make ouput        Same as make.
#
# make archive      Compress the output directory into an archive
#
# make clean        Remove the archive file.
#
# make veryclean    Remove the output directory.
#
#
# The pdf are collected from the following directories:
#
#     Presentations/
#     Exercices/
#     Devoirs/
#
# Please edit the following files to specify informations on the current semester:
#
#     Common/info.mk
#     Common/uqtrinfo.sty
#
# 
# =========================================================================== #
# 
# 
include Common/info.mk
include Common/top.mk
