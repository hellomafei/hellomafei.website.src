---
title: Qt5 OpenGL(2) - 你好，三角形！
categories:
  - OpenGL图形与图像
date: 2018-04-28 23:20:38
---

　　相信很多人都看过 [learnopengl](http://learnopengl-cn.readthedocs.io/zh/latest/) 的教程。但是很苦恼的是几乎所有的 OpenGL 教程都都会使用类似 GLEW、GLFW、GLAD 等等 GL 的第三方工具或者库。有什么版本能在 Qt 里面使用跨平台的 OpenGL Functions 呢？看这篇你就知道大概的一个流程，能对应着找到其他教程写法和对应Qt OpenGL的 api 联系。

<!--more-->

<div class="tip">
本文假设你有一丢丢的 OpenGL 基础。如果没看过 OpenGL 的任何教程，推荐先花一些时间了解 OpenGL 是什么，然后通过 [learnopengl](http://learnopengl-cn.readthedocs.io/zh/latest/) 的入门系列，了解一下 OpenGL。我希望这个过程有起码一天的时间，否则以后的教程你可能看起来有些吃力。如果你花时间看了 learnopengl 的 [你好，三角形](http://learnopengl-cn.readthedocs.io/zh/latest/01%20Getting%20started/04%20Hello%20Triangle/)，你就会从本文中一一找到对应的关系。
</div>

#### <font color="#42B983">#</font> QOpenGLBuffer

　　Qt OpenGL 中的 QOpenGLBuffer 有点类似于GPU上动态内存的唯一ID。我们知道，定义顶点数据以后，我们会把它作为输入发送给图形渲染管线的第一个处理阶段：顶点着色器。它会在GPU上创建内存用于储存我们的顶点数据，还要配置 OpenGL 如何解释这些内存，并且指定其如何发送给显卡。顶点着色器接着会处理我们在内存中指定数量的顶点。learnopengl 的 [你好，三角形](http://learnopengl-cn.readthedocs.io/zh/latest/01%20Getting%20started/04%20Hello%20Triangle/) 中介绍了通过顶点缓冲对象(Vertex Buffer Objects, VBO)管理这个内存，它会在GPU内存(通常被称为显存)中储存大量顶点。使用这些缓冲对象的好处是我们可以一次性的发送一大批数据到显卡上，而不是每个顶点发送一次。从CPU把数据发送到显卡相对较慢，所以只要可能我们都要尝试尽量一次性发送尽可能多的数据。当数据发送至显卡的内存中后，顶点着色器几乎能立即访问顶点，这是个非常快的过程。
　　QOpenGLBuffer 是一个缓冲对象。在程序中，我们这样像如下方式使用它。它对应着 glGenBuffers 、 glBindBuffer 、 glBufferData。详细的，我希望你能通过对比 learnopengl 的 [你好，三角形](http://learnopengl-cn.readthedocs.io/zh/latest/01%20Getting%20started/04%20Hello%20Triangle/) 和 Qt 的文档，我这里不再用更多的文字进行解释。

```
    QOpenGLBuffer m_vertex;
    static const Vertex sg_vertexes[] = {
      Vertex( QVector3D( 0.00f,  0.75f, 1.0f), QVector3D(1.0f, 0.0f, 0.0f) ),
      Vertex( QVector3D(-0.75f, -0.75f, 1.0f), QVector3D(0.0f, 1.0f, 0.0f) ),
      Vertex( QVector3D( 0.75f, -0.75f, 1.0f), QVector3D(0.0f, 0.0f, 1.0f) )
    };
    // Create Buffer (Do not release until VAO is created)
    m_vertex.create();
    m_vertex.bind();
    m_vertex.setUsagePattern(QOpenGLBuffer::StaticDraw);
    m_vertex.allocate(sg_vertexes, sizeof(sg_vertexes));
```

#### <font color="#42B983">#</font> QOpenGLVertexArrayObject

　　一次又一次地绑定和解除绑定OpenGL缓冲区对象可能变得单调乏味。因此，引入了QOpenGLVertexArrayObjects（VAO）。
　　想了解更多的话，参看 learnopengl 的 [你好，三角形](http://learnopengl-cn.readthedocs.io/zh/latest/01%20Getting%20started/04%20Hello%20Triangle/) 中的 <顶点数组对象> 小节。这里我们又把 learnopengl 中的写法对应上了 Qt OpenGL 的 api。

#### <font color="#42B983">#</font> QOpenGLShaderProgram

　　通常对于初次使用 OpenGL 的用户来说，着色器有点棘手。 但是，Qt5提供了一个 QOpenGLShaderProgram 类的功能抽象，使我之变得更加轻松。这里对应着 learnopengl 的 [你好，三角形](http://learnopengl-cn.readthedocs.io/zh/latest/01%20Getting%20started/04%20Hello%20Triangle/) 中的 <顶点着色器> 和 <片段着色器> 的使用。本文不再过多叙述。

#### <font color="#42B983">#</font> 总结

　　通过以上了解，你会发现能和 learnopengl 的 [你好，三角形](http://learnopengl-cn.readthedocs.io/zh/latest/01%20Getting%20started/04%20Hello%20Triangle/) 教程一一做到对应。如果你还不知道怎么来应用，请看我在GitHub 上放出的 [test03_qopenglwidget](https://github.com/hellomafei/TestProjectAggregation/tree/master/qt5.9.5_test) 源码对应着学习。仔细研究你会发现，这是个很简单的过程。