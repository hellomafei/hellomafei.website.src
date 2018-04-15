---
title: 建站过程(2) - hexo 和 GitHub 结合部署静态网站
date: 2018-04-15 18:03:52
tags:
---


/* 初次使用 */

github 上建立两个项目 

    hellomafei.website.src （存放hexo源码）
    hellomafei.github.io （存放静态源码）
    
本地创建 hellomafei.website.src 文件夹且 cd hellomafei.website.src

初始化

    hexo init
    
删除默认主题 themes/landscape

增加主题 

git clone https://github.com/pinggod/hexo-theme-apollo.git themes/apollo 

删除 themes/apollo 中的 README.md 和 LICENSE .git文件夹

_config.yml
    theme: apollo

# 在归档页面显示所有文章
# 需要上面安装的 hexo-generator-archive 插件支持
archive_generator:
    per_page: 0
    yearly: false
    monthly: false
    daily: false
    
    
回到 hellomafei.website.src 根目录

cnpm install

cnpm install --save hexo-renderer-jade hexo-generator-feed hexo-generator-sitemap hexo-browsersync hexo-generator-archive

cnpm install hexo-deployer-git --save


//关联 public文件夹 --> hellomafei.github.io.git

deploy:
    type: git
    repository: git@github.com:hellomafei/hellomafei.github.io.git
    branch: master

//本地写一篇博客并且测试

hexo new post "博客名"

使用markdown语法改写 /source/_posts/博客名.md

生成静态文件
hexo g 

开启服务
hexo s

http://localhost:4000/


测试文章写得不错 要生成静态网页并部署到hellomafei.github.io

hexo d -g

最后把hellomafei.website.src源码推送到远端

git init

使用Git Gui 将所有改动缓存 （这里我知道git add怎么添加所有改动，如果没有Git Gui ##的话 推荐git add 一个一个加（git status查看改动））

git commit -m "commit 信息"

git remote add origin git@github.com:hellomafei/hellomafei.website.src.git

git push -u origin master









换了电脑怎么做？

git clone git@github.com:hellomafei/hellomafei.website.src.git

进入 

cnpm install


