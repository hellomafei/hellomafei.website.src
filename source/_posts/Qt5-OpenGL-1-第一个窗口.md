---
title: Qt5 OpenGL(1) - 第一个窗口
categories:
  - OpenGL图形与图像
date: 2018-04-28 11:40:32
---

　　本视频是《音视频编程》的一条支线。怎么回事呢？因为视频由三个部分组成：图像、音频和字幕。图像需要一个介质来显示。现在是开始学习Qt的好时机，因为很多OpenGL功能在Qt框架内不断发展。其中一个新的事情是QOpenGL··类的添加（QGL··类的替代品）。我这里的介质选择的是Qt的QOpenGLWidget，这里的原因不再展开来讲。本系列不局限于音视频的应用，如果对opengl和Qt封装的OpenGL api感兴趣，倒是可以一观。

<!--more-->

<div class="tip">
Qt使用的是5.9.5版本，编译器为MSVC2015_32和MingW53_32（Qt5.9.5自带），我会分别在两种编译器下编译通过。以后除例外不再特别说。本系列会刻意的不使用类似freeglut、glfw、glew、glad等等第三方gl工具或者库，这样做的目的我暂时是这么考虑的：如果尽可能的少依赖其他库或工具，尽量只用OpenGL和Qt封装的GL api，这样会容易编译在其他平台，不过带来的问题是，依赖Qt的紧密度会增强甚至不可或缺。和以往一样，我这里假设你Qt/C++的水平起码是个基础，如果了解OpenGL api将更好的帮助你阅读本系列。
</div>

#### <font color="#42B983">#</font> 前言

　　为了方便起见，我会选择将 QOpenGLWidget 和 QOpenGLFunctions 一块继承。在Qt的目前版本中，不再需要glew等一些列其他第三方gl工具或库，并且 QOpenGLFunctions 默认为允许访问 OpenGL ES 2.0 API 结构。如果你不想通过继承子类来访问 QOpenGLFunctions 的功能，你可以通过QOpenGLContext获取可用的函数。

```
QOpenGLFunctions functions(QOpenGLContext::currentContext());
functions.glFunctionHere();
// or...
QOpenGLFunctions *functions = QOpenGLContext::currentContext()->functions();
functions->glFunctionHere();
```

　　QOpenGLFunctions 默认为 OpenGL ES 2.0的原因是出于兼容性原因，所以我们可以轻松地将产品移植到嵌入式平台（如Android和iOS）。我们的例子将使用这个函数上下文，但我们也可以要求特定的函数上下文（例如QOpenGLFunctions_4_3_Core）。除了OpenGL ES 2.0 API之外，我们没有任何需求，所以我将坚持使用QOpenGLFunctions 类。

```
class HsOpenGLWidget : public QOpenGLWidget, protected QOpenGLFunctions
{
    Q_OBJECT
public:
    explicit HsOpenGLWidget(QWidget* parent = nullptr);

protected:
    void initializeGL();
    void paintGL();
    void resizeGL(int w, int h);
};
```

#### <font color="#42B983">#</font> 创建窗口

　　我们只需要创建我们的类继承自 QOpenGLWidget 和 QOpenGLFunctions，并且重写以下三个虚函数。顾名思义，这三个函数分别起到OpenGL上下文执行初始化、绘制和检测窗体大小变化的功能。接下来我们试着实现这三个函数。

```
void HsOpenGLWidget::initializeGL()
{
    //Initialize OpenGL Backend
    initializeOpenGLFunctions();

    // Set global information
    glClearColor(0.0f, 0.0f, 1.0f, 1.0f);
}

void HsOpenGLWidget::paintGL()
{
    glClear(GL_COLOR_BUFFER_BIT);
}

void HsOpenGLWidget::resizeGL(int w, int h)
{
    glViewport(0, 0, w, h);
}
```

#### <font color="#42B983">#</font> 后话

　　如果你想知道你的上下文使用的opengl是什么版本的话，你可以使用以下代码（本文代码由于过于简单，这里不再进行太多解释）。

```
    //print Context Information
    QString glType;
    QString glVersion;
    QString glProfile;

    // Get Version Information
    glType = (context()->isOpenGLES()) ? "OpenGL ES" : "OpenGL";
    glVersion = reinterpret_cast<const char*>(glGetString(GL_VERSION));

    // Get Profile Information
#define CASE(c) case QSurfaceFormat::c: glProfile = #c; break
    switch (format().profile())
    {
    CASE(NoProfile);
    CASE(CoreProfile);
    CASE(CompatibilityProfile);
    }
#undef CASE

    // qPrintable() will print our QString w/o quotes around it.
    qDebug() << qPrintable(glType) << qPrintable(glVersion) << "(" << qPrintable(glProfile) << ")";
```

　　我通过打印发现我这里输出 “OpenGL 4.4.0 - Build 20.19.15.4300 ( CompatibilityProfile )”，我通过编译(什么鬼？Qt的项目还能编译在安卓上？是的你没有看错，如果有兴趣请看我的这篇博客···)在我的小米5（Android 7.0）手机上发现，输出的是“OpenGL ES 2.0 bulid 1.3···”，从这里可以知道，Qt将openg api封装的更适宜跨平台。如果我想规定使用 OpenGL 3.3 的话，我们需要在构造函数里添加如下代码。如果不更换环境的话，这可能是我们唯一测试以上输出版本的途径了。不过我不建议这么写，我没有必须使用3.3或者其他特定版本的需求。

```
    QSurfaceFormat format;
    format.setRenderableType(QSurfaceFormat::OpenGL);
    format.setProfile(QSurfaceFormat::CoreProfile);
    format.setVersion(3,3);
    this->setFormat(format);
```