cheerio = require('cheerio');
request = require('request-promise')
iconv = require('iconv-lite');


#iconv = new Iconv('GBK', 'UTF-8');

uri = "http://trip.taobao.com/sitemap/jipiao-airlines.html?spm=181.7207825.a214ciw.4"
options =
  uri:uri,
  transform:(body)->

    return cheerio.load(body)

request(options).then(
  ($)->
    slideList = $('.airports')
    slideListData = []

#    console.log(slideList.text())

    for k in slideList.find('li')
#      pic = $(k)
      for k in $(k).find('ul').find('li')
#        console.log($(k).text())
        console.log(iconv.decode(Buffer.from($(k).text()), 'win1251'))

        slideListData.push({title:$(k).find('a').text()})

#      pic_href = pic.find('a').attr('href')
#      pic_src = pic.find('a').children('img').attr('_src')
#      pic_message = pic.find('a').children('img').attr('alt')
#      slideListData.push({
#        pic_href : pic_href,
#        pic_message : pic_message,
#        pic_src : pic_src
#      });


    console.log(JSON.stringify(slideListData,null,2))
    console.log(slideListData.length)
).catch(
  (err)->
    console.log("error==>"+err.message)
)
