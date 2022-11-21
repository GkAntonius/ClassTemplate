
edition = $(code)-$(year)

all: dirs output

sub:
	cd Presentations && make
	cd Exercices && make
	cd Devoirs && make

dirs: 
	mkdir -p Plan-de-cours
	mkdir -p Presentations
	mkdir -p Exercices
	mkdir -p Devoirs
	mkdir -p Etudiants

outputdirs:
	mkdir -p $(edition)
	mkdir -p $(edition)/Plan-de-cours
	mkdir -p $(edition)/Presentations
	mkdir -p $(edition)/Exercices
	mkdir -p $(edition)/Devoirs

output: sub outputdirs
	cp -f Plan-de-cours/pdf/* $(edition)/Plan-de-cours/ 2>/dev/null || :
	cp -f Presentations/All/* $(edition)/Presentations/ 2>/dev/null || :
	cp -f Exercices/All/* $(edition)/Exercices/ 2>/dev/null || :
	cp -f Devoirs/All/* $(edition)/Devoirs/ 2>/dev/null || :

archive: output
	tar -cjf $(edition).tar.gz $(edition)

clean:
	rm -f $(edition).tar.gz

veryclean:
	rm -rf $(edition)
