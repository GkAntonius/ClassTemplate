
edition = $(code)-$(year)

# The list of directoris containing a Makefile
# and subdirectory All from which the pdf are copied.
# You can expand this list with e.g. Exams Lab
#
directories_subsub = Presentations Exercices Devoirs


# The list of directoris containing a Makefile and subdirectory pdf
# from which the pdf are copied.
#
directories_sub = Plan-de-cours


# Other directories we want to create
#
directories_extra = Etudiants


# =========================================================================== #


all: dirs output

sub:
	for d in $(directories_subsub); do \
		echo $$d; cd $$d && make; cd ..; \
	done ; \

recursive: subrecursive output

subrecursive:
	for d in $(directories_subsub); do \
		echo $$d; cd $$d && make recursive; cd ..; \
	done ; \
	for d in $(directories_sub); do \
		echo $$d; cd $$d && make recursive; cd ..; \
	done ; \

dirs: 
	for d in $(directories_subsub); do \
		mkdir -p $$d; \
	done ; \
	for d in $(directories_sub); do \
		mkdir -p $$d; \
	done ; \
	for d in $(directories_extra); do \
		mkdir -p $$d; \
	done ; \

outputdirs:
	mkdir -p $(edition)
	for d in $(directories_subsub); do \
		mkdir -p $(edition)/$$d; \
	done ; \
	for d in $(directories_sub); do \
		mkdir -p $(edition)/$$d; \
	done ; \

output: sub outputdirs
	for d in $(directories_subsub); do \
		cp -f $$d/All/* $(edition)/$$d/ 2>/dev/null || : ; \
	done ; \
	for d in $(directories_sub); do \
		cp -f $$d/pdf/* $(edition)/$$d/ 2>/dev/null || : ; \
	done ; \

archive: output
	tar -cjf $(edition).tar.gz $(edition)

clean: output subveryclean
	rm -f $(edition).tar.gz

veryclean: clean
	rm -rf $(edition)

subclean:
	for d in $(directories_subsub); do \
		echo $$d; cd $$d && make clean; cd ..; \
	done ; \
	for d in $(directories_sub); do \
		echo $$d; cd $$d && make clean; cd ..; \
	done ; \

subveryclean:
	for d in $(directories_subsub); do \
		echo $$d; cd $$d && make veryclean; cd ..; \
	done ; \
	for d in $(directories_sub); do \
		echo $$d; cd $$d && make veryclean; cd ..; \
	done ; \
