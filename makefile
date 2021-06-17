SHELL            = /bin/bash

GIT_BRANCH       = $(shell git rev-parse --abbrev-ref HEAD)
GIT_HASH         = $(shell git rev-parse HEAD)

AUTHOR           = AshHat
PROJECT          = Wristimate
PACKAGE          = $(AUTHOR)-$(PROJECT).zip
CONTENTS         = icon.png manifest.json $(PROJECT).dll

CONFIG           = Release
FRAMEWORK        = net35
BUILD_PROPERTIES = /p:RepositoryBranch="$(GIT_BRANCH)" /p:RepositoryCommit="$(GIT_HASH)"

.PHONY: all build clean

all: clean $(PACKAGE)

build:
	dotnet build --configuration $(CONFIG) --framework $(FRAMEWORK) $(BUILD_PROPERTIES)

$(PACKAGE): build
	cp README.MD $(PROJECT)/bin/$(CONFIG)/$(FRAMEWORK)/
	zip -9j $@ $(addprefix $(PROJECT)/bin/$(CONFIG)/$(FRAMEWORK)/,$(CONTENTS))

clean:
	rm -f $(PACKAGE)
