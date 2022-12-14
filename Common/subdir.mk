
subdirs=`python -c "from glob import glob; print(' '.join(glob('[0-9]-*')+glob('[0-9][0-9]-*')))"`
subdirs_excluding_template=`python -c "from glob import glob; print(' '.join(glob('[1-9]-*')+glob('0[1-9]-*')+glob('1?-*')))"`

all: final newdir

dirs:
	mkdir -p All

final: dirs always
	cp -f [1-9]-*/pdf/* All/ 2>/dev/null || :
	cp -f 0[1-9]-*/pdf/* All/ 2>/dev/null || :
	cp -f 1?-*/pdf/* All/ 2>/dev/null || :

always:
	@True

recursive:
	for d in $(subdirs); do \
		echo $$d; cd $$d && make recursive; cd ..; \
	done ; \

clean: final subveryclean

veryclean: clean
	rm -f All/*

subclean:
	for d in $(subdirs); do \
		echo $$d; cd $$d && make recursiveclean; cd ..; \
	done ; \

subveryclean:
	for d in $(subdirs); do \
		echo $$d; cd $$d && make veryclean; cd ..; \
	done ; \

newdir:
	@if [ -n "$(new)" ]; then \
		if [ ! -d "$(new)" ]; then \
			echo "mkdir -p $(new) && rsync -avhF 00-Template/ $(new)"; \
			mkdir -p $(new) && rsync -avhF 00-Template/ $(new); \
		fi ; \
	fi ; \

help:
	cat Makefile
