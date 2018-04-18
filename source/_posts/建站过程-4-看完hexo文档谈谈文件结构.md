---
title: 建站过程(4) - 看完hexo文档谈谈文件结构
date: 2018-04-16 22:24:44
categories: 
- Hexo+GitHub建站
---

　　静态网站搭建好了，博客也写了几篇，突然觉得主题还是差那么一点才对自己胃口。怎么办呢？来通读下[Hexo文档](https://hexo.io/zh-cn/docs/)，然后对应整个文件结构看下生成静态网站源码(/public)的过程。了解了这个过程，自定义主题也就顺畅多了。

<!--more-->

<div class="tip">
请通读下Hexo文档，否则整篇博客都是简述你可能看不明白哟~
</div>


#### <font color="#42B983">#</font> 读Hexo文档

- [Hexo中文文档](https://hexo.io/zh-cn/docs/)
- [Hexo英文文档](https://hexo.io/docs/)

#### <font color="#42B983">#</font> 看source文件夹

　　[资源文件夹](https://hexo.io/zh-cn/docs/asset-folders.html) 除了文章以外的所有文件，例如图片、CSS、JS 文件等。如果你运行了 hexo g 命令的话，这里的文件除了下划线开头和隐藏文件或文件夹都会被拷贝倒public文件夹内。


#### <font color="#42B983">#</font> 看public文件夹

　　[生成文件](https://hexo.io/zh-cn/docs/generating.html)，Hexo 生成静态文件快速而且简单，一条命令 hexo g 就把静态文件生成在public文件夹内。
　　我们看下public的文件结构，有心的的人会发现：根目录下有个index.html、archives目录下也有个index.html。如果你在浏览器中打开过这两个html文件的话，你会发现这两个静态html文件分别就是静态网站的主页面和archives页面。转到主题文件夹/themes/apollo看下_config.yml的内容，再从[主题](https://hexo.io/zh-cn/docs/themes.html)和[模板](https://hexo.io/zh-cn/docs/templates.html)对应这看，你大概会明白这个生成静态文件的过程。
　　通过读[主题](https://hexo.io/zh-cn/docs/themes.html)文档我们知道，/public这里的html文件正式由主题中的布局文件夹来布局生成的。如果你打算自定义主题，就要从这里下手。

#### <font color="#42B983">#</font> 改下博客配置

　　通过[配置文档](https://hexo.io/zh-cn/docs/configuration.html)我改了一部分配置，比如说网站标题、网站描述、网址等等。如果你也想试试，看着配置文档对应改改，然后 hexo g & hexo s 测试看看。

#### <font color="#42B983">#</font> 设想有一个分类页面

　　我希望我的博客有一个分类页面，我这里说的分类不同于ARCHIVE归档。通过读[Front-matter文档](https://hexo.io/zh-cn/docs/front-matter.html)我了解到，文章中可以设置categories来分类。我这里将写好的几篇文章分了两类。 hexo g 之后，在/public文件夹中我发现多了个categories文件夹，而且里面有两个文件夹，这俩文件夹正式我设置的两个分类。并且，每个分类文件夹里面都有一个index.html文件。也就是说，如果我们想查看分类的话，需要在url后面加上/categories/分类名/才能对应倒那个index.html文件。
　　你可以改下主题下的_config.yml文件中的menu，列出来一个categories页，后面填上相对路径/categories/其中一个分类名/。不过，我打算要的这个分类页面，是要显示整个分类和分类下的文章题目。这样怎么做呢？
　　我目前这么做的，我在source下建立一个categories文件夹，里面放置一个index.html，生成之后在静态文件夹的categories目录下就会多一个index.html。然后将主题下的_config.yml文件的menu下的categories后面改为/categories/，这样就可以有这个主页面。不过肯定不是这么做的，我通过初步了解，这个index.html是通过主题下的layout生成的，等我再研究研究。