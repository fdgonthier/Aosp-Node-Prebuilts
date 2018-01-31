# Download prebuilts binaries for Node.js for the hosts and then for
# the target.

NODE_HOST_BINARY_URL=https://nodejs.org/dist/v8.9.4/
NODE_HOST_BINARY_PACKAGE=node-v8.9.4-linux-x64.tar.xz

NODE_TARGET_BINARY_URL=https://github.com/fdgonthier/nodejs-mobile/releases/download/v8.6.0-pre/
NODE_TARGET_BINARY_PACKAGE_arm64=node_arm64.tar.gz
NODE_TARGET_BINARY_PACKAGE_x86_64=node_amd64.tar.gz
NODE_TARGET_BINARY_PACKAGE=node.tar.gz

# TODO: Add 32 bits ARM support
# TODO: Add 32 bit x86 support

EXTRACTED_HOST_DIRECTORY=$(shell basename $(NODE_HOST_BINARY_PACKAGE) .tar.xz)

all:
	echo "Make one of those targets: arm64, x86_64"

clean:
	-rm -v target/*
	-rm -v host/*

host/$(NODE_HOST_BINARY_PACKAGE):
	mkdir -p host
	curl --location --silent "$(NODE_HOST_BINARY_URL)/$(NODE_HOST_BINARY_PACKAGE)" \
	     > host/$(NODE_HOST_BINARY_PACKAGE)

host/node: ./host/$(NODE_HOST_BINARY_PACKAGE)
	tar -C host -xJf host/$(NODE_HOST_BINARY_PACKAGE)

target/$(NODE_TARGET_BINARY_PACKAGE_x86_64) target/$(NODE_TARGET_BINARY_PACKAGE_arm64): 
	mkdir -p target
	curl --location --silent $(NODE_TARGET_BINARY_URL)/$(notdir $@) \
	     > target/$(NODE_TARGET_BINARY_PACKAGE)

target/node: ./target/$(NODE_TARGET_BINARY_PACKAGE)
	tar -C target -xzf target/$(NODE_TARGET_BINARY_PACKAGE) node

host: ./host/$(NODE_HOST_BINARY_PACKAGE) \
     ./host/node \

arm64: host \
	./target/$(NODE_TARGET_BINARY_PACKAGE_arm64) \
        ./target/node

x86_64: host \
	./target/$(NODE_TARGET_BINARY_PACKAGE_x86_64) \
        ./target/node

.PHONY: x86_64 arm64 clean
