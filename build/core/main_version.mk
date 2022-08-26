# Build fingerprint
ifeq ($(BUILD_FINGERPRINT),)
BUILD_NUMBER_CUSTOM := $(shell date -u +%H%M)
CUSTOM_DEVICE ?= $(TARGET_DEVICE)
ifneq ($(filter OFFICIAL,$(CUSTOM_BUILD_TYPE)),)
BUILD_SIGNATURE_KEYS := release-keys
else
BUILD_SIGNATURE_KEYS := test-keys
endif
BUILD_FINGERPRINT := $(PRODUCT_BRAND)/$(CUSTOM_DEVICE)/$(CUSTOM_DEVICE):$(PLATFORM_VERSION)/$(BUILD_ID)/$(BUILD_NUMBER_CUSTOM):$(TARGET_BUILD_VARIANT)/$(BUILD_SIGNATURE_KEYS)
endif
ADDITIONAL_SYSTEM_PROPERTIES  += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)

# AOSP recovery flashing
ifeq ($(TARGET_USES_AOSP_RECOVERY),true)
ADDITIONAL_SYSTEM_PROPERTIES  += \
    persist.sys.recovery_update=true
endif

# Custom security patch
CUSTOM_SECURITY_PATCH := 2022-08-05

# Versioning props
ADDITIONAL_SYSTEM_PROPERTIES  += \
    org.eternityos.version=$(EternityOS_BASE_VERSION) \
    org.eternityos.version.display=$(CUSTOM_VERSION) \
    org.eternityos.build_date=$(CUSTOM_BUILD_DATE) \
    org.eternityos.build_date_utc=$(CUSTOM_BUILD_DATE_UTC) \
    org.eternityos.build_type=$(CUSTOM_BUILD_TYPE) \
    org.eternityos.codename=$(EternityOS_BASE_VERSION) \
    ro.eternityos.maintainer=$(ETERNITY_MAINTAINER) \
    org.eternityos.build_security_patch=$(CUSTOM_SECURITY_PATCH)
