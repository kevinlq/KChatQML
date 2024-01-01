#pragma once
#include <QObject>

//See Gist Comment for description, usage, warnings and license information

/*
 * 自动生成类的成员变量以及对应的属性, 主要有是三种
    1.AUTO_PROPERTY： 包含了该变量的所有属性，读/写/改变信号
    2.READONLY_PROPERTY: 仅读，没有写方法和信号
    3.READ_PROPERTY: 仅读，但是包含了属性改变信号
 *
 * type: 变量类型，如 int, QString, std::string
 * typeName: 类型名称缩写， QString->s, int->n, bool->b
 * variableName: 变量名字
 *
 * 信号前面加前缀s,表示信号.
*/
#define AUTO_PROPERTY(type, typeName ,variableName, defaultValue) \
    Q_PROPERTY(type variableName READ get##variableName WRITE set##variableName NOTIFY s##variableName##Changed ) \
    public: \
    inline type get##variableName() const { return m_##typeName##variableName ; } \
    inline void set##variableName(const type& value) { \
    if (m_##typeName##variableName == value)  return; \
    m_##typeName##variableName = value; \
    emit s##variableName##Changed(value); \
    } \
    Q_SIGNAL void s##variableName##Changed(const type &value);\
    private: \
    type m_##typeName##variableName = defaultValue;

#define READONLY_PROPERTY(type, typeName, variableName) \
    Q_PROPERTY(type variableName READ get##variableName CONSTANT ) \
    public: \
    inline type get##variableName() const { return m_##typeName##variableName ; } \
    private: \
    type m_##typeName##variableName;

#define READ_PROPERTY(type, typeName, variableName) \
    Q_PROPERTY(type variableName READ variableName NOTIFY s##variableName##Changed) \
    public: \
    inline type get##variableName() const { return m_##typeName##variableName ; } \
    Q_SIGNAL void s##variableName##Changed(const type &value);\
    private: \
    type m_##typeName##variableName;

//
#define Q_PROPERTY_AUTO(TYPE, M)                                                                                       \
  Q_PROPERTY(TYPE M MEMBER _##M NOTIFY M##Changed)                                                                     \
public:                                                                                                                \
  Q_SIGNAL void M##Changed();                                                                                          \
  void M(const TYPE& in_##M)                                                                                           \
  {                                                                                                                    \
    if (_##M == in_##M)  return;                                                                                       \
    _##M = in_##M;                                                                                                     \
    Q_EMIT M##Changed();                                                                                               \
  }                                                                                                                    \
  TYPE M() const                                                                                                       \
  {                                                                                                                    \
    return _##M;                                                                                                       \
  }                                                                                                                    \
                                                                                                                       \
private:                                                                                                               \
  TYPE _##M;
