#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'json'
require 'yaml'

day = []
program = []

def day_specifier(string)
	string == "Day 1" || string == "Day 2"
end

doc = Nokogiri::HTML(File.open("index_tracks.html"))
doc.xpath("//table//table//table/tr").each do |tr|
	if day_specifier(tr.text.strip)
		program << day unless day.empty?
		day = []
		next
	end
	time = tr.xpath("td[@bgcolor='#dddddd']").text
	print "!!!!!!!!!!!!!!!!!! time = #{time}\n"
	sessions = []
	tr.xpath("td[position()>1]").each do |cell|
		track, throwaway, title, throwaway, speaker = cell.children
		sessions << { :track => track.text.strip, :title => title ? title.text.strip : nil, :speakers => speaker ? speaker.text.strip : nil }
	end
	day << { :time => time, :sessions => sessions }
end



program << day unless day.empty?

print program.to_json
print program.to_yaml
