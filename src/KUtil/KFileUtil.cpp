#include "KFileUtil.h"

#include <QFile>
#include <QFileInfo>
#include <QDir>

KFileUtil::KFileUtil()
{
}

bool KFileUtil::createPath(const QString &dirPath)
{
    QDir dir(dirPath);
    if(dir.exists()) {
        return true;
    }
    return dir.mkpath(dirPath);
}
