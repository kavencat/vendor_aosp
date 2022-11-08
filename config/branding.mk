# Type of Build
CUSTOM_BUILD_TYPE ?= UNOFFICIAL
# OFFICIAL_DEVICES
ifeq ($(CUSTOM_BUILD_TYPE), OFFICIAL)
  LIST = $(shell cat vendor/aosp/eternity.devices)
    ifeq ($(filter $(CUSTOM_BUILD), $(LIST)), $(CUSTOM_BUILD))
      IS_OFFICIAL=true
      CUSTOM_BUILD_TYPE := OFFICIAL
    endif
    ifneq ($(IS_OFFICIAL), true)
      CUSTOM_BUILD_TYPE := UNOFFICIAL
      $(error Device is not official "$(CUSTOM_BUILD)")
    endif
endif

# EternityOS Props
EternityOS_BASE_VERSION = v2.2-Flexible
Eternity_CODENAME := Flexible

# Time Related
CUSTOM_DATE_YEAR := $(shell date -u +%Y)
CUSTOM_DATE_MONTH := $(shell date -u +%m)
CUSTOM_DATE_DAY := $(shell date -u +%d)
CUSTOM_DATE_HOUR := $(shell date -u +%H)
CUSTOM_DATE_MINUTE := $(shell date -u +%M)
CUSTOM_BUILD_DATE_UTC := $(shell date -d '$(CUSTOM_DATE_YEAR)-$(CUSTOM_DATE_MONTH)-$(CUSTOM_DATE_DAY) $(CUSTOM_DATE_HOUR):$(CUSTOM_DATE_MINUTE) UTC' +%s)
CUSTOM_BUILD_DATE := $(CUSTOM_DATE_YEAR)$(CUSTOM_DATE_MONTH)$(CUSTOM_DATE_DAY)-$(CUSTOM_DATE_HOUR)$(CUSTOM_DATE_MINUTE)

# Platform (Android Version)
CUSTOM_PLATFORM_VERSION := 13.0

# Custom Versioning
ETERNITY_VERSION := EternityOS-$(EternityOS_BASE_VERSION)-$(CUSTOM_BUILD)-$(CUSTOM_PLATFORM_VERSION)-$(CUSTOM_BUILD_DATE)-$(CUSTOM_BUILD_TYPE)
CUSTOM_VERSION_PROP := thirteen
