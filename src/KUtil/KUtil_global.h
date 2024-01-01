
#pragma once
#include <QtCore/qglobal.h>

#if defined(KUTIL_LIBRARY)
#  define KUTIL_EXPORT Q_DECL_EXPORT
#else
#  define KUTIL_EXPORT Q_DECL_IMPORT
#endif
