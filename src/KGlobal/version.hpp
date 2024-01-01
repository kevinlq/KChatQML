#pragma once

// for cmake
#define KCHAT_VER_MAJOR 0
#define KCHAT_VER_MINOR 1
#define KCHAT_VER_PATCH 0

#define KCHAT_VERSION (KCHAT_VER_MAJOR * 10000 + KCHAT_VER_MINOR * 100 + KCHAT_VER_PATCH)

// for source code
#define _KCHAT_STR(s) #s
#define KCHAT_PROJECT_VERSION(major, minor, patch) "v" KCHAT_STR(major.minor.patch)
