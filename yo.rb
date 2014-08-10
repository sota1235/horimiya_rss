#!/usr/bin/ruby

require 'open-uri'
require 'nokogiri'
require 'kconv'
require 'net/http'

# 各話の情報をクローリング
url = "http://dka-hero.com/h_01.html"
new = "" # 最新話

# Yo API
yo_url = 'http://api.justyo.co/yoall/'
api_token = 'hogehoge'

while true do
  html = open(url).read
  doc = Nokogiri::HTML(html.toutf8, nil, 'utf-8')
  episodes = doc.xpath('//a[@target="contents"]')
  title = episodes[-3].inner_text.to_s
  if new == title
    puts "最新話の更新はありません"
  else
    puts "最新話の更新がありました：" + title
    Net::HTTP.post_form(URI.parse(yo_url), {'api_token' => api_token})
    new = title
  end
  sleep 60 * 30
end

puts "最新話は" + title
