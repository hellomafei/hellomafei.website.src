# Hexo for "Horse"

![Show Page 1](/img/showpage1.png)

![Show Page 2](/img/showpage2.png)

![Show Page 3](/img/showpage3.png)

[Hexo](https://hexo.io/), a fast, simple & powerful blog framework, powered by [Node.js](http://nodejs.org).

## Premise

- Change your _config.yml "repository" to your user.Github.io's clone URL.
- install nodejs
- install npm
- install hexo-cli


## Installation

``` bash
$ git clone git clone git@github.com:hellomafei/hellomafei.website.src.git
$ cd hellomafei.website.src.git
$ npm install
```

## Test

``` bash
$  hexo new post "Blog name"
// write "Blog name.md"
$  hexo clean
$  hexo g
$  hexo server --debug
```

## Deploy

``` bash
$  hexo new post "Blog name"
// write "Blog name.md"
$  hexo clean
$  hexo d -g
```