cheerio = require('cheerio');
request = require('request-promise')

uri = "http://www.ziroom.com/?utm_source=pinzhuan&utm_medium=baidu&utm_term=ziru&utm_content=biaoti&utm_campaign=pinzhuan"
#uri = "https://zh.flightaware.com/live/flight/CHH7737/history"

options =
  uri:uri,
  transform:(body)->
    return cheerio.load(body)

request(options).then(
  ($)->
    slideList = $('.bd #foucsSlideList')
    slideListData = []

    for k in slideList.find('li')
      pic = $(k)
      pic_href = pic.find('a').attr('href')
      pic_src = pic.find('a').children('img').attr('_src')
      pic_message = pic.find('a').children('img').attr('alt')
      slideListData.push({
        pic_href : pic_href,
        pic_message : pic_message,
        pic_src : pic_src
      });

    console.log(JSON.stringify(slideListData,null,2))
).catch(
  (err)->
    console.log("error==>"+err.message)
)
