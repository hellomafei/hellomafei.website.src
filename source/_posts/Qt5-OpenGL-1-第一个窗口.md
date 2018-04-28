---
title: Qt5 OpenGL(1) - 第一个窗口
categories:
  - OpenGL图形与图像
date: 2018-04-28 11:40:32
---

　　本视频是《音视频编程》的一条支线。怎么回事呢？因为视频由三个部分组成：图像、音频和字幕。图像需要一个介质来显示.现在是开始学习Qt的好时机，因为很多OpenGL功能在Qt框架内不断发展。其中一个新的事情是QOpenGL*类的添加（QGL*类的替代品）。我这里的介质选择的是Qt的QOpenGLWidget，这里的原因不再展开来讲。本系列不局限于音视频的应用，如果对opengl和Qt封装的OpenGL api感兴趣，倒是可以一观。

<!--more-->

<div class="tip">
本系列会刻意的不使用类似freeglut、glfw、glew、glad等等第三方gl工具或者库。这样做的目的我暂时是这么考虑的：如果尽可能的少依赖其他库或工具，尽量只用OpenGL和Qt封装的GL api，这样会容易编译在其他平台，不过带来的问题是，依赖Qt的紧密度会增强甚至不可或缺。
</div>

#### <font color="#42B983">#</font> 小标题1

　　正文1