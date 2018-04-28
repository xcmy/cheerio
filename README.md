### cheerio

基于CoffeeScript的爬虫简单实现，使用***request-promise***配置***cheerio***



#### package.json

###### cheerio安装
```
npm install cheerio
```
###### request-promise 安装
```
npm install request-promise
```

#### 初始化配置

```
cheerio = require('cheerio');
request = require('request-promise')

uri = 'http://www.baidu.com'
options =
  uri:uri,
  transform:(body)->
    return cheerio.load(body)

```


#### 使用

```
request(options).then(
  ($)->
    console.log($.html())
).catch(
  (err)->
    console.log("error==>"+err.message)
)

```
