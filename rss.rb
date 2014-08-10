#!/usr/bin/ruby

require 'open-uri'
require 'nokogiri'
require 'kconv'

# 各話の情報をクローリング
url = "http://dka-hero.com"
list_url = "/h_01.html" # マンガ一覧のページ
num = 1
comics = []

html = open(url + list_url).read

doc = Nokogiri::HTML(html.toutf8, nil, 'utf-8')

doc.xpath('//a[@target="contents"]').slice(2..-3).each do |v|
  title = v.inner_text.to_s.gsub('/', '_')
  href = '/' + v.attribute('href').to_s
  comics.push([url + href, title])
end
comics.delete_at(140)

puts comics
puts "最新話は" + comics.length.to_s
