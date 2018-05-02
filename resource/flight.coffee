cheerio = require('cheerio');
request = require('request-promise')

uri = "https://zh.flightaware.com/live/flight/CES5183/history/320"
options =
  uri:uri,
  headers:
    Cookie: '_ga=GA1.2.289699961.1524472962; __qca=P0-410945491-1524472981388; __gads=ID=c1474cb6987366a7:T=1524474995:S=ALNI_MasoOZzKtEgSJVfrwzPoTpuxx6XUA; d7s_uid=jgc13dzfkviv0t; _gid=GA1.2.1128052865.1525227502; update_time=1525248702; w_sid=849b62c407e52478e0a3dde6ab909f9c7010160ea21c1f0b95f5fd62ff507bf4; _gat=1; __rtgt_sid=jgotp4yuzw1mqp; d7s_spc=2; _ceg.s=p83dfl; _ceg.u=p83dfl'
  transform:(body)->
    return cheerio.load(body)

request = request.defaults({jar: true})
request(options).then(
  ($)->
    table = $('.pageContainer').find('table').children().last()
    slideListData = []
    for k in table.find('tr')
      item = {}
      for td,index in $(k).find('td')
        item.date =$(td).find('a').text()  if index is 0
        item.type =$(td).text()  if index is 1
        item.dep =$(td).text()  if index is 2
        item.arr =$(td).text() if index is 3
        item.real_start =$(td).text() if index is 4
        item.real_end =$(td).text()  if index is 5
        item.duration =$(td).text() if index is 6
      slideListData.push(item)

    console.log(JSON.stringify(slideListData,null,2))
    console.log(slideListData.length)
).catch(
  (err)->
    console.log("error==>"+err.message)
)
