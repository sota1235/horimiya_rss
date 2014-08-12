#!/usr/bin/ruby

require 'open-uri'
require 'nokogiri'
require 'kconv'
require 'rss'

def make_rss
  # 各話の情報をクローリング
  url = "http://dka-hero.com"
  list_url = "/h_01.html" # マンガ一覧のページ
  comics = []

  html = open(url + list_url).read

  doc = Nokogiri::HTML(html.toutf8, nil, 'utf-8')

  doc.xpath('//a[@target="contents"]').slice(2..-3).each do |v|
    title = v.inner_text.to_s
    href = '/' + v.attribute('href').to_s
    comics.push([url + href, title])
  end
  comics.delete_at(140)
  comics = comics.reverse

  # for debug
  # puts comics
  # puts "最新話は" + comics.length.to_s

  # make RSS
  rss = RSS::Maker.make("2.0") do |maker|
    maker.channel.title = "読解アヘン：堀さんと宮村くん"
    maker.channel.description = "HEROさんによるWebマンガです"
    maker.channel.link = url
    # make items
    comics.each do |comic|
      item = maker.items.new_item
      item.link = comic[0]
      item.title = comic[1]
    end
  end

  return rss.to_s
  # for debug
  # puts rss.to_s
end
