---
title: 建站过程(2) - hexo 和 GitHub 结合部署静态网站
date: 2018-04-15 18:03:52
tags: Hexo/GitHub建站
desc: Hexo+GitHub搭建个人博客
---

　　假如你没有云服务器，但是又囊中羞涩不想购买云服务器，那么用Hexo+GitHub建立一个静态的网站或博客也是一个不错的选择！而且你还可以购买域名解析到对应的Github-Pages的URL上。不花钱而且能存上自己写的笔记博客，甚至自己写的app也有show-web了，可以说是非常美滋滋了~

<!--more-->

<div class="tip">
本文假设你的电脑上已经部署好了Git、nodejs、npm(&cnpm)和hexo-cli，会简单的使用GitHub
</div>

#### <font color="#42B983">#</font> GitHub 配置


- GitHub上建立两个项目，假设你的用户名是hellomafei
- [hellomafei.website.src](https://github.com/hellomafei/hellomafei.website.src) （存放hexo源码，项目名随意取，是放Hexo网站框架代码的地方）
- [hellomafei.github.io](https://github.com/hellomafei/hellomafei.github.io) （存放静态网页源码，项目名固定格式，必须是"用户名.github.io"）

    
#### <font color="#42B983">#</font> 初始化 & 搭建

- 本地创建 hellomafei.website.src 文件夹且 cd hellomafei.website.src，这里为什么不clone上一步建立的空项目呢，因为下一步hexo init过程中，会clone下来Hexo的东西，这样就冲突了，所以这里建立空文件夹。不过你也可以clone下来之后在其他文件夹hexo init，这里不再赘述
- hexo init
- 删除默认主题 themes/landscape，你也可以使用默认主题，如果打算使用默认主题，下步跳过。更多主题请访问[Hexo](https://hexo.io/themes/)
- git clone https://github.com/pinggod/hexo-theme-apollo.git themes/apollo
- 删除 themes/apollo 中的.git文件夹，这里怕与主GitHub项目（hellomafei.website.src）冲突
- (hellomafei.website.src根目录下)_config.yml --> theme: apollo，更多设置请查看[pinggod/hexo-theme-apollo](https://github.com/pinggod/hexo-theme-apollo)

- 回到 hellomafei.website.src 根目录
```
$ cnpm install
$ cnpm install --save hexo-renderer-jade hexo-generator-feed hexo-generator-sitemap hexo-browsersync hexo-generator-archive
$ cnpm install hexo-deployer-git --save
```

- 关联 public文件夹 --> hellomafei.github.io.git，修改hellomafei.website.src 根目录下的_config.yml
```
deploy:
    type: git
    repository: git@github.com:hellomafei/hellomafei.github.io.git
    branch: master
```

#### <font color="#42B983">#</font> 测试

```
$ hexo new post "博客名"
// 使用markdown语法改写 /source/_posts/博客名.md
$ hexo g //生成静态文件
$ hexo s //开启服务
// http://localhost:4000/
```

#### <font color="#42B983">#</font> 发布

- 测试文章写得不错 要生成静态网页并部署到hellomafei.github.io

```
$ hexo d -g
```

- 最后把hellomafei.website.src源码推送到远端

```
$ git init
```

- 使用Git Gui 将所有改动缓存 （这里我不知道知道git add怎么添加所有改动,如果没有Git Gui ##的话 推荐git add 一个一个加（git status查看改动））

<div class="tip">
这里千万不要用 git add . ，貌似会把node_modules也加进去，这个文件夹里面几十万个文件和文件夹！
</div>

```
$ git commit -m "commit 信息"
$ git remote add origin git@github.com:hellomafei/hellomafei.website.src.git
$ git push -u origin master
```

#### <font color="#42B983">#</font> 换了电脑怎么做？

- 克隆GitHub项目

```
$ git clone git@github.com:hellomafei/hellomafei.website.src.git
```

- 安装npm包模块

```
$ npm(&cnpm) install
```

- 测试

- 发布