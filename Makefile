# =========================================================================== #
#
# UQTR Class Template  ---  version 2022-11-15
# 
# =========================================================================== #
# 
# 
#     make                  Collect all the pdf and organized them into
#                           the output directory.
#     
#     make ouput            Same as make.
#
#     make archive          Compress the output directory into an archive.
#
#     make recursive        Descend into each subdirectory, build everything,
#                           and gather the pdf.
#
#     make clean            Remove the archive file and clean recursively.
#
#     make veryclean        Clean, and remove the output directory as well.
#
#
# The pdf are collected from the following subdirectories:
#
#     Presentations/
#     Exercices/
#     Devoirs/
#
#
# Please specify informations on the current semester in the following files:
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
