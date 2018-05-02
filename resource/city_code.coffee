cheerio = require('cheerio');
request = require('request-promise')

uri = "https://airportcode.911cha.com/"

#https://airportcode.911cha.com/list_2.html
for page in  [1..284]
  uri = "https://airportcode.911cha.com/list_#{page}.html"
  uri = "https://airportcode.911cha.com" if page is 1
  options =
    uri:uri,
    transform:(body)->
      return cheerio.load(body)

#  new Promise()
  request(options).then(
    ($)->
  #    console.log('city_code==>')
      table = $('.mcon').find('table').find('tbody')
      slideListData = []
      for k in table.find('tr')
        item = {}
        for td,index in $(k).find('td')
          item.city_name =$(td).text()  if index is 0
          item.airport_three_code =$(td).text()  if index is 1
          item.airport_four_code =$(td).text()  if index is 2
          item.airport_name =$(td).text()  if index is 3
          item.airport_en_name =$(td).text()  if index is 4
        slideListData.push(item)

      console.log(JSON.stringify(slideListData,null,2))

#      console.log(slideListData.length) if page is 284
  ).catch(
    (err)->
      console.log("error==>"+err.message)
  )


