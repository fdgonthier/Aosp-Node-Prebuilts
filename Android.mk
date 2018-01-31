# Download prebuilts binaries for Node.js for the hosts and then for
# the target.

LOCAL_PATH := $(call my-dir)

# TODO: Add 32 bits ARM support
# TODO: Add 32 bit x86 support

include $(LOCAL_PATH)/Makefile

include $(CLEAR_VARS)
LOCAL_PREBUILT_EXECUTABLES := host/$(EXTRACTED_HOST_DIRECTORY)/bin/node
LOCAL_MODULE_TAGS := debug
$(shell	mkdir -p $(ANDROID_HOST_OUT))
$(shell cp -raf $(LOCAL_PATH)/host/$(EXTRACTED_HOST_DIRECTORY)/* $(ANDROID_HOST_OUT))
include $(BUILD_HOST_PREBUILT)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := target/node
LOCAL_MODULE := node
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_TAGS := debug
include $(BUILD_PREBUILT)
