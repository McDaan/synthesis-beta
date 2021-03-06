DEP := $(shell command -v dep 2> /dev/null)

ldflags = -X github.com/McDaan/synthesis-beta/version.Version=$(VERSION) \
	-X github.com/McDaan/synthesis-beta/version.Commit=$(COMMIT)

get_tools:
ifndef DEP
	@echo "Installing dep"
	go get -u -v github.com/golang/dep/cmd/dep
else
	@echo "Dep is already installed..."
endif

get_vendor_deps:
	@echo "--> Generating vendor directory via dep ensure"
	@rm -rf .vendor-new
	@dep ensure -v -vendor-only

update_vendor_deps:
	@echo "--> Running dep ensure"
	@rm -rf .vendor-new
	@dep ensure -v -update

install:
	go install ./cmd/synd
	go install ./cmd/syncli