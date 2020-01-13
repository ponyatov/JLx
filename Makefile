CWD    = $(CURDIR)
MODULE = $(notdir $(CWD))

TMP ?= $(HOME)/tmp

NOW = $(shell date +%d%m%y)
REL = $(shell git rev-parse --short=4 HEAD)



.PHONY: all
all: java

.PHONY: java
java:
	./gradlew run --args='src/main/antlr/JL.test' --warning-mode all


.PHONY: nim
nim:
	$(MAKE) -C nimJS



WGET = wget -c -O

.PHONY: install
install:
	sudo apt install -u default-jdk
	$(MAKE) gradle

GRADLE_VER = 6.0.1
GRADLE_GZ  = gradle-$(GRADLE_VER)-bin.zip
GRADLE     = $(HOME)/Java/gradle-$(GRADLE_VER)/bin/gradle
gradle: $(GRADLE)

$(GRADLE): $(TMP)/$(GRADLE_GZ)
	cd $(HOME)/Java ; unzip $< && touch $@
# .PHONY: $(TMP)/$(GRADLE_GZ)
$(TMP)/$(GRADLE_GZ):
	$(WGET) $@ https://services.gradle.org/distributions/$(GRADLE_GZ)



.PHONY: doc
doc: doc/Tiger_Java.pdf
doc/Tiger_Java.pdf:
	$(WGET) $@ https://eden.dei.uc.pt/~amilcar/pdf/CompilerInJava.pdf


.PHONY: doxy
doxy:
	doxygen doxy.gen 1>/dev/null


.PHONY: merge release

MERGE  = Makefile README.md .gitignore doxy.gen
# MERGE += droid

merge:
	git checkout master
	git checkout shadow -- $(MERGE)

release:
	git tag $(NOW)-$(REL)
	git push -v && git push -v --tags
	git checkout shadow
