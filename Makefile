include Common/info.mk
output = $(code)-$(year)

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
	mkdir -p $(output)
	mkdir -p $(output)/Plan-de-cours
	mkdir -p $(output)/Presentations
	mkdir -p $(output)/Exercices
	mkdir -p $(output)/Devoirs

output: sub outputdirs
	cp -f Plan-de-cours/pdf/* $(output)/Plan-de-cours/ 2>/dev/null || :
	cp -f Presentations/All/* $(output)/Presentations/ 2>/dev/null || :
	cp -f Exercices/All/* $(output)/Exercices/ 2>/dev/null || :
	cp -f Devoirs/All/* $(output)/Devoirs/ 2>/dev/null || :

archive: output
	tar -cjf $(output).tar.gz $(output)
